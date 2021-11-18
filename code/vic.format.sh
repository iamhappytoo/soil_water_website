#!/bin/bash
#This is to edit the format of fluxes, and choose the time series from 
#for f in data/vic/fluxes*
#do
#	sed -i '1,26d' $f 
#	nam=`basename $f`
#	head -n -x $f >> new$nam
#	mv new$nam $nam
#done
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/"
outputd="$based/01.CHANGE_FORMAT/vic"
mkdir -p $outputd
mkdir -p $based/tempvic
while read var1 var2
do
	cp $based/data/vic/fluxes_$var2 $based/tempvic/temp$var1.txt
	awk '{print $1"-"$2"-"$3,$9,$10,$11}' $based/tempvic/temp$var1.txt > $based/tempvic/$var1.txt
	#mv $based/tempvic/$var1.txt $outputd/$var1.txt
	head -n -6 $outputd/$var1.txt > $outputd/new$var1.txt
	mv $outputd/new$var1.txt $outputd/$var1.txt  ##delete the last 6 lines of the record
	tail -7 $based/tempvic/$var1.txt >> $outputd/$var1.txt   ##add new 7 lines of the record
done<$based/scp.use.name
rm -r $based/tempvic
