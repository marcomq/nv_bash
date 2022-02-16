import nimview
import os

nimview.add("spawnShell", proc (cmd: string): int =
  when defined(windows):
    echo "starting " & os.quoteShellPosix(cmd)
    os.execShellCmd("start /wait cmd.exe /c bash -c " & os.quoteShellPosix(cmd))
  else:
    os.execShellCmd("xterm -e /usr/bin/bash -c " & os.quoteShellPosix(cmd))
)

when isMainModule:
  enableStorage() # adds getStoredVal and setStoredVal
  start()