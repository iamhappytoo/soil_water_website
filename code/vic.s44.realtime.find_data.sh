#/bin/sh
#Find data point on a certain date
yy=$1
mm=$2
dd=$3
filename=$yy$mm$dd".dat"
based2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/vicrealtime"
inputd2="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/vic.real.time.pctl"
mkdir -p $based2/datafordates
cat $based2/newfilelist.dat | gawk '{print $1,$2,$3}' >> $based2/temp1
while read v1 v2 v3 v4
do
	grep -i "${yy}-${mm}-${dd}" $inputd2/$v4  > $based2/temp
	if [ -s $based2/temp ]
	then
		cat $based2/temp >> $based2/temp2
	else
		echo "${yy}-${mm}-${dd} 0" >> $based2/temp2	
	fi
done<$based2/newfilelist.dat
#cat $based2/newfilelist.dat | gawk -v yy="$yy" -v mm="$mm" -v dd="$dd" -v input="$inputd2" '{print "grep \""yy"-"mm"-"dd"\" "input"/"$4}' | sh >> $based2/temp2
paste $based2/temp1 $based2/temp2 | gawk '{print $2,$3,$5*100}' > $based2/datafordates/${filename}
rm $based2/temp1 $based2/temp2

