#!/bin/bash
##this is used for scp fluxes from mxiao@128.97.63.197
##here is to download fluxes data after 1920
#while read var1
#do
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/nev/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali1/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali2/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/gb/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo1/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo2/results/retro/vic/daily/asc/$var1 $var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/pnw1/results/retro/vic/daily/asc/$var1 $var1
#done<scpname
##here is to download fluxes data after 2011 and append them to the name later. 
#while read var1
#do
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/nev/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali1/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali2/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/gb/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo1/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo2/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/pnw1/results/spinup_nearRT/vic/daily/asc/$var1 new$var1
#	cat new$var1 >> $var1
#	rm new$var1
#done<scpname
#while read var1
#do
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/nev/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali1/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/cali2/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/gb/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo1/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/colo2/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        sshpass -p "geog@123" scp -r mxiao@128.97.63.197:/raid4/forecast/pnw_sw_monitor/data/pnw1/results/curr_spinup/vic/daily/asc/$var1 new$var1
#        cat new$var1 >> $var1
#        rm new$var1
#done<scpname
while read var1
do
        cp /raid4/forecast/pnw_sw_monitor/data/nev/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/cali1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/cali2/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/gb/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/colo1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/colo2/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        cp /raid4/forecast/pnw_sw_monitor/data/pnw1/results/curr_spinup/vic/daily/asc/$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1
        mv /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/new$var1 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/data/vic/$var1
done</raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/scpname

