#!/bin/bash
##author: Zhaoxin Ban
##This is used for drawing the maps for the new percentile distribution for the new day
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA"
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s41.process.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s43.realtime.process.sh
for f in $based/vichistory/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/vichistory/datafordates/new$nam
	mv $based/vichistory/datafordates/new$nam $based/vichistory/datafordates/$nam
done
for f in $based/vicrealtime/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/vicrealtime/datafordates/new$nam
	mv $based/vicrealtime/datafordates/new$nam $based/vicrealtime/datafordates/$nam
done


