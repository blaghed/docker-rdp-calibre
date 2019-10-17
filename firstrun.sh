#!/bin/bash

mkdir -p /config/config
ln -s /config/config /nobody/.config/calibre
chown -R nobody:users /config
chmod -R g+rw /config
[[ -f /tmp/.X1-lock ]] && rm /tmp/.X1-lock && echo "X1-lock found, deleting"

if [ ! "$EDGE" = "1" ]; then
  echo "EDGE not requested, keeping stable version"
else
  echo "EDGE requested"
  if [ -z ${VERSION} ]; then 
    echo "var is unset";
    wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
  else
    echo "Updating to version $VERSION"
    wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(version=$VERSION)"
  fi
fi
