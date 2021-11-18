#!/bin/bash
##author:Zhaoxin Ban
##This is used for generating maps for the data given, both realtime and history.
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING"
mkdir -p $based/realtime
mkdir -p $based/history
rm $based/realtime/*
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s51.doplot.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s53.realtime.doplot.sh
cp $based/realtime/*.jpg $based/history
