#!/bin/bash
while test $# -gt 0; do
           case "$1" in
                -du)
                    shift
                    directorieToUse=$1
                    shift
                    ;;
                *)
                   echo "$1 please use the -du flag!"
                   return 1;
                   ;;
          esac
  done
	  echo "DirectorieToUse: $directorieToUse";
Xvfb :94 -screen 0 1920x1080x16 &
export DISPLAY=:94
sleep 1
code $directorieToUse --no-sandbox --user-data-dir=. &
x11vnc -shared -create -display :94 -nopw -forever
