#!/bin/bash

class=cpu_speed
speed_mhz=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)

# speed_ghz=`echo $(($speed_mhz / 1000))`

speed_ghz=`bc -l <<< "$speed_mhz / 1000000"`

info=$(echo $speed_ghz | xargs printf "%.*f\n" 2)

echo -e "{\"text\":\""$info GHz"\", \"class\":\""$class"\"}"
