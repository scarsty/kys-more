{* UltraStar Deluxe - Karaoke Game
 *
 * UltraStar Deluxe is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to the COPYRIGHT
 * file distributed with this source distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING. If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 *
 * $URL: svn://svn.code.sf.net/p/ultrastardx/svn/trunk/src/base/UConfig.pas $
 * $Id: UConfig.pas 2656 2010-10-10 18:55:31Z tobigun $
 *}

unit UConfig;

// -------------------------------------------------------------------
// Note on version comparison (for developers only):
// -------------------------------------------------------------------
// Delphi (in contrast to FPC) DOESN'T support MACROS. So we
// can't define a macro like VERSION_MAJOR(version) to extract
// parts of the version-number or to create version numbers for
// comparison purposes as with a MAKE_VERSION(maj, min, rev) macro.
// So we have to define constants for every part of the version here.
//
// In addition FPC (in contrast to delphi) DOES NOT support floating-
// point numbers in $IF compiler-directives (e.g. {$IF VERSION > 1.23})
// It also DOESN'T support arithmetic operations so we aren't able to
// compare versions this way (brackets aren't supported too):
//   {$IF VERSION > ((VER_MAJ*2)+(VER_MIN*23)+(VER_REL*1))}
//
// Hence we have to use fixed numbers in the directives. At least
// Pascal allows leading 0s so 0005 equals 5 (octals are
// preceded by & and not by 0 in FPC).
// We also fix the count of digits for each part of the version number
// to 3 (aaaiiirrr with aaa=major, iii=minor, rrr=release version)
//
// A check for a library with at least a version of 2.5.11 would look
// like this:
//   {$IF LIB_VERSION >= 002005011}
//
// If you just need to check the major version do this:
//   {$IF LIB_VERSION_MAJOR >= 23}
//
// IMPORTANT:
//   Because this unit must be included in a uses-section it is
//   not possible to use the version-numbers in this uses-clause.
//   Example:
//     interface
//     uses
//       versions, // include this file
//       {$IF USE_UNIT_XYZ}xyz;{$IFEND}      // Error: USE_UNIT_XYZ not defined
//     const
//       {$IF USE_UNIT_XYZ}test = 2;{$IFEND} // OK
//     uses
//       {$IF USE_UNIT_XYZ}xyz;{$IFEND}      // OK
//
//   Even if this file was an include-file no constants could be declared
//   before the interface's uses clause.
//   In FPC macros {$DEFINE VER:= 3} could be used to declare the version-numbers
//   but this is incompatible to Delphi. In addition macros do not allow expand
//   arithmetic expressions. Although you can define
//     {$DEFINE FPC_VER:= FPC_VERSION*1000000+FPC_RELEASE*1000+FPC_PATCH}
//   the following check would fail:
//     {$IF FPC_VERSION_INT >= 002002000}
//   would fail because FPC_VERSION_INT is interpreted as a string.
//
// PLEASE consider this if you use version numbers in $IF compiler-
// directives. Otherwise you might break portability.
// -------------------------------------------------------------------

interface

{$IFDEF FPC}
  {$MODE Delphi}
  {$MACRO ON} // for evaluation of FPC_VERSION/RELEASE/PATCH
{$ENDIF}

//{$I switches.inc}

uses
  SysUtils;

const
  // IMPORTANT:
  // If IncludeConstants is defined, the const-sections
  // of the config-file will be included too.
  // This switch is necessary because it is not possible to
  // include the const-sections in the switches.inc.
  // switches.inc is always included before the first uses-
  // section but at that place no const-section is allowed.
  // So we have to include the config-file in switches.inc
  // with IncludeConstants undefined and in UConfig.pas with
  // IncludeConstants defined (see the note above).
{$IF Defined(MSWindows)}
  av__codec = 'avcodec-56';
  LIBAVCODEC_VERSION_MAJOR   = 56;
  LIBAVCODEC_VERSION_MINOR   = 21;
  LIBAVCODEC_VERSION_RELEASE = 102;

  av__format = 'avformat-56';
  LIBAVFORMAT_VERSION_MAJOR   = 56;
  LIBAVFORMAT_VERSION_MINOR   = 19;
  LIBAVFORMAT_VERSION_RELEASE = 100;

  av__util = 'avutil-54';
  LIBAVUTIL_VERSION_MAJOR   = 54;
  LIBAVUTIL_VERSION_MINOR   = 18;
  LIBAVUTIL_VERSION_RELEASE = 100;

  sw__resample = 'swresample-1';
  LIBRESAMPLE_VERSION_MAJOR = 1;
  LIBRESAMPLE_VERSION_MINOR = 1;
  LIBRESAMPLE_VERSION_RELEASE = 100;
  LIBSWRESAMPLE_VERSION = 1001100;
{$ELSEIF Defined(Darwin)}
  av__codec = 'libavcodec';
  LIBAVCODEC_VERSION_MAJOR   = 56;
  LIBAVCODEC_VERSION_MINOR   = 1;
  LIBAVCODEC_VERSION_RELEASE = 100;

  av__format = 'libavformat';
  LIBAVFORMAT_VERSION_MAJOR   = 56;
  LIBAVFORMAT_VERSION_MINOR   = 4;
  LIBAVFORMAT_VERSION_RELEASE = 101;

  av__util = 'libavutil';
  LIBAVUTIL_VERSION_MAJOR   = 54;
  LIBAVUTIL_VERSION_MINOR   = 7;
  LIBAVUTIL_VERSION_RELEASE = 100;

  sw__resample = 'libswresample';
  LIBRESAMPLE_VERSION_MAJOR = 1;
  LIBRESAMPLE_VERSION_MINOR = 1;
  LIBRESAMPLE_VERSION_RELEASE = 100;
  LIBSWRESAMPLE_VERSION = 1001100;
{$ELSEIF Defined(android)}
  av__codec = 'ffmpeg';
  LIBAVCODEC_VERSION_MAJOR   = 56;
  LIBAVCODEC_VERSION_MINOR   = 21;
  LIBAVCODEC_VERSION_RELEASE = 102;

  av__format = 'ffmpeg';
  LIBAVFORMAT_VERSION_MAJOR   = 56;
  LIBAVFORMAT_VERSION_MINOR   = 19;
  LIBAVFORMAT_VERSION_RELEASE = 100;

  av__util = 'ffmpeg';
  LIBAVUTIL_VERSION_MAJOR   = 54;
  LIBAVUTIL_VERSION_MINOR   = 18;
  LIBAVUTIL_VERSION_RELEASE = 100;

  sw__resample = 'ffmpeg';
  LIBRESAMPLE_VERSION_MAJOR = 1;
  LIBRESAMPLE_VERSION_MINOR = 1;
  LIBRESAMPLE_VERSION_RELEASE = 100;
  LIBSWRESAMPLE_VERSION = 1001100;
{$IFEND}


{* Libraries *}

  VERSION_MAJOR   = 1000000;
  VERSION_MINOR   = 1000;
  VERSION_RELEASE = 1;

implementation

end.
