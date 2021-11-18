#!/bin/bash
##author: Zhaoxin Ban
##This is used for drawing the maps for the new percentile distribution for the new day
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA"
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s41.process.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s43.realtime.process.sh
for f in $based/history/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/history/datafordates/new$nam
	mv $based/history/datafordates/new$nam $based/history/datafordates/$nam
done
for f in $based/realtime/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/realtime/datafordates/new$nam
	mv $based/realtime/datafordates/new$nam $based/realtime/datafordates/$nam
done
