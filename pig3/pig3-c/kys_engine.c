#include "kys_engine.h"
#include <math.h>
#include <io.h>

int DrawUText(wchar_t *text, int x_pos, int y_pos, Uint32 color, int engwidth)
{
    SDL_Texture *tex;
    SDL_Surface *sur;
    SDL_Color col;
    SDL_Rect rect;
    byte r, g, b;

    GetRGBA(color, &r, &g, &b, NULL);

    col.r = r;
    col.g = g;
    col.b = b;
    rect.x = x_pos;
    rect.y = y_pos;

    sur = TTF_RenderUNICODE_Blended(KYS.Font, (Uint16 *)text, col);
    rect.h = (*sur).h;
    rect.w = (*sur).w;
    tex = SDL_CreateTextureFromSurface(KYS.render, sur);
    SDL_RenderCopy(KYS.render, tex, NULL, &rect);
    SDL_FreeSurface(sur);
    SDL_DestroyTexture(tex);
    return 0;
}

int DrawShadowText(wchar_t *text, int x_pos, int y_pos, Uint32 color1, Uint32 color2)
{
    DrawUText(text, x_pos + 1, y_pos, color2, 20);
    DrawUText(text, x_pos, y_pos, color1, 20);
}

char *ReadFileToBuffer(char *p, char *filename, int size, int needmalloc, int *filesize)
{
    FILE *fp;
    char *r = NULL;
    fp = fopen(filename, "r");
    if (fp != NULL)
    {
        if (size < 0)
        {
            fseek(fp, 0, SEEK_END);
            size = ftell(fp);
            if (filesize)
                *filesize = size;
        }
        if (needmalloc == 1)
        {
            p = (char *)malloc(size + 4);
            r = p;
        }
        fseek(fp, 0, SEEK_SET);
        fread(p, 1, size, fp);
        fclose(fp);
    }
    else
    {
        if (needmalloc == 1)
            r = NULL;
    }
    return r;
}

void FreeFileBuffer(char *p)
{
    if (!p)
        free(p);
}

int LoadPNGTiles(char *path, PNGIndex **P, SDL_Texture ***T, SDL_Surface ***S, int LoadPic)
{
    const int maxCount = 9999;

    FILE *fp;
    char c[255], c_0[255];
    short int *p;
    int size, Count, i, k, result;
    PNGIndex *pi;


    sprintf(c, "%s%s", path, "/index.ka");
    printf("Searching index of png files ... %s\n", c);

    p = (short int *)ReadFileToBuffer(NULL, c, -1, 1, &size);
    result = 0;

    for (i = size / 4; i >= 0; i--)
    {
        sprintf(c, "%s/%d.png", path, i);
        if (access(c, 0) == 0)
        {
            result = i + 1;
            break;
        }
        else
        {
            sprintf(c_0, "%s/%d.png", path, i);
            if (access(c_0, 0) == 0)
            {
                result = i + 1;
                break;
            }
        }
    }

    *P = (PNGIndex *)malloc(sizeof(PNGIndex) * result);
    pi = *P;
    Count = 0;
    for (i = 0; i < result; i++)
    {
        pi[i].FileNum = i;
        pi[i].PointerNum = -1;
        pi[i].Frame = 0;
        pi[i].CurPointer = NULL;
        sprintf(c, "%s/%s/%d.png", KYS.AppPath, path, i);
        if (access(c, 0) == 0)
        {
            pi[i].PointerNum = Count;
            pi[i].Frame = 1;
            Count++;
        }
        else
        {
            k = 0;
            sprintf(c, "%s/%s/%d_%d.png", KYS.AppPath, path, i, k);
            while(access(c, 0) == 0)
            {
                k++;
                if (k = 1)
                    pi[i].PointerNum = Count;
                Count++;
            }
            pi[i].Frame = k;
        }
        pi[i].x = p[i * 2];
        pi[i].y = p[i * 2 + 1];
        pi[i].Loaded = 0;
        pi[i].UseGRP = 0;
    }

    FreeFileBuffer((char *)p);

    *T = (SDL_Texture **)malloc(sizeof(SDL_Texture *) * Count);
    for(i = 0; i < result; i++)
        pi[i].BeginPointer = *T;


    if (LoadPic)
    {
        for(i = 0; i < result; i++)
        {
            LoadOnePNGTexture(path , NULL, &pi[i], LoadPic);
        }
    }
    return result;


}

void LoadOnePNGTexture(char *path, char *p, PNGIndex *P, int forceLoad)
{
    char c[255];
    SDL_Texture *temptex;

    P->CurPointerT = (SDL_Texture **)P->BeginPointer;
    P->CurPointerT += P->PointerNum;

    sprintf(c, "%s/%s/%d.png", KYS.AppPath, path, P->FileNum);

    if (((P->Loaded == 0) || (forceLoad == 1)) && (P->PointerNum >= 0) && (P->Frame > 0))
    {
        *(P->CurPointerT) = IMG_LoadTexture(KYS.render, c);
        SDL_QueryTexture(*(P->CurPointerT), NULL, NULL, &P->w, &P->h);
    }

    P->Loaded = 1;

}


int DrawPNGTile(SDL_Renderer *render, PNGIndex P, int FrameNum,
                int px, int py, SDL_Rect *region, int shadow, int alpha, Uint32 mixColor, int mixAlpha,
                double scalex, double scaley, double angle, SDL_Point *center)
{
    SDL_Rect rect;
    byte r, g, b, a, r1, g1, b1;
    boolean newtex = 0;
    SDL_Texture *tex, *tex1, *ptex;

    if (KYS.SW_SURFACE != 0)
    {
        //DrawPNGTileS(CurTargetSurface, PNGIndex, FrameNum, px, py, region, shadow, alpha, mixColor,
        //mixAlpha, scalex, scaley, angle);
        return 0;
    }
    //shadow���û�Ϸ�ʽ, �Լ�Ԥ��ֵ��
    if ((P.CurPointerT == NULL) || (*(P.CurPointerT) == NULL))
    {
        return 0;
    }
    if (P.Frame > 1)
    {
        P.CurPointerT += FrameNum % P.Frame;
    }
    tex = *(P.CurPointerT);
    rect.x = px - P.x;
    rect.y = py - P.y;
    if (region == NULL)
    {
        rect.w = P.w;
        rect.h = P.h;
    }
    else
    {
        rect.w = region->w;
        rect.h = region->h;
    }
    if ((scalex != 1) || (scaley != 1))
    {
        rect.w = (int)floor(rect.w * scalex);
        rect.h = (int)floor(rect.h * scaley);
    }
    else
    {

    }

    if ((shadow < 0) && (mixAlpha == 0))
    {
        mixColor = 0;
        mixAlpha = -25 * shadow;
    }
    if ((shadow > 0) && (mixAlpha == 0))
    {
        mixColor = 0xFFFFFFFF;
        mixAlpha = shadow * 10;
    }

    //ע����ɫ������, ���㷨�����, ��ǿ��ָ�����ɫ��mixAlpha < 0
    if ((mixAlpha > 0) && (shadow <= 0))
    {
        GetRGBA(mixColor, &r, &g, &b, NULL);
        r1 = max(0, 255 - (255 + g + b) * mixAlpha / 100);
        g1 = max(0, 255 - (255 + r + b) * mixAlpha / 100);
        b1 = max(0, 255 - (255 + r + g) * mixAlpha / 100);
        SDL_SetTextureColorMod(tex, r1, g1, b1);
    }
    else
    {
        SDL_SetTextureColorMod(tex, 255, 255, 255);
    }
    if (mixAlpha < 0)
    {
        GetRGBA(mixColor, &r, &g, &b, NULL);
        SDL_SetTextureColorMod(tex, r, g, b);
    }
    if ((mixAlpha > 0) && (shadow > 0))
    {
        GetRGBA(mixColor, &r, &g, &b, NULL);
        ptex = SDL_GetRenderTarget(render);
        tex1 = tex;
        tex = SDL_CreateTexture(render, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_TARGET, P.w, P.h);
        newtex = 1;
        SDL_SetRenderTarget(render, tex);
        SDL_SetTextureBlendMode(tex1, SDL_BLENDMODE_NONE);
        SDL_RenderCopy(render, tex1, NULL, NULL);
        SDL_SetTextureBlendMode(tex1, SDL_BLENDMODE_BLEND);
        SDL_SetRenderDrawBlendMode(render, SDL_BLENDMODE_ADD);
        SDL_SetRenderDrawColor(render, r, g, b, 255 * mixAlpha / 100);
        SDL_SetTextureBlendMode(tex, SDL_BLENDMODE_BLEND);
        SDL_RenderFillRect(render, NULL);
        SDL_SetRenderTarget(render, ptex);
    }

    if (alpha > 0)
    {
        SDL_SetTextureAlphaMod(tex, 255 * (100 - alpha) / 100);
    }
    else
    {
        SDL_SetTextureAlphaMod(tex, 255);
    }
    SDL_RenderCopyEx(render, tex, region, &rect, angle, center, SDL_FLIP_NONE);
    //SDL_RenderCopy(render, tex, nil, nil);
    if (newtex)
    {
        SDL_DestroyTexture(tex);
    }
    return 0;
}

void GetRGBA(Uint32 color, byte *r, byte *g, byte *b, byte *a)
{
#ifdef FAST
    unsigned char *tmpcolor = (unsigned char *)&color;
    if(b)*b = *tmpcolor++ & 0xff;
    if(g)*g = *tmpcolor++ & 0xff;
    if(r)*r = *tmpcolor++ & 0xff;
    if(a)*a = *tmpcolor & 0xff;
#else
    if (a) *a = color >> 24 & 0xff ;
    if (r) *r = color >> 16 & 0xff ;
    if (g) *g = color >> 8 & 0xff ;
    if (b) *b = color & 0xff ;
#endif

}

void UpdateAllScreen()
{
    SDL_RenderPresent(KYS.render);
}

void CleanKeyValue()
{
    KYS.event.key.keysym.sym = 0;
    KYS.event.button.button = 0;
}

void CheckBasicEvent()
{}