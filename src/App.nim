import nimview
import os

nimview.add("spawnShell", proc (cmd: string): int =
  when defined(windows):
    os.execShellCmd("start cmd.exe /c wsl.exe \"" & os.quoteShellPosix(cmd) & "\"")
  else:
    os.execShellCmd("xterm -e /bin/bash -c \"" & os.quoteShellPosix(cmd) & "\"")
)

when isMainModule:
  enableStorage() # adds getStoredVal and setStoredVal
  start()