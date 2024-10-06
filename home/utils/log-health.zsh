#!/bin/zsh

# Logs healh alerts
# Ideal for jobs

CPU_TEMP_TRESHOLD=${CPU_TEMP_TRESHOLD:-800}
FAN_SPEED_TRESHOLD=${FAN_SPEED_TRESHOLD:-3000}
LOG_FILE=${LOG_FILE:-~/.local/state/health.log}

main() {
  sensors_output=$(sensors)
  cpu_temp=$(echo $sensors_output | grep "Package id" | cut -d "+" -f2 | cut -d "(" -f1 | xargs | sed 's/[^0-9]*//g')
  if [ $cpu_temp -gt $CPU_TEMP_TRESHOLD ]; then
    log "CPU temperature above threshold: ${cpu_temp} (ts: $CPU_TEMP_TRESHOLD)"
  fi

  fan_speed=$(echo $sensors_output | grep "fan1" | cut -d ":" -f2 | cut -d "(" -f1 | xargs | sed 's/[^0-9]*//g')
  if [ $fan_speed -gt $FAN_SPEED_TRESHOLD ]; then
    log "Fan speed above threshold: ${fan_speed} (ts: $FAN_SPEED_TRESHOLD)"
  fi
}

log() {
  mkdir -p $(dirname $LOG_FILE)
  echo "[$(date)]: $1" >>$LOG_FILE
}

main
