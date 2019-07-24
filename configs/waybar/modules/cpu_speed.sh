#!/bin/bash

class=cpu_speed
info=$(lscpu | grep "CPU MHz" | sed --expression "s/CPU MHz:[[:space:]]*//g" | xargs printf "%.*f\n" 0)

echo -e "{\"text\":\""$info"\",  \"class\":\""$class"\"}"
