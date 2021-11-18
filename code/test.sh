#!/bin/bash
while read var1
do
        cp /raid4/forecast/pnw_sw_monitor/data/nev/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/cali1/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/cali2/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/gb/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/colo1/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/colo2/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        cp /raid4/forecast/pnw_sw_monitor/data/pnw1/results/spinup_nearRT/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/nev/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/cali1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/cali2/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/gb/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/colo1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/colo2/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        #cp /raid4/forecast/pnw_sw_monitor/data/pnw1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
#        mv /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
done</raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/scpname


