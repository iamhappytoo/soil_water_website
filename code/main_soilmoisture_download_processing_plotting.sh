#!/bin/bash

## author: Zhaoxin Ban
## This is used for link all of the .sh files together

echo "downloading nrcs, scan, uscrn, wrcc, vic data...."
 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s0.download.sh
# /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/wrcc.download.sh
 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.download.sh
echo "formatting nrcs, scan, uscrn, wrcc, vic data..."
 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s1.format.sh  ##contains nrcs, scan, uscrn
# /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/wrcc.format.sh  ##formatting the wrcc data
 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.format.sh
echo "integrating the different soil depths into 50 cm column..."
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s2.depth_integral.sh
# /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/wrcc.integral.sh
 /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.integral.sh
echo "calculating the 20-year based percentile for move2 calculated, bayesian method calculated soil moisture record, as well as vic data... "
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s3.calc.pctl.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s3.calc.pctl.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s3.calc.pctl.sh
echo "getting mapdata of soil moisture percentile..."
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s4.getmapdata.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s4.getmapdata.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s4.getmapdata.sh
echo "plotting soil moisture percentile distribution maps..."
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/s5.mapping.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s5.mapping.sh
 /bin/bash /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s5.mapping.sh
echo "uploading the plotted maps to website..."
scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/history/*.jpg forecast@hydro.ucla.edu:/home/forecast/forecast/monitor_ca/pictures/sm.percentile.archive
scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/bayesianhistory/*.jpg forecast@hydro.ucla.edu:/home/forecast/forecast/monitor_ca/pictures/bayesian.percentile.map
scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/vichistory/*.jpg forecast@hydro.ucla.edu:/home/forecast/forecast/monitor_ca/pictures/vic.percentile.map
echo "uploading the realtime maps to website..."
 date "+%Y%m%d" | gawk '{print "scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/realtime/"$1".jpg forecast@hydro.ucla.edu:/home/forecast/forecast/monitor_ca/pictures/sm.pctl.realtime/realtimesm.jpg"}'|sh
cat /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/yesterday| gawk '{print "scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/vichistory/"$1".jpg forecast@hydro.ucla.edu://home/forecast/forecast/monitor_ca/pictures/vic.sm.pctl.realtime/realtimesm.jpg"}'|sh 
date "+%Y%m%d" > /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/yesterday
 date "+%Y%m%d" | gawk '{print "scp /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/bayesianrealtime/"$1".jpg forecast@hydro.ucla.edu:/home/forecast/forecast/monitor_ca/pictures/bayesian.sm.pctl.realtime/realtimesm.jpg"}'|sh
echo "finished!"
