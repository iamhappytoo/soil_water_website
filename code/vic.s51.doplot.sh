based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/vichistory/datafordates/"
cd $based
ls *.dat > listfile.txt
cd "/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update"  ##come back
cat $based/listfile.txt | gawk '{print "sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/vic.s52.plot_each_file.sh "$1}' | sh
rm $based/listfile.txt
