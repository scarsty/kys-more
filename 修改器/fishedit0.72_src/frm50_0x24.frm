VERSION 5.00
Begin VB.Form frm50_0x24 
   Caption         =   "50指令24"
   ClientHeight    =   5430
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10860
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   5430
   ScaleWidth      =   10860
   StartUpPosition =   2  '屏幕中心
   Begin VB.TextBox txtNote 
      Appearance      =   0  'Flat
      BackColor       =   &H80000013&
      BorderStyle     =   0  'None
      ForeColor       =   &H00FF0000&
      Height          =   975
      Left            =   240
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   13
      Text            =   "frm50_0x24.frx":0000
      Top             =   4080
      Width           =   5175
   End
   Begin fishedit.userVar userV 
      Height          =   1215
      Left            =   120
      TabIndex        =   12
      Top             =   1560
      Width           =   1935
      _extentx        =   3413
      _extenty        =   2143
   End
   Begin fishedit.userVar userX 
      Height          =   1335
      Left            =   2760
      TabIndex        =   10
      Top             =   2160
      Width           =   1815
      _extentx        =   3201
      _extenty        =   2355
   End
   Begin fishedit.userVar userY 
      Height          =   1095
      Left            =   4800
      TabIndex        =   8
      Top             =   2160
      Width           =   1935
      _extentx        =   3413
      _extenty        =   1931
   End
   Begin fishedit.userVar userI 
      Height          =   1095
      Left            =   4920
      TabIndex        =   4
      Top             =   720
      Width           =   2055
      _extentx        =   3625
      _extenty        =   1931
   End
   Begin fishedit.UserVar2 UserID 
      Height          =   1095
      Left            =   2760
      TabIndex        =   2
      Top             =   720
      Width           =   2055
      _extentx        =   3625
      _extenty        =   1931
   End
   Begin VB.CommandButton cmdcancel 
      Caption         =   "取消"
      Height          =   375
      Left            =   9240
      TabIndex        =   1
      Top             =   1320
      Width           =   1335
   End
   Begin VB.CommandButton cmdok 
      Caption         =   "确定"
      Height          =   375
      Left            =   9240
      TabIndex        =   0
      Top             =   480
      Width           =   1335
   End
   Begin VB.Label Label8 
      Caption         =   "纵坐标Y"
      Height          =   375
      Left            =   4920
      TabIndex        =   11
      Top             =   1800
      Width           =   1095
   End
   Begin VB.Label Label7 
      Caption         =   "="
      Height          =   375
      Left            =   2160
      TabIndex        =   9
      Top             =   1680
      Width           =   495
   End
   Begin VB.Label Label6 
      Caption         =   "横坐标X"
      Height          =   375
      Left            =   2880
      TabIndex        =   7
      Top             =   1800
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "值V"
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Top             =   960
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "层I"
      Height          =   375
      Left            =   4920
      TabIndex        =   5
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label Label3 
      Caption         =   "场景ID"
      Height          =   375
      Left            =   2760
      TabIndex        =   3
      Top             =   240
      Width           =   1815
   End
End
Attribute VB_Name = "frm50_0x24"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Index As Long
Dim kk As Statement
Dim OffsetName As Collection




Private Sub cmdcancel_Click()
    Unload Me
End Sub

Private Sub cmdok_Click()
 
    kk.Data(1) = UserID.Value + userI.Value * 2 + userX.Value * 4 + userY.Value * 8
    kk.Data(2) = UserID.Text
    kk.Data(3) = userI.Text
    kk.Data(4) = userX.Text
    kk.Data(5) = userY.Text
    kk.Data(6) = userV.Text

    
    Unload Me
    
End Sub

 










Private Sub Form_Load()
Dim num50 As Long
Dim i As Long
Dim s1 As String
    Call ConvertForm(Me)
    
    
    Index = frmmain.listkdef.ListIndex
    Set kk = KdefInfo(frmmain.Combokdef.ListIndex).kdef.Item(Index + 1)
    
    UserID.Clear
    For i = 0 To Scenenum - 1
        UserID.AddItem CLng(i) & ":" & Big5toUnicode(Scene(i).Name1, 10)
    Next i
    
    
    UserID.Text = kk.Data(2)
    UserID.Value = IIf((kk.Data(1) And &H1) > 0, 1, 0)
    userI.Value = IIf((kk.Data(1) And &H2) > 0, 1, 0)
    userX.Value = IIf((kk.Data(1) And &H4) > 0, 1, 0)
    userY.Value = IIf((kk.Data(1) And &H8) > 0, 1, 0)

    
    UserID.SetCombo


    userI.Text = kk.Data(3)
    userI.SetCombo
    

    userX.Text = kk.Data(4)
    
    userX.SetCombo
    
    userY.Text = kk.Data(5)
    userY.SetCombo
    userV.Text = kk.Data(6)
    userV.Showtype = False
    userV.SetCombo

    Call Set50Form(Me, kk.Data(0))
 
End Sub

 
