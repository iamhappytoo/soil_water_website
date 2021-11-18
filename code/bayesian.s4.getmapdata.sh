#!/bin/bash
##author: Zhaoxin Ban
##This is used for drawing the maps for the new percentile distribution for the new day
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA"
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s41.process.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s43.realtime.process.sh
for f in $based/bayesianhistory/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/bayesianhistory/datafordates/new$nam
	mv $based/bayesianhistory/datafordates/new$nam $based/bayesianhistory/datafordates/$nam
done
for f in $based/bayesianrealtime/datafordates/*.dat
do
	nam=`basename $f`
	awk '($3>0)' $f > $based/bayesianrealtime/datafordates/new$nam
	mv $based/bayesianrealtime/datafordates/new$nam $based/bayesianrealtime/datafordates/$nam
done

