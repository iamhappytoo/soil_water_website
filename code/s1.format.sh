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
#cp $dhmt/* $outputdhmt
#python -c "import datetime as dt; print (dt.datetime.now()-dt.datetime(2018,1,1))"|awk '{print $1}' >> temp.txt
#while read var1 ###download previous seven days data from hmt website 
#do
#	var2=`echo "${var1}-6" |bc`
#        echo $var1
#        echo $var2
#	for d in {001..110}
#	do
#		for h in {00..23};
#		do
#			###HERE IS TO EDIT THE FORMAT OF HISTORY DATA
#			sed -i 's/,/\t/g' $outputdhmt/czc18${d}.${h}.txt 
#		        awk '{print $1, $2, $3, $13, $14, $15, $16, $17}' $outputdhmt/czc18${d}.${h}.txt >> $outputdhmt/newczc18${d}.${h}.txt
#		        mv $outputdhmt/newczc18${d}.${h}.txt $outputdhmt/czc18${d}.${h}.txt
#		        awk '{ind=($3-($3%100))/100; a4[ind]+=$4; a5[ind]+=$5; a6[ind]+=$6; a7[ind]+=$7; a8[ind]+=$8; n[ind]++} END {for(y in a4) print $1, $2, y, a4[y]/n[y], a5[y]/n[y], a6[y]/n[y], a7[y]/n[y], a8[y]/n[y]}' $outputdhmt/czc18${d}.${h}.txt|sort -n -k3 >> $outputdhmt/hourly.czc.${d}.txt
#    			awk '{ind=$2; a4[ind]+=$4; a5[ind]+=$5; a6[ind]+=$6; a7[ind]+=$7; a8[ind]+=$8; n[ind]++} END {for(y in a4) print $1, y, a4[y]/n[y], a5[y]/n[y], a6[y]/n[y], a7[y]/n[y], a8[y]/n[y]}' $outputdhmt/hourly.czc.${d}.txt > $outputdhmt/daily.czc.${d}.txt
#		done
#	done
#done<temp.txt
#rm temp.txt
###HERE IS TO EDIT THE UPDATED HISTORY DATA
#for d in {001..089}
#do
#	cat $outputdhmt/daily.czc.${d}.txt >> $outputdhmt/daily.czc.txt
#done
#rm $outputdhmt/hourly*
#rm $outputdhmt/daily.czc.???.txt
#rm $outputdhmt/czc18*
###HERE IS TO EDIT THE REALTIME DATA
#tail -7 $outputdhmt/daily.czc.txt > $outputdhmt1/daily.czc.txt

#Unifying format for data in nrcs.
##HERE IS TO EDIT THE UPDATED HISTORY DATA
cp $dnrcs/* $outputdnrcs
for f in $outputdnrcs/*; do sed -i.bak -e '/2018-01-01/,$!d' $f; done
rm $outputdnrcs/*.bak
for f in $outputdnrcs/*; do sed -i 's/,/\t/g' $f; done
for f in $outputdnrcs/*; do nam=`basename $f`; awk '{ print $1, $2*0.01, $3*0.01, $4*0.01}' $f > $outputdnrcs/temp$nam; mv $outputdnrcs/temp$nam $outputdnrcs/$nam; done
#for f in $outputdnrcs/*; do nam=`basename $f`; awk '{ print $1, $2*0.01, $3*0.01, $4*0.01}' $f > $outputdnrcs/temp$nam; mv $outputdnrcs/temp$nam $outputdnrcs/$nam; done
##HERE IS TO EDIT THE REALTIME DATA
for f in $outputdnrcs/*
do
	nam=`basename $f`
	tail -7 $outputdnrcs/$nam > $outputdnrcs1/$nam
done

#Unifying format for data in scan.
##HERE IS TO EDIT THE UPDATED HISTORY DATA
cp $dscan/* $outputdscan
for f in $outputdscan/*; do sed -i.bak -e '/2018-01-01/,$!d' $f; done
rm $outputdscan/*.bak
for f in $outputdscan/*; do sed -i 's/,/\t/g' $f; done
for f in $outputdscan/*; do nam=`basename $f`; awk '{print $1, $2*0.01, $3*0.01, $4*0.01, $5*0.01}' $f > $outputdscan/temp$nam; mv $outputdscan/temp$nam $outputdscan/$nam; done
#for f in $outputdscan/*; do nam=`basename $f`; awk '{print $1, $2*0.01, $3*0.01, $4*0.01, $5*0.01}' $f > $outputdscan/temp$nam; mv $outputdscan/temp$nam $outputdscan/$nam; done
##HERE IS TO EDIT THE REALTIME DATA
for f in $outputdscan/*
do
	nam=`basename $f`
	tail -7 $outputdscan/$nam > $outputdscan1/$nam
done

#Unifying format for data in soilscape.
#Unifying format for data in uscrn.
##HERE IS TO EDIT THE UPDATED HISTORY DATA
cp $duscrn/* $outputduscrn
for f in $outputduscrn/*
do
	nam=`basename $f`
	awk '{ print ($2-($2%10000))/10000,"-",($2%10000-$2%100)/100,"-",($2%100), $19, $20, $21, $22}' $f > $outputduscrn/temp$nam
	sed -i 's/ - /-/g' $outputduscrn/temp$nam
	sed -i 's/-1-/-01-/g' $outputduscrn/temp$nam
        sed -i 's/-2-/-02-/g' $outputduscrn/temp$nam
        sed -i 's/-3-/-03-/g' $outputduscrn/temp$nam
        sed -i 's/-4-/-04-/g' $outputduscrn/temp$nam
        sed -i 's/-5-/-05-/g' $outputduscrn/temp$nam
        sed -i 's/-6-/-06-/g' $outputduscrn/temp$nam
        sed -i 's/-7-/-07-/g' $outputduscrn/temp$nam
        sed -i 's/-8-/-08-/g' $outputduscrn/temp$nam
        sed -i 's/-9-/-09-/g' $outputduscrn/temp$nam
        sed -i 's/-1 /-01 /g' $outputduscrn/temp$nam
        sed -i 's/-2 /-02 /g' $outputduscrn/temp$nam
        sed -i 's/-3 /-03 /g' $outputduscrn/temp$nam
        sed -i 's/-4 /-04 /g' $outputduscrn/temp$nam
        sed -i 's/-5 /-05 /g' $outputduscrn/temp$nam
        sed -i 's/-6 /-06 /g' $outputduscrn/temp$nam
        sed -i 's/-7 /-07 /g' $outputduscrn/temp$nam
        sed -i 's/-8 /-08 /g' $outputduscrn/temp$nam
        sed -i 's/-9 /-09 /g' $outputduscrn/temp$nam
	sed -i 's/-99.000/0/g' $outputduscrn/temp$nam
	mv $outputduscrn/temp$nam $outputduscrn/$nam
	sed -i.bak -e '/2018-01-01/,$!d' $outputduscrn/$nam
	rm $outputduscrn/$nam.bak
done
##HERE IS TO EDIT THE REALTIME DATA
for f in $outputduscrn/*
do	
	nam=`basename $f`
	tail -7 $outputduscrn/$nam > $outputduscrn1/$nam
done
#Unifying format for data in wrcc
#HERE IS TO EDIT THE REALTIME DATA
#cp $dwrcc/*.txt $outputdwrcc1
#for f in $outputdwrcc1/*.txt
#do
#	nam=`basename $f`
#        sed -i '1,7d' $f
#	head -n -6 $f > $outputdwrcc1/new$nam
#	mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
#	sed -i 's/\//-/g' $f
#	awk '{print $1,$5,$8,$11}' $f > $outputdwrcc1/new$nam
#	mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
#	awk -f awk_example5.awk $f > $outputdwrcc1/temp$nam
#	mv $outputdwrcc1/temp$nam $outputdwrcc1/$nam
#	sed -i 's/-/ /g' $f
#	awk '{print $3"-"$1"-"$2,$4,$5,$6}' $f > $outputdwrcc1/new$nam
#       mv $outputdwrcc1/new$nam $outputdwrcc1/$nam
#done
##HERE IS TO UPDATE THE HISTORICAL DATA
#for f in $outputdwrcc1/*.txt
#do
#        nam=`basename $f`
#	cat $f >> $outputdwrcc/$nam
#done
###This is to edit the vic data
#mkdir -p 01.CHANGE_FORMAT/vic
#mkdir -p tempvic
#while read var1 var2
#do
#	cp data/vic/fluxes_$var2 tempvic/temp$var1.txt
#	awk '{print $1"-"$2"-"$3,$9,$10,$11}' tempvic/temp$var1.txt > tempvic/$var1.txt
#	tail -1 tempvic/$var1.txt >> 01.CHANGE_FORMAT/vic/$var1.txt
#done<scp.use.name
#rm -r tempvic


