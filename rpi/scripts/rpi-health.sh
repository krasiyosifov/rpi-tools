#!/bin/bash


#PWM=$(cat /sys/class/hwmon/hwmon2/pwm1)
#PWM=$(($PWM*100/250))
#FAN=$(cat /sys/devices/platform/cooling_fan/hwmon/hwmon2/fan1_input)
CPU_TEMP=$(vcgencmd measure_temp | sed 's/temp=//')
TIMESTAMP=$(date)
FAN_HEX=$(i2cget -y 1 0x1a 0x80)
FAN=$(($FAN_HEX))
ARM_CLOCK=$(vcgencmd measure_clock arm | sed 's/frequency(0)=//')
ARM_CLOCK=$((ARM_CLOCK/1000000))
MEMORY_ARR=($(free -m | awk '/Mem/ {print $2,$3}'))
MEMORY_USED=${MEMORY_ARR[1]}
MEMORY_TOTAL=${MEMORY_ARR[0]}
MEMORY_USED_PERCENT=$(($MEMORY_USED*100/$MEMORY_TOTAL))
#CPU_USAGE=$(top -b -n1 -p 1 | grep "Cpu(s)" | tail -n 1 | awk '{print 100 - $8}')
CPU_LOAD=$(top -b -n1 | head -n1 | awk '{print $10, $11, $12}')
echo "[$TIMESTAMP] CPU: load=$CPU_LOAD, f=$ARM_CLOCK MHz, t=$CPU_TEMP, fan=$FAN% / Used mem: $MEMORY_USED MB ($MEMORY_USED_PERCENT%)"
