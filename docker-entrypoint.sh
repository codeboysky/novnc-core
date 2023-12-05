#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <argument>"
    exit 1
fi
WIDTH=${WIDTH:-1200}
HEIGHT=${HEIGHT:-745}
PASSWD=${PASSWD:-123456}
export DEBIAN_FRONTEND=noninteractive
nohup Xvfb :0 -screen 0 ${WIDTH}x${HEIGHT}x24 -listen tcp -ac +extension GLX +extension RENDER >/dev/null 2>&1 &
nohup x11vnc -forever -shared -noipv6 -passwd ${PASSWD} >/dev/null 2>&1 &
nohup websockify --web /usr/share/novnc 8888 localhost:5900 >/dev/null 2>&1 &

sleep 5s
export DISPLAY=:0.0
echo "$@"
exec "$@"
