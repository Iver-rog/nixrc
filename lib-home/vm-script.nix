{ pkgs }:
# script for launching windows 10 vm in fullscreen or halfscreen depending on monitor size
pkgs.writeShellScriptBin "win10" ''
  if [ "$(head -1 /sys/class/drm/card1-DP-1/modes)" = "3440x1440"]; then
    # echo "stor sjerm"
    quickemu -vm /home/iver/vm/windows-10-International.conf --width 1720 --height 1366
  else
    # echo "liten sjerm"
    quickemu -vm /home/iver/vm/windows-10-International.conf --fullscreen
  fi
''
