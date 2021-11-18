#!/bin/bash
##author:Zhaoxin Ban
##This is used for generating maps for the data given, both realtime and history.
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING"
mkdir -p $based/vicrealtime
mkdir -p $based/vichistory
rm $based/vicrealtime/*
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s51.doplot.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s53.realtime.doplot.sh
cp $based/vicrealtime/*.jpg $based/vichistory

