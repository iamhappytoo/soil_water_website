#!/bin/bash
##author: Zhaoxin Ban
##This is used for unify and integral the difference soil depth for data from hmt, nrcs, scan, soilscape, uscrn
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update"
dhmt="$based/01.CHANGE_FORMAT/hmt/history"
dnrcs="$based/01.CHANGE_FORMAT/nrcs/history"
dscan="$based/01.CHANGE_FORMAT/scan/history"
duscrn="$based/01.CHANGE_FORMAT/uscrn/history"
dwrcc="$based/01.CHANGE_FORMAT/wrcc/history"
dhmt1="$based/01.CHANGE_FORMAT/hmt/realtime"
dnrcs1="$based/01.CHANGE_FORMAT/nrcs/realtime"
dscan1="$based/01.CHANGE_FORMAT/scan/realtime"
duscrn1="$based/01.CHANGE_FORMAT/uscrn/realtime"
dwrcc1="$based/01.CHANGE_FORMAT/wrcc/realtime"
outputd="$based/02.DEPTH_INTEGRAL/all/history"
outputd1="$based/02.DEPTH_INTEGRAL/all/realtime"
mkdir -p $outputd
mkdir -p $outputd1

##unify and integral different depth data from wrcc
##HERE IS TO CALCULATE THE REALTIME DATA
for f in $dwrcc1/*.txt
do
	nam=`basename $f`
	echo $nam
	awk '{ind=$1; if(($2 !=0) && ($3!=0) && ($4!=0)) {a[ind]=0.5*0.02*($2*2*10+($2+$3)*(20-10)+($3+$4)*(50-20))} else if(($2 == 0) && ($3 !=0) && ($4 !=0)) {a[ind]=0.5*0.02*($3*20*2+($3+$4)*(50-20))} else if (($2 !=0) && ($3 == 0) && ($4 != 0)) {a[ind]=0.5*0.02*($2*2*10+($2+$4)*(50-10))} else {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd1/$nam
done
##HERE IS TO UPDATE THE HISTORY DATA
#for f in $dwrcc/*.txt
#do
#	nam=`basename $f`
#	cat $outputd1/$nam >> $outputd/$nam
#done

for f in $dwrcc1/*.txt
do
	nam=`basename $f`
	head -n -6 $outputd/$nam > $outputd/new$nam  
	mv $outputd/new$nam $outputd/$nam  ##delete the last 6 days of the 02_DEPTH_INTEGRAL/all/history/*.txt wrcc record data
	cat $outputd1/$nam >> $outputd/$nam  ##add the last 7 days to the end of the history data, and therefore updated the data
done
