#!/bin/bash
##author: Zhaoxin Ban
##This is used for unifying the format of real-time data downloaded from hmt, nrcs, scan, soilscape, and uscrn
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update"
##Unifying format for data in hmt.
dhmt="$based/data/hmt"
dnrcs="$based/data/nrcs"
dscan="$based/data/scan"
duscrn="$based/data/uscrn"
dwrcc="$based/data/wrcc" ##wrcc stores the nearest 1 day data
outputdhmt="$based/01.CHANGE_FORMAT/hmt/history"
outputdhmt1="$based/01.CHANGE_FORMAT/hmt/realtime"
outputdnrcs="$based/01.CHANGE_FORMAT/nrcs/history"
outputdnrcs1="$based/01.CHANGE_FORMAT/nrcs/realtime"
outputdscan="$based/01.CHANGE_FORMAT/scan/history"
outputdscan1="$based/01.CHANGE_FORMAT/scan/realtime"
outputduscrn="$based/01.CHANGE_FORMAT/uscrn/history"
outputduscrn1="$based/01.CHANGE_FORMAT/uscrn/realtime"
outputdwrcc="$based/01.CHANGE_FORMAT/wrcc/history"
outputdwrcc1="$based/01.CHANGE_FORMAT/wrcc/realtime"
mkdir -p $outputdhmt
mkdir -p $outputdnrcs
mkdir -p $outputdscan
mkdir -p $outputduscrn
mkdir -p $outputdhmt1
mkdir -p $outputdnrcs1
mkdir -p $outputdscan1
mkdir -p $outputduscrn1
mkdir -p $outputdwrcc
mkdir -p $outputdwrcc1

##Unifying format for data in wrcc
##HERE IS TO EDIT THE REALTIME DATA
cp $dwrcc/*.txt $outputdwrcc1
for f in $outputdwrcc1/*.txt
do
	nam=`basename $f`
        sed -i '1,7d' $f
	head -n -6 $f > $outputdwrcc1/new$nam
	mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
	sed -i 's/\//-/g' $f
	awk '{print $1,$5,$8,$11}' $f > $outputdwrcc1/new$nam
	mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
	awk -f awk_example5.awk $f > $outputdwrcc1/temp$nam
	mv $outputdwrcc1/temp$nam $outputdwrcc1/$nam
	sed -i 's/-/ /g' $f
	awk '{print $3"-"$1"-"$2,$4,$5,$6}' $f > $outputdwrcc1/new$nam
        mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
done
##HERE IS TO UPDATE THE HISTORICAL DATA
for f in $outputdwrcc1/*.txt
do
        nam=`basename $f`
	head -n -6 $outputdwrcc/$nam > $outputdwrcc/new$nam
	mv $outputdwrcc/new$nam $outputdwrcc/$nam  ##delete the last 6 lines of the historic wrcc time series
	cat $f >> $outputdwrcc/$nam  ## add the last 7 days of the historic wrcc time series. Here the wrcc data successfully avoided the 7 day cross-year problem.
done
