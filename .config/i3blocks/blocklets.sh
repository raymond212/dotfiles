#!/usr/bin/env bash

fn_volume() {
  mute=$(pamixer --get-mute)
  vol=$(pamixer --get-volume)

  if [[ $mute == "true" ]]; then
    icon=" "
  elif (( $vol <= 50 )); then
    icon=" "
  elif (( $vol > 50 )); then
    icon=" "
  fi

  echo "$icon $vol%"
}

fn_brightness() {
  cur=$(brightnessctl get)
  max=$(brightnessctl max)
  pct=$((100*cur/max))
  echo "  $pct%"
}

fn_time() {
  echo "  $(date '+%H:%M:%S')"
}

fn_date() {
  echo "  $(date '+%m/%d/%Y')"
}

fn_disk() {
  usage=$(df -B1 --output=used,source | awk '
    $2 == "/dev/nvme0n1p6" {
      gb = $1 / (1024 * 1024 * 1024)
      printf("%.1fG\n", gb)
    }'
  )
  echo "  $usage"
}

fn_battery() {
  dir="/sys/class/power_supply"
  pct=$(cat "$dir/BAT0/capacity")
  ac=$(cat "$dir/AC/online")

  if (( $ac == 1 )); then
    icon="󰂄"
  elif (( $pct <= 5 )); then
    icon="󰂎"
  elif (( $pct <= 15 )); then
    icon="󰁺"
  elif (( $pct <= 25 )); then
    icon="󰁻"
  elif (( $pct <= 35 )); then
    icon="󰁼"
  elif (( $pct <= 45 )); then
    icon="󰁽"
  elif (( $pct <= 55 )); then
    icon="󰁾"
  elif (( $pct <= 65 )); then
    icon="󰁿"
  elif (( $pct <= 75 )); then
    icon="󰂀"
  elif (( $pct <= 85 )); then
    icon="󰂁"
  elif (( $pct <= 95 )); then
    icon="󰂂"
  else
    icon="󰁹"
  fi

  echo "$icon $pct%"
}

fn_wifi() {
  interface="wlan0"
  status=$(iw dev $interface link)

  if [[ $status == "Not connected." ]]; then
    echo "  down"
    exit
  fi

  quality=$(iw dev $interface link | awk '
    /dBm$/ {
      dBm = $2
      if (dBm > -50) pct = 100
      else if (dBm < -100) pct = 0
      else pct = (dBm + 100) * 2
      printf pct
    }'
  )

  echo "  $quality%"
}

fn_ethernet() {
  if [[ ! -d "/sys/class/net/eth0" ]]; then
    echo "󰈀  down"
    return
  fi

  status=$(iw dev eth0 link)

  if [[ $status == "Not connected." ]]; then
    echo "󰈀  down"
  else
    echo "󰈀  up"
  fi
}

fn_cpu() {
 usage=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')
 echo "  $usage"
}

fn_ram() {
  usage=$(free -m | awk 'NR==2{printf "%.1fG\n", $3/1024}')
  echo "  $usage"
}

name="$1"

case "$name" in
  volume) fn_volume;;
  brightness) fn_brightness;;
  time) fn_time;;
  date) fn_date;;
  disk) fn_disk;;
  battery) fn_battery;;
  wifi) fn_wifi;;
  ethernet) fn_ethernet;;
  cpu) fn_cpu;;
  ram) fn_ram;;
esac
