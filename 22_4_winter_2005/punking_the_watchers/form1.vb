Option Explicit On 
Imports System.Math

Public Class Form1
    Inherits System.Windows.Forms.Form

    Private Declare Function ExitWindowsEx Lib "user32" (ByVal uFlags As Long, ByVal dwReserved As Long) As Long
    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
    Private WithEvents WinMsg As MessengerAPI.Messenger

    Private Enum WindowsExitFlags
        Logoff = 0
        Shutdown = 1
        Reboot = 2
        ForceLogoff = 4
    End Enum

    Private Sub btnGo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGo.Click
        Dim time As Integer
        Dim checkTime As Boolean
        Dim sysTime As Date = DateTime.Now
        Dim goTime As Date = DateTime.Now
        Dim position As Point
        Dim rand As New Random(CInt(Now.Ticks And Integer.MaxValue))
        Dim randPos As Integer

        WinMsg = New MessengerAPI.Messenger
        position = Cursor.Position()
        checkTime = IsNumeric(txtVal.Text)

        If (checkTime = True) Then
            If (txtVal.Text > 0) Then
                time = txtVal.Text
                goTime = Now.AddMinutes(time)
            Else
                MessageBox.Show("Value must be > 0. Try again.")
                txtVal.Clear()
                Exit Sub
            End If
        Else
            MessageBox.Show("Value must be numeric. Try again.")
            txtVal.Clear()
            Exit Sub
        End If

        Do Until goTime = sysTime
            sysTime = DateTime.Now

            Select Case sysTime.Second
                Case 15, 59
                    randPos = rand.Next(0, 640)
                    position.X = randPos
                    Cursor.Position = position
                    Sleep(2000)
                Case 30, 45
                    randPos = rand.Next(0, 480)
                    position.Y = randPos
                    Cursor.Position = position
                    Sleep(2000)
            End Select

            Select Case sysTime.Minute
                Case 8, 26, 39, 46
                    WinMsg.MyStatus = MessengerAPI.MISTATUS.MISTATUS_ONLINE
                Case 6, 23, 36, 44
                    WinMsg.MyStatus = MessengerAPI.MISTATUS.MISTATUS_AWAY
            End Select

            If goTime <= sysTime Then
                ExitWindowsEx(WindowsExitFlags.ForceLogoff, 0&)
            End If
        Loop
    End Sub

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents btnGo As System.Windows.Forms.Button
    Friend WithEvents txtVal As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Form1))
        Me.btnGo = New System.Windows.Forms.Button
        Me.txtVal = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'btnGo
        '
        Me.btnGo.Location = New System.Drawing.Point(88, 5)
        Me.btnGo.Name = "btnGo"
        Me.btnGo.Size = New System.Drawing.Size(75, 24)
        Me.btnGo.TabIndex = 0
        Me.btnGo.Text = "Go"
        '
        'txtVal
        '
        Me.txtVal.Location = New System.Drawing.Point(8, 8)
        Me.txtVal.Name = "txtVal"
        Me.txtVal.Size = New System.Drawing.Size(70, 20)
        Me.txtVal.TabIndex = 1
        Me.txtVal.Text = ""
        '
        'Form1
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(177, 37)
        Me.Controls.Add(Me.txtVal)
        Me.Controls.Add(Me.btnGo)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(150, 150)
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.ResumeLayout(False)

    End Sub

#End Region


End Class
