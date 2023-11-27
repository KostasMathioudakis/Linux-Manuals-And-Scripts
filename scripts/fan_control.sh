#!/bin/bash
# @author Kostas Mathioudakis

#Env vars (might be needed for cron job)
#export DISPLAY=:1

# Enable manual control over the GPU fan
nvidia-settings -a [gpu:0]/GPUFanControlState=1

# Function to set fan speed
set_fan_speed(){
    nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$1
}

# Function to get GPU temperature
get_gpu_temp(){
    temp=$(nvidia-settings -q gpucoretemp | grep 'GPUCoreTemp' | head -n 1 | awk '{print $4}' | awk -F '.' '{print $1}')
    echo $temp
}

# Main loop
while :
do
    temp=$(get_gpu_temp)

    if [ $temp -lt 50 ]; then
        set_fan_speed 40
    elif [ $temp -ge 50 ] && [ $temp -lt 60 ]; then
        set_fan_speed 50
    elif [ $temp -ge 60 ] && [ $temp -lt 70 ]; then
        set_fan_speed 60
    elif [ $temp -ge 70 ] && [ $temp -lt 80 ]; then
        set_fan_speed 80
    elif [ $temp -ge 80 ]; then
        set_fan_speed 100
    fi

    sleep 2 # Sleep for 5 seconds
done

