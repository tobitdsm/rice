#!/bin/bash

loc=$(curl ipinfo.io | jq -r ".loc")
lat=$(cut -d"," -f1 <<<"$loc")
lon=$(cut -d"," -f2 <<<"$loc")

curl https://api.open-meteo.com/v1/forecast?latitude="$lat"\&longitude="$lon"\&current=temperature_2m,weather_code,is_day | jq -r .current | jq -c "{code: .weather_code, temp: .temperature_2m, day: .is_day}"
