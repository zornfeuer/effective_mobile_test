#!/bin/bash

PROCESS_NAME="test"
MONITORING_URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
PID_FILE="/var/run/monitoring_test.pid"

pid=$(pgrep -x "$PROCESS_NAME")
[ -z "$pid" ] && exit 0

previous_pid=""
[[ -f "$PID_FILE" ]] && previous_pid=$(cat "$PID_FILE")

if [[ "$previous_pid" != "$pid" && "$pid" != "" ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Process $PROCESS_NAME restarted. New PID: $pid" >> "$LOG_FILE"
fi

echo "$pid" > "$PID_FILE"

response=$(curl -s -o /dev/null -w "%{http_code}" "$MONITORING_URL")

if [[ "$response" != "200" ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Monitoring server unavailable. HTTP code: $response" >> "$LOG_FILE"
fi
