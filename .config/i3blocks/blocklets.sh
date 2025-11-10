#!/usr/bin/env bash

# ===== date and time =====
fn_time() {
  echo " $(date '+%H:%M')"
}

fn_date() {
  echo " $(date '+%m/%d/%Y')"
}

fn_datetime() {
  echo "$(fn_time)  $(fn_date)"
}

# ===== wifi, ethernet, battery, volume, brightness =====
fn_wifi() {
  if nmcli -t -f TYPE,STATE device | grep -q "wifi:connected"; then
    quality=$(iw dev wlan0 link | awk '
      /dBm$/ {
        dBm = $2
        if (dBm > -50) pct = 100
        else if (dBm < -100) pct = 0
        else pct = (dBm + 100) * 2
        printf pct
      }'
    )
    echo "  $quality%"
  else
    echo "󰤯 down"
  fi
}

fn_ethernet() {
  if nmcli -t -f TYPE,STATE device | grep -q "ethernet:connected"; then
    echo "󰈀 up"
  else
    echo "󰈀 down"
  fi
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

  echo "$icon $pct%"
}

fn_volume() {
  mute=$(pamixer --get-mute)
  vol=$(pamixer --get-volume)

  if [[ $mute == "true" ]]; then
    icon=" "
  elif (( $vol <= 30 )); then
    icon=" "
  elif (( $vol <= 60 )); then
    icon=" "
  else
    icon=" "
  fi

  echo "$icon $vol%"
}

fn_brightness() {
  cur=$(brightnessctl get)
  max=$(brightnessctl max)
  pct=$((100*cur/max))
  echo " $pct%"
}

fn_status() {
  echo "$(fn_wifi)  $(fn_ethernet)  $(fn_battery)  $(fn_volume)  $(fn_brightness)"
}

# ===== cpu, gpu, ram, disk =====
fn_cpu() {
 usage=$(top -bn1 | grep "Cpu(s)" | \
          sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
          awk '{printf int(100 - $1)}')
 echo " $usage%"
}

fn_gpu() {
  usage=$(timeout 0.3s intel_gpu_top -l -s 50 | \
          awk 'NR==5 {printf "%.0f", $7}')
  echo "󰢮 $usage%"
}

fn_ram() {
  usage=$(free -m | awk 'NR==2 {printf "%.1fG\n", $3/1024}')
  echo " $usage"
}

fn_disk() {
  usage=$(df -B1 --output=used,source | awk '
    $2 == "/dev/nvme0n1p6" {
      gb = $1 / (1024 * 1024 * 1024)
      printf("%.1fG\n", gb)
    }'
  )
  echo " $usage"
}

fn_system() {
  echo "$(fn_cpu)  $(fn_gpu)  $(fn_ram)  $(fn_disk)"
}


name="$1"

fn_full_text() {
  case "$name" in
    # datetime
    time) fn_time;;
    date) fn_date;;
    datetime) fn_datetime;;
    # status
    wifi) fn_wifi;;
    ethernet) fn_ethernet;;
    battery) fn_battery;;
    volume) fn_volume;;
    brightness) fn_brightness;;
    status) fn_status;;
    # system
    cpu) fn_cpu;;
    gpu) fn_gpu;;
    ram) fn_ram;;
    disk) fn_disk;;
    system) fn_system;;
  esac
}

full_text=$(fn_full_text)
dpi=$(xrdb -query | awk '/Xft.dpi:/ {print $2}')

if (( $dpi >= 144 )); then
  sep=60
else
  sep=30
fi

echo "{ \"full_text\": \"$full_text\", \"separator_block_width\": \"$sep\" }"
