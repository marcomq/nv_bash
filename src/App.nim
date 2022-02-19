import nimview
import os, strutils
import std/compilesettings

if defined(gui):
  quit()
nimview.add("spawnShell", proc (cmd: string): int =
  when defined(windows):
    let compileCmd: string = querySetting(SingleValueSetting.commandLine)
    echo compileCmd
    let showConsole = 
      if "app:gui" in compileCmd:
        " /b "
      else:
        ""
    let winCmd =  "start " & showConsole & " /wait cmd.exe /c bash -c " & 
      os. quoteShellWindows(cmd & " && sleep 5 || read -n 1 -p \"press any key\" VAR")
    echo "starting: " & winCmd
    os.execShellCmd(winCmd)
  else:
    let posixCmd =  os.quoteShellPosix(cmd & " && sleep 5 || read -n 1 -p \"press any key\" VAR")
    os.execShellCmd("xterm -e /usr/bin/bash -c " & posixCmd)
)

when isMainModule:
  enableStorage() # adds getStoredVal and setStoredVal
  start(title="Run command in WSL / Bash")