Attribute VB_Name = "jyModule1"
'����0~319,��Ʒ0~199,�书0~92,����0~83
Public Rx_GRP(0 To 2) As String '     114,242  ����һ
Public Rx_IDX(0 To 2) As String
Public RANGER_GRP   As String '       114,242  ����ԭʼ����
Public RANGER_IDX   As String
Public ALLDEF_GRP   As String '       440,000  �������¼�����(ԭʼ����)
Public ALLDEF_IDX   As String
Public ALLDEFBK_GRP As String '       440,000  �������¼�����(����)
Public ALLDEFBK_IDX As String
Public Dx_GRP(0 To 2) As String '     440,000  �������¼�����(�浵��)
Public Dx_IDX(0 To 2) As String
Public ALLSIN_GRP   As String '     4,915,200  ��������ͼ�ṹ(ԭʼ����)
Public ALLSIN_IDX   As String
Public ALLSINBK_GRP As String '     4,915,200  ��������ͼ�ṹ(����)
Public ALLSINBK_IDX As String
Public Sx_GRP(0 To 2) As String '   4,915,200  ��������ͼ�ṹ(�浵��)
Public Sx_IDX(0 To 2) As String
Public EFT_GRP      As String '       691,627  �����书Ч��
Public EFT_IDX      As String
Public ENDWORD_GRP  As String '        75,839  ����Ⱥ��Ϣ
Public ENDWORD_IDX  As String
Public FBK_GRP      As String '       138,677  ���ǹ�������136��(ÿ48��һ�ֹ���,ȭ����)
Public FBK_IDX      As String
Public CLOUD_GRP    As String '        10,287  ��
Public CLOUD_IDX    As String
Public FMAP_GRP     As String '     1,359,863  ���г�����ͼ��
Public FMAP_IDX     As String
Public HDGRP_GRP    As String '       249,276  ��������ͷ��
Public HDGRP_IDX    As String
Public KDEF_GRP     As String '       121,214  �����¼�ѹ���ű�
Public KDEF_IDX     As String
Public KEND_GRP     As String '    14,144,000  Ƭβ����
Public KEND_IDX     As String
Public MMAP_GRP     As String '     1,572,545  �����⾰��ͼ��
Public MMAP_IDX     As String
Public TALK_GRP     As String '       192,314  �Ի�(��ͼ��)
Public TALK_IDX     As String
Public TITLE_GRP    As String '         8,179  ����˵�
Public TITLE_IDX    As String
Public WARFLD_GRP   As String '       532,480  ս��������ͼ�������
Public WARFLD_IDX   As String

Public BUILDING_2   As String '       460,800  �⾰��ͼ������ͼ����(����ɽ�����ݵ�)
Public BUILDX_2     As String '       460,800  �⾰��ͼ��������x����(һ���������ܸ��Ǽ����ؿ�����)
Public BUILDY_2     As String '       460,800  �⾰��ͼ��������y����
Public EARTH_2      As String '       460,800  �⾰��ͼ�ײ���ͼ����(���桢���Ӻ�����ѩ�ء�ɳĮ��)
Public SURFACE_2    As String '       460,800  �⾰��ͼ������ͼ����(��·�������ݲݵ�)
Public DEAD_BIG     As String '        64,000  GameOverͼ��
Public TITLE_BIG    As String '        64,000  ����ͼ��
Public HERO_STA     As String '        58,240  ������ԭʼ��������(r1.grp��һ����)
Public WAR_STA      As String '        26,040  ս���¼�����
Public TEMP_SWP     As String '     4,194,304  ��ʱ�����ļ���
Public SWAP_VMC     As String '            50  ��ʱ�ļ�����
Public SHADOW3_MSK  As String '         7,770  ��Ӱ��ͼ���ݣ�
Public SHADOW4_MSK  As String '        11,170  ��Ӱ��
Public FONT_C16     As String '       447,136  ���庺�ֿ�
Public FONT3_C16    As String '       447,136  ���庺�ֿ⣿
Public FONT3J_C16   As String '       447,136  ���庺�ֿ⣿
Public FONT_E16     As String '         2,688  ������Ӣ���ֿ⣿
Public FONT3_E16    As String '         2,048  ������Ӣ���ֿ⣿
Public FONT_X16     As String '         2,048  �ֿ�xx
Public ENDCOL_COL   As String '           768  256��ɫ��
Public MMAP_COL     As String '           768  �⾰�ؿ���ͼ256��ɫ��
Public DOS4GW_EXE   As String '       265,420  Dos����ģʽ����
Public SETSOUND_EXE As String '       168,741  �������ó���
Public Z_EXE        As String '       343,873  ������
Public Z_COM        As String '           413  �ƽ����
Public Z_DAT        As String '       343,217  ��ִ���ļ� �൱ z.exe
Public CFONT        As String '        29,674  ���ֵ����ֿ�
Public SOL          As String '       126,158  ����������Ƶ���й�xxx
Public SIN050       As String '                49,152  11-04-01  12:19 SIN050
Public FIGHTxxx_GRP(0 To 109) As String '       247,429  �����书����
Public FIGHTxxx_IDX(0 To 109) As String
Public SDXxxx(0 To 83)   As String '   16,508  ����ͼ������
Public SMPxxx(0 To 83)   As String '  598,497  ����ͼ��
Public WDXxxx(0 To 25)   As String '   14,804  ����ͼ������
Public WMPxxx(0 To 25)   As String '   15,839  ����ͼ��
Public ATKxx_WAV(0 To 23)    As String '  19,228  ������Ч
Public Exx_WAV(0 To 52)      As String '   7,716  �书��Ч
Public GAMExx_XMI(0 To 23)   As String '   4,578  ��ϷMIDI����

Public tempInt1 As Integer, tempInt2 As Integer
Public tempLong1 As Long, tempLong2 As Long
Public tempBool1 As Boolean, tempBool2 As Boolean, Busying As Boolean
Public tempStr1 As String, tempStr2 As String
Public GamePath As String

Function iniVar(strPath As String) As Integer
'����0~319,��Ʒ0~199,�书0~92,����0~83
For i = 0 To 2
  Rx_GRP(i) = strPath & "R" & i & ".GRP" '     114,242  ����һ
  Rx_IDX(i) = strPath & "R" & i & ".IDX"
  Dx_GRP(i) = strPath & "D" & i & ".GRP" '     440,000  �������¼�����(�浵��)
  Dx_IDX(i) = strPath & "D" & i & ".IDX"
  Sx_GRP(i) = strPath & "S" & i & ".GRP" '   4,915,200  ��������ͼ�ṹ(�浵��)
  Sx_IDX(i) = strPath & "S" & i & ".IDX"
Next

For i = 0 To 109
  FIGHTxxx_GRP(i) = strPath & "FIGHT" & Format(i, "000") & ".GRP" = strPath & "" & "." '       247,429  �����书����
  FIGHTxxx_IDX(i) = strPath & "FIGHT" & Format(i, "000") & ".IDX" = strPath & "" & "."
Next

For i = 0 To 83
  SDXxxx(i) = strPath & "SDX" & Format(i, "000") '   16,508  ����ͼ������
  SMPxxx(i) = strPath & "SMP" & Format(i, "000") '  598,497  ����ͼ��
Next

For i = 0 To 25
  WDXxxx(i) = strPath & "WDX" & Format(i, "000")  '   14,804  ����ͼ������
  WMPxxx(i) = strPath & "WMP" & Format(i, "000")  '   15,839  ����ͼ��
Next

For i = 0 To 23
  ATKxx_WAV(i) = strPath & "ATK" & Format(i, "00") & ".WAV"   '  19,228  ������Ч
Next

For i = 0 To 52
  Exx_WAV(i) = strPath & "E" & Format(i, "00") & ".WAV"     '   7,716  �书��Ч
Next

For i = 1 To 24
  GAMExx_XMI(i - 1) = strPath & "GAME" & Format(i, "00") & ".XMI" '   4,578  ��ϷMIDI����
Next
RANGER_GRP = strPath & "RANGER" & ".GRP"   '       114,242  ����ԭʼ����
RANGER_IDX = strPath & "RANGER" & ".IDX"
ALLDEF_GRP = strPath & "ALLDEF" & ".GRP"   '       440,000  �������¼�����(ԭʼ����)
ALLDEF_IDX = strPath & "ALLDEF" & ".IDX"
ALLDEFBK_GRP = strPath & "ALLDEFBK" & ".GRP" '       440,000  �������¼�����(����)
ALLDEFBK_IDX = strPath & "ALLDEFBK" & ".IDX"
ALLSIN_GRP = strPath & "ALLSIN" & ".GRP"   '     4,915,200  ��������ͼ�ṹ(ԭʼ����)
ALLSIN_IDX = strPath & "ALLSIN" & ".IDX"
ALLSINBK_GRP = strPath & "ALLSINBK" & ".GRP" '     4,915,200  ��������ͼ�ṹ(����)
ALLSINBK_IDX = strPath & "ALLSINBK" & ".IDX"
EFT_GRP = strPath & "EFT" & ".GRP"      '       691,627  �����书Ч��
EFT_IDX = strPath & "EFT" & ".IDX"
ENDWORD_GRP = strPath & "ENDWORD" & ".GRP"  '        75,839  ����Ⱥ��Ϣ
ENDWORD_IDX = strPath & "ENDWORD" & ".IDX"
FBK_GRP = strPath & "FBK" & ".GRP"      '       138,677  ���ǹ�������136��(ÿ48��һ�ֹ���,ȭ����)
FBK_IDX = strPath & "FBK" & ".IDX"
CLOUD_GRP = strPath & "CLOUD" & ".GRP"    '        10,287  ��
CLOUD_IDX = strPath & "CLOUD" & ".IDX"
FMAP_GRP = strPath & "FMAP" & ".GRP"     '     1,359,863  ���г�����ͼ��
FMAP_IDX = strPath & "FMAP" & ".IDX"
HDGRP_GRP = strPath & "HDGRP" & ".GRP"    '       249,276  ��������ͷ��
HDGRP_IDX = strPath & "HDGRP" & ".IDX"
KDEF_GRP = strPath & "KDEF" & ".GRP"     '       121,214  �����¼�ѹ���ű�
KDEF_IDX = strPath & "KDEF" & ".IDX"
KEND_GRP = strPath & "KEND" & ".GRP"     '    14,144,000  Ƭβ����
KEND_IDX = strPath & "KEND" & ".IDX"
MMAP_GRP = strPath & "MMAP" & ".GRP"     '     1,572,545  �����⾰��ͼ��
MMAP_IDX = strPath & "MMAP" & ".IDX"
TALK_GRP = strPath & "TALK" & ".GRP"     '       192,314  �Ի�(��ͼ��)
TALK_IDX = strPath & "TALK" & ".IDX"
TITLE_GRP = strPath & "TITLE" & ".GRP"    '         8,179  ����˵�
TITLE_IDX = strPath & "TITLE" & ".IDX"
WARFLD_GRP = strPath & "WARFLD" & ".GRP"   '       532,480  ս��������ͼ�������
WARFLD_IDX = strPath & "WARFLD" & ".IDX"

BUILDING_2 = strPath & "BUILDING" & ".002"   '       460,800  �⾰��ͼ������ͼ����(����ɽ�����ݵ�)
BUILDX_2 = strPath & "BUILDX" & ".002"     '       460,800  �⾰��ͼ��������x����(һ���������ܸ��Ǽ����ؿ�����)
BUILDY_2 = strPath & "BUILDY" & ".002"     '       460,800  �⾰��ͼ��������y����
EARTH_2 = strPath & "EARTH" & ".002"      '       460,800  �⾰��ͼ�ײ���ͼ����(���桢���Ӻ�����ѩ�ء�ɳĮ��)
SURFACE_2 = strPath & "SURFACE" & ".002"    '       460,800  �⾰��ͼ������ͼ����(��·�������ݲݵ�)
DEAD_BIG = strPath & "DEAD" & ".BIG"     '        64,000  GameOverͼ��
TITLE_BIG = strPath & "TITLE" & ".BIG"    '        64,000  ����ͼ��
HERO_STA = strPath & "HERO" & ".STA"     '        58,240  ������ԭʼ��������(r1.GRP��һ����)
WAR_STA = strPath & "WAR" & ".STA"      '        26,040  ս���¼�����
TEMP_SWP = strPath & "TEMP" & ".SWP"     '     4,194,304  ��ʱ�����ļ���
SWAP_VMC = strPath & "SWAP" & ".VMC"     '            50  ��ʱ�ļ�����
SHADOW3_MSK = strPath & "3SHADOW" & ".MSK"  '         7,770  ��Ӱ��ͼ���ݣ�
SHADOW4_MSK = strPath & "4SHADOW" & ".MSK"  '        11,170  ��Ӱ��
FONT_C16 = strPath & "FONT" & ".C16"     '       447,136  ���庺�ֿ�
FONT3_C16 = strPath & "FONT3" & ".C16"    '       447,136  ���庺�ֿ⣿
FONT3J_C16 = strPath & "FONT3J" & ".C16"   '       447,136  ���庺�ֿ⣿
FONT_E16 = strPath & "FONT" & ".E16"     '         2,688  ������Ӣ���ֿ⣿
FONT3_E16 = strPath & "FONT3" & ".E16"    '         2,048  ������Ӣ���ֿ⣿
FONT_X16 = strPath & "FONT" & ".X16"     '         2,048  �ֿ�xx
ENDCOL_COL = strPath & "ENDCOL" & ".COL"   '           768  256��ɫ��
MMAP_COL = strPath & "MMAP" & ".COL"     '           768  �⾰�ؿ���ͼ256��ɫ��
DOS4GW_EXE = strPath & "DOS4GW" & ".EXE"   '       265,420  Dos����ģʽ����
SETSOUND_EXE = strPath & "SETSOUND" & ".EXE" '       168,741  �������ó���
Z_EXE = strPath & "Z" & ".EXE"        '       343,873  ������
Z_COM = strPath & "Z" & ".COM"        '           413  �ƽ����
Z_DAT = strPath & "Z" & ".DAT"        '       343,217  ��ִ���ļ� �൱ z.exe
CFONT = strPath & "CFONT"        '        29,674  ���ֵ����ֿ�
SOL = strPath & "SOL"          '       126,158  ����������Ƶ���й�xxx
SIN050 = strPath & "SIN050"      '                49,152  11-04-01  12:19 SIN050
iniVar = 0
End Function