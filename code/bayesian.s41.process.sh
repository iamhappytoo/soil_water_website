based1="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/bayesianhistory"
inputd1="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/bayesian.pctl.from.2018"
awk '{print $1}' $inputd1/pctl.417.txt > $based1/dates.dat
sed -i 's/-/ /g' $based1/dates.dat
rm $based1/datafordates/*   ##delete the previous generated "history data" to reduce redundancy
cat $based1/dates.dat | gawk '{print "sh /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/bayesian.s42.find_data.sh "$1,$2,$3}' | sh  ###This is execute the find_data.sh every time when you read one line of useful.coordinates.txt


