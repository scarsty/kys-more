#!/usr/bin/env python3
"""Export ground-only isometric maps using mmap1x.zip and smap1x.zip."""

from __future__ import annotations

import argparse
import io
import struct
import zipfile
from dataclasses import dataclass
from pathlib import Path

from PIL import Image


MAP_TILE_SIZE = 36
MAP_HALF_WIDTH = MAP_TILE_SIZE // 2
MAP_HALF_HEIGHT = 9
SCENE_SIZE = 64
MAIN_MAP_SIZE = 480
MAIN_MAP_SPLIT = 8
TILEMAP_WIDTH = MAP_HALF_WIDTH * (SCENE_SIZE - 1) * 2 + MAP_TILE_SIZE
TILEMAP_HEIGHT = MAP_HALF_HEIGHT * SCENE_SIZE * 2
# Fixed to the C++ RenderSceneGround logical origin. Do not derive from content bounds.
SCENE_ORIGIN_X = 1152
SCENE_ORIGIN_Y = 17
MAIN_MAP_WIDTH = MAP_TILE_SIZE * MAIN_MAP_SIZE
MAIN_MAP_HEIGHT = MAP_HALF_HEIGHT * MAIN_MAP_SIZE * 2
MAIN_MAP_TILE_WIDTH = MAIN_MAP_WIDTH // MAIN_MAP_SPLIT
MAIN_MAP_TILE_HEIGHT = MAIN_MAP_HEIGHT // MAIN_MAP_SPLIT


DrawCommand = tuple[Image.Image, tuple[int, int]]


@dataclass(frozen=True)
class TileInfo:
    name: str
    x: int = 0
    y: int = 0


class TileArchive:
    def __init__(self, archive_path: Path) -> None:
        self.archive_path = archive_path
        self.archive = zipfile.ZipFile(archive_path)
        self.tiles = self._load_tile_index()
        self.cache: dict[int, Image.Image] = {}

    def _load_tile_index(self) -> dict[int, TileInfo]:
        names = self.archive.namelist()
        offsets = self._read_offsets(names)
        tiles: dict[int, TileInfo] = {}
        for name in names:
            stem = Path(name).stem
            if Path(name).suffix.lower() != ".png":
                continue
            if stem.isdecimal():
                tile_id = int(stem)
                tiles[tile_id] = TileInfo(name, *offsets.get(tile_id, (0, 0)))
                continue
            if not stem.endswith("_0"):
                continue
            tile_stem = stem[:-2]
            if tile_stem.isdecimal():
                tile_id = int(tile_stem)
                tiles.setdefault(tile_id, TileInfo(name, *offsets.get(tile_id, (0, 0))))
        return tiles

    def _read_offsets(self, names: list[str]) -> dict[int, tuple[int, int]]:
        if "index.txt" in names:
            content = self.archive.read("index.txt").decode("utf-8", errors="ignore")
            values = [int(value) for value in __import__("re").findall(r"-?\d+", content)]
            return {
                values[index]: (values[index + 1], values[index + 2])
                for index in range(0, len(values) - 2, 3)
            }
        if "index.ka" in names:
            data = self.archive.read("index.ka")
            values = struct.unpack(f"<{len(data) // 2}h", data[:len(data) // 2 * 2])
            return {
                tile_id: (values[tile_id * 2], values[tile_id * 2 + 1])
                for tile_id in range(len(values) // 2)
            }
        return {}

    def get(self, tile_id: int) -> tuple[Image.Image, TileInfo] | None:
        if tile_id not in self.tiles:
            return None
        if tile_id not in self.cache:
            self.cache[tile_id] = Image.open(io.BytesIO(self.archive.read(self.tiles[tile_id].name))).convert("RGBA")
        return self.cache[tile_id], self.tiles[tile_id]

    def close(self) -> None:
        self.archive.close()


def read_i16_grid(path: Path, width: int, height: int, offset: int = 0) -> list[list[int]]:
    size = width * height * 2
    with path.open("rb") as data_file:
        data_file.seek(offset)
        data = data_file.read(size)
    if len(data) != size:
        raise ValueError(f"{path} does not contain a {width}x{height} int16 grid at offset {offset}.")
    values = struct.unpack(f"<{width * height}h", data)
    return [list(values[row * height:(row + 1) * height]) for row in range(width)]


def read_idx_grp(idx_path: Path, grp_path: Path) -> list[bytes]:
    offsets_data = idx_path.read_bytes()
    offsets = [0, *struct.unpack(f"<{len(offsets_data) // 4}i", offsets_data)]
    data = grp_path.read_bytes()
    return [data[offsets[index]:offsets[index + 1]] for index in range(len(offsets) - 1)]


def expand_ground(grid: list[list[int]]) -> list[list[int]]:
    expanded = [row[:] for row in grid]
    return expand_from_center(expanded)


def expand_from_center(grid: list[list[int]]) -> list[list[int]]:
    expanded = [row[:] for row in grid]
    size = len(expanded)
    if size == 0 or any(len(row) != size for row in expanded) or size % 2 != 0:
        raise ValueError("Only non-empty even square grids are supported.")
    center_left = size // 2 - 1
    center_right = size // 2
    for radius in range(1, size // 2):
        left = center_left - radius
        right = center_right + radius
        top = center_left - radius
        bottom = center_right + radius
        for y in range(top + 1, bottom):
            if expanded[left][y] <= 0:
                expanded[left][y] = expanded[left + 1][y]
            if expanded[right][y] <= 0:
                expanded[right][y] = expanded[right - 1][y]
        for x in range(left + 1, right):
            if expanded[x][top] <= 0:
                expanded[x][top] = expanded[x][top + 1]
            if expanded[x][bottom] <= 0:
                expanded[x][bottom] = expanded[x][bottom - 1]
        if expanded[left][top] <= 0:
            expanded[left][top] = expanded[left + 1][top] if expanded[left + 1][top] > 0 else expanded[left][top + 1]
        if expanded[right][top] <= 0:
            expanded[right][top] = expanded[right - 1][top] if expanded[right - 1][top] > 0 else expanded[right][top + 1]
        if expanded[left][bottom] <= 0:
            expanded[left][bottom] = expanded[left + 1][bottom] if expanded[left + 1][bottom] > 0 else expanded[left][bottom - 1]
        if expanded[right][bottom] <= 0:
            expanded[right][bottom] = expanded[right - 1][bottom] if expanded[right - 1][bottom] > 0 else expanded[right][bottom - 1]
    return expanded


def tile_position(x: int, y: int, info: TileInfo) -> tuple[int, int]:
    return (SCENE_ORIGIN_X - x * MAP_HALF_WIDTH + y * MAP_HALF_WIDTH - info.x,
            SCENE_ORIGIN_Y + x * MAP_HALF_HEIGHT + y * MAP_HALF_HEIGHT - info.y)


def main_map_tile_position(x: int, y: int, info: TileInfo) -> tuple[int, int]:
    center_x = MAP_HALF_WIDTH * (MAIN_MAP_SIZE - 1)
    return (center_x - x * MAP_HALF_WIDTH + y * MAP_HALF_WIDTH - info.x,
            x * MAP_HALF_HEIGHT + y * MAP_HALF_HEIGHT - info.y)


def build_ground_commands(
    grid: list[list[int]],
    tiles: TileArchive,
    skip_nonpositive: bool = False,
    skip_mask: list[list[bool]] | None = None,
) -> list[DrawCommand]:
    commands: list[DrawCommand] = []
    size = len(grid)
    for x in range(size):
        for y in range(size):
            if skip_mask is not None and skip_mask[x][y]:
                continue
            if skip_nonpositive and grid[x][y] <= 0:
                continue
            tile = tiles.get(grid[x][y] // 2)
            if tile is None:
                continue
            image, info = tile
            commands.append((image, tile_position(x, y, info)))
    return commands


def is_ground_only_scene_tile(tile_id: int) -> bool:
    return (
        0 <= tile_id <= 232
        or 261 <= tile_id <= 399
        or 469 <= tile_id <= 471
        or 511 <= tile_id <= 592
        or 609 <= tile_id <= 698
    )


def build_scene_ground_commands(
    earth: list[list[int]],
    building: list[list[int]],
    heights: list[list[int]],
    tiles: TileArchive,
    expand_scene_ground: bool = True,
) -> tuple[list[DrawCommand], int]:
    expanded_earth = expand_ground(earth) if expand_scene_ground else earth
    non_ground_mask = [
        [expanded_earth[x][y] > 0 and not is_ground_only_scene_tile(expanded_earth[x][y] // 2) for y in range(SCENE_SIZE)]
        for x in range(SCENE_SIZE)
    ]
    removed_earth_count = sum(
        1
        for x in range(SCENE_SIZE)
        for y in range(SCENE_SIZE)
        if non_ground_mask[x][y]
    )
    commands = build_ground_commands(expanded_earth, tiles, True, non_ground_mask)
    added_count = 0
    for x in range(SCENE_SIZE):
        for y in range(SCENE_SIZE):
            tile_value = building[x][y]
            tile_id = tile_value // 2
            if tile_value <= 0 or heights[x][y] != 0 or not is_ground_only_scene_tile(tile_id):
                continue
            tile = tiles.get(tile_id)
            if tile is None:
                continue
            image, info = tile
            commands.append((image, tile_position(x, y, info)))
            added_count += 1
    return commands, added_count + removed_earth_count


def build_main_map_commands(
    earth: list[list[int]],
    surface: list[list[int]],
    tiles: TileArchive,
) -> list[DrawCommand]:
    commands: list[DrawCommand] = []
    for x in range(MAIN_MAP_SIZE):
        for y in range(MAIN_MAP_SIZE):
            for tile_value in (earth[x][y], surface[x][y]):
                if tile_value <= 0:
                    continue
                tile = tiles.get(tile_value // 2)
                if tile is None:
                    continue
                image, info = tile
                commands.append((image, main_map_tile_position(x, y, info)))
    return commands


def render_commands(commands: list[DrawCommand]) -> Image.Image:
    if not commands:
        return Image.new("RGBA", (1, 1), (0, 0, 0, 0))
    min_x = min(position[0] for image, position in commands)
    min_y = min(position[1] for image, position in commands)
    max_x = max(position[0] + image.width for image, position in commands)
    max_y = max(position[1] + image.height for image, position in commands)
    canvas = Image.new("RGBA", (max_x - min_x, max_y - min_y), (0, 0, 0, 0))
    for image, position in commands:
        canvas.alpha_composite(image, (position[0] - min_x, position[1] - min_y))
    return canvas


def render_fixed_commands(commands: list[DrawCommand], width: int, height: int) -> Image.Image:
    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    if not commands:
        return canvas
    min_x = min(position[0] for image, position in commands)
    min_y = min(position[1] for image, position in commands)
    for image, position in commands:
        canvas.alpha_composite(image, (position[0] - min_x, position[1] - min_y))
    return canvas


def render_absolute_commands(commands: list[DrawCommand], width: int, height: int) -> Image.Image:
    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    for image, position in commands:
        canvas.alpha_composite(image, position)
    return canvas


def render_origin_commands(commands: list[DrawCommand], width: int, height: int, origin_x: int, origin_y: int) -> Image.Image:
    canvas = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    for image, position in commands:
        canvas.alpha_composite(image, (position[0] - origin_x, position[1] - origin_y))
    return canvas


def render_fixed_tilemap_commands(commands: list[DrawCommand], width: int, height: int) -> Image.Image:
    return render_absolute_commands(commands, width, height)


def pad_for_split(canvas: Image.Image, split: int) -> Image.Image:
    width = ((canvas.width + split - 1) // split) * split
    height = ((canvas.height + split - 1) // split) * split
    if width == canvas.width and height == canvas.height:
        return canvas
    padded = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    padded.alpha_composite(canvas, (0, 0))
    return padded


def autocrop(canvas: Image.Image) -> Image.Image:
    bbox = canvas.getchannel("A").getbbox()
    if bbox is None:
        return canvas
    return canvas.crop(bbox)


def is_blank_or_black(canvas: Image.Image) -> bool:
    rgba = canvas.convert("RGBA")
    alpha = rgba.getchannel("A")
    if alpha.getextrema()[1] == 0:
        return True
    visible = rgba.copy()
    visible.putalpha(255)
    return max(channel.getextrema()[1] for channel in visible.split()[:3]) <= 2


def split_main_map(canvas: Image.Image, destination_dir: Path) -> None:
    destination_dir.mkdir(parents=True, exist_ok=True)
    canvas = pad_for_split(canvas, MAIN_MAP_SPLIT)
    width = canvas.width // MAIN_MAP_SPLIT
    height = canvas.height // MAIN_MAP_SPLIT
    tile_id = 0
    for row in range(MAIN_MAP_SPLIT):
        for column in range(MAIN_MAP_SPLIT):
            chunk = canvas.crop((column * width, row * height, (column + 1) * width, (row + 1) * height))
            write_png(chunk, destination_dir / f"{tile_id}.png", False)
            tile_id += 1


def write_png(canvas: Image.Image, destination: Path, skip_blank: bool = True) -> bool:
    if skip_blank and is_blank_or_black(canvas):
        return False
    destination.parent.mkdir(parents=True, exist_ok=True)
    canvas.save(destination)
    print(destination)
    return True


def export_main_map(resource_dir: Path, output_dir: Path, mmap_tiles: TileArchive) -> None:
    earth = expand_from_center(read_i16_grid(resource_dir / "earth.002", MAIN_MAP_SIZE, MAIN_MAP_SIZE))
    surface = read_i16_grid(resource_dir / "surface.002", MAIN_MAP_SIZE, MAIN_MAP_SIZE)
    destination_dir = output_dir / "mmap-earth"
    destination_dir.mkdir(parents=True, exist_ok=True)
    canvas = render_fixed_commands(build_main_map_commands(earth, surface, mmap_tiles), MAIN_MAP_WIDTH, MAIN_MAP_HEIGHT)
    tile_id = 0
    for row in range(MAIN_MAP_SPLIT):
        for column in range(MAIN_MAP_SPLIT):
            left = column * MAIN_MAP_TILE_WIDTH
            top = row * MAIN_MAP_TILE_HEIGHT
            tile = canvas.crop((left, top, left + MAIN_MAP_TILE_WIDTH, top + MAIN_MAP_TILE_HEIGHT))
            write_png(tile, destination_dir / f"{tile_id}.png", False)
            tile_id += 1


def export_scene_maps(
    scene_data_path: Path,
    output_dir: Path,
    smap_tiles: TileArchive,
    all_scenes: bool = False,
    selected_scene_id: int | None = None,
    expand_scene_ground: bool = True,
) -> None:
    scene_stride = 6 * SCENE_SIZE * SCENE_SIZE * 2
    layer_size = SCENE_SIZE * SCENE_SIZE * 2
    scene_count = scene_data_path.stat().st_size // scene_stride
    if selected_scene_id is not None and not 0 <= selected_scene_id < scene_count:
        raise ValueError(f"Scene ID {selected_scene_id} is outside the available range 0-{scene_count - 1}.")
    affected_scenes = 0
    for scene_id in range(scene_count):
        if selected_scene_id is not None and scene_id != selected_scene_id:
            continue
        scene_offset = scene_id * scene_stride
        earth = read_i16_grid(scene_data_path, SCENE_SIZE, SCENE_SIZE, scene_offset)
        building = read_i16_grid(scene_data_path, SCENE_SIZE, SCENE_SIZE, scene_offset + layer_size)
        heights = read_i16_grid(scene_data_path, SCENE_SIZE, SCENE_SIZE, scene_offset + 4 * layer_size)
        commands, added_count = build_scene_ground_commands(
            earth,
            building,
            heights,
            smap_tiles,
            expand_scene_ground,
        )
        if added_count == 0 and not all_scenes and selected_scene_id is None:
            continue
        canvas = render_fixed_tilemap_commands(
            commands,
            TILEMAP_WIDTH,
            TILEMAP_HEIGHT,
        )
        write_png(canvas, output_dir / "smap-earth" / f"{scene_id}.png", False)
        affected_scenes += 1
    if all_scenes:
        print(f"Exported {affected_scenes} scene ground maps.")
    else:
        print(f"Exported {affected_scenes} affected scene ground maps.")


def export_battle_maps(resource_dir: Path, output_dir: Path, smap_tiles: TileArchive) -> None:
    fields = read_idx_grp(resource_dir / "warfld.idx", resource_dir / "warfld.grp")
    for field_id, field in enumerate(fields):
        if len(field) < 2 * SCENE_SIZE * SCENE_SIZE:
            continue
        values = struct.unpack(f"<{SCENE_SIZE * SCENE_SIZE}h", field[:2 * SCENE_SIZE * SCENE_SIZE])
        grid = [list(values[row * SCENE_SIZE:(row + 1) * SCENE_SIZE]) for row in range(SCENE_SIZE)]
        canvas = render_origin_commands(
            build_ground_commands(expand_ground(grid), smap_tiles, True),
            TILEMAP_WIDTH,
            TILEMAP_HEIGHT,
            -MAP_HALF_WIDTH,
            -MAP_HALF_WIDTH,
        )
        write_png(canvas, output_dir / "battle-earth" / f"{field_id}.png", False)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--game-dir", type=Path, default=Path("game"), help="Game data directory (default: game)")
    parser.add_argument("--save", type=Path, default=Path("game/save/1.zip"), help="Save ZIP or extracted s*.grp scene data")
    parser.add_argument("--output", type=Path, default=Path("game/exported_ground_maps"), help="Output directory")
    parser.add_argument("--scene-only", action="store_true", help="Export only scene ground maps")
    parser.add_argument("--all-scenes", action="store_true", help="Export every scene ground map instead of only affected scenes")
    parser.add_argument("--scene-id", type=int, help="Export only this scene ground map")
    parser.add_argument("--no-expand-ground", action="store_true", help="Do not fill empty scene ground tiles from nearby tiles")
    return parser.parse_args()


def extract_scene_data(save_path: Path) -> bytes:
    if save_path.suffix.lower() == ".zip":
        with zipfile.ZipFile(save_path) as save_file:
            scene_files = sorted(name for name in save_file.namelist() if name.startswith("s") and name.endswith(".grp"))
            if not scene_files:
                raise ValueError(f"No s*.grp scene data in {save_path}.")
            return save_file.read(scene_files[0])
    return save_path.read_bytes()


def main() -> None:
    args = parse_args()
    resource_dir = args.game_dir / "resource"
    mmap_tiles = TileArchive(resource_dir / "mmap1x.zip")
    smap_tiles = TileArchive(resource_dir / "smap1x.zip")
    try:
        if not args.scene_only:
            export_main_map(resource_dir, args.output, mmap_tiles)
        scene_data_path = args.output / ".scene_data.grp"
        scene_data_path.parent.mkdir(parents=True, exist_ok=True)
        scene_data_path.write_bytes(extract_scene_data(args.save))
        try:
            export_scene_maps(
                scene_data_path,
                args.output,
                smap_tiles,
                args.all_scenes,
                args.scene_id,
                not args.no_expand_ground,
            )
        finally:
            scene_data_path.unlink(missing_ok=True)
        if not args.scene_only:
            export_battle_maps(resource_dir, args.output, smap_tiles)
    finally:
        mmap_tiles.close()
        smap_tiles.close()


if __name__ == "__main__":
    main()
