#!/bin/bash
##author:Zhaoxin Ban
##This is used for generating maps for the data given, both realtime and history.
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING"
mkdir -p $based/bayesianrealtime
mkdir -p $based/bayesianhistory
rm $based/bayesianrealtime/*
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s51.doplot.sh
sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s53.realtime.doplot.sh
cp $based/bayesianrealtime/*.jpg $based/bayesianhistory
