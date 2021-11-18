#/bin/bash
#Find data point on a certain date
yy=$1
mm=$2
dd=$3
filename=$yy$mm$dd".dat"
based1="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/realtime"
inputd2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/pctl.from.2018"
based2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/history"
#while read var1 var2 var3 var4
#do
#	gawk -v yy="$yy" -v mm="$mm" -v dd="$dd" '{print "echo -e -n \""$var1,$var2,$var3" \" "; print "grep -i \""yy"-"mm"-"dd"\" /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/pctl.from.2018/"$var4}' # | sh | xargs
#	echo "\n"
#done<$based1/newfilelist.dat
#cat $based1/newfilelist.dat | gawk -v yy="$yy" -v mm="$mm" -v dd="$dd" '{print "echo -e -n \""$1,$2,$3" \" "; print "grep -i \""yy"-"mm"-"dd"\" /raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/pctl.from.2018/"$4}'  | sh | xargs #| gawk '{print $2,$3,$7}'  #> $based2/datafordates/${filename}
#inputd2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/real.time.pctl"
#based2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/realtime"
mkdir -p $based2/datafordates
cat $based1/newfilelist.dat | gawk '{print $1,$2,$3}' >> $based2/temp1
while read v1 v2 v3 v4
do
	grep -i "${yy}-${mm}-${dd}" $inputd2/$v4  > $based2/temp
	if [ -s $based2/temp ]
	then
		cat $based2/temp >> $based2/temp2
	else
		echo "${yy}-${mm}-${dd} 0" >> $based2/temp2	
	fi
done<$based1/newfilelist.dat
#cat $based1/newfilelist.dat | gawk -v yy="$yy" -v mm="$mm" -v dd="$dd" -v input="$inputd2" '{print "grep \""yy"-"mm"-"dd"\" "input"/"$4}' | sh >> $based2/temp2
paste $based2/temp1 $based2/temp2 | gawk '{print $2,$3,$5*100}' > $based2/datafordates/${filename}
rm $based2/temp1 $based2/temp2

