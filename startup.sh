#!/bin/sh
cd /home/theia/pub/browser-app && yarn theia start --no-cluster  --plugins=local-dir:../plugins --hostname 0.0.0.0 --port $PORT