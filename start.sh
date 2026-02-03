#!/bin/bash
set -e

python3 web_alive.py &

exec bash run.sh
