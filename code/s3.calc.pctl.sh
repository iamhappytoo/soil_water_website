#!/bin/bash
##author: Zhaoxin Ban
##This is used for calculating the percentile value for the new value
##put every txt file from STEP02 into 03.CALC_PERCENT/SOURCE folder, and cat each line to catenate them into those files. 
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/"
iinputd="$based/02.DEPTH_INTEGRAL/all/history"
inputd="$based/03.CALC_PERCENT/sm.from.2018/"
rm $inputd/*.txt
cp $iinputd/*.txt $inputd/
for f in $inputd/*.txt
do
	python -c "import datetime as dt; print (dt.datetime.now()-dt.datetime(2017,12,31))"|awk '{print $1}' >> $inputd/temp
	nam=`basename $f`
	while read var1
	do
		head -$var1 $f > $inputd/new$nam
#		head -110 $f > $inputd/new$nam
		mv $inputd/new$nam $inputd/$nam
		sed -i 's/-/ /g' $f 
	done<$inputd/temp
	rm $inputd/temp
done
#awk '{print $1, $2, $3}' $inputd/750.txt > date  ###warning, its better to generate a new date. 
#awk '{print $2}' $inputd/daily.czc.txt > new.czc.txt
#mv new.czc.txt daily.czc.txt
#paste date daily.czc.txt > new.czc.txt
#mv new.czc.txt daily.czc.txt
getd="$based/03.CALC_PERCENT/pctl.from.2018"
outreald="$based/03.CALC_PERCENT/real.time.pctl"
##HERE IS TO CALCULATE THE PERCENTILE FOR UPDATED HISTORY DATA AND ADD IT TO "REALTIME/03.CALC_PERCENT/pctl.from.2018" FOLDER
python $based/ban.cal.pctl.py 
##HERE IS TO GET THE PERCENTILE FOR REALTIME DATA AND ADD IT TO "REALTIME/03.CALC_PERCENT/real.time.pctl" FOLDER
for f in $getd/*.txt
do
	nam=`basename $f`
	sed -i 's/\t/ /g' $f
	sed -i 's/ 1 /-01 /g' $f
        sed -i 's/ 2 /-02 /g' $f
        sed -i 's/ 3 /-03 /g' $f
        sed -i 's/ 4 /-04 /g' $f
        sed -i 's/ 5 /-05 /g' $f
        sed -i 's/ 6 /-06 /g' $f
        sed -i 's/ 7 /-07 /g' $f
        sed -i 's/ 8 /-08 /g' $f
        sed -i 's/ 9 /-09 /g' $f
        sed -i 's/ 1/-1/g' $f
        sed -i 's/ 2/-2/g' $f
        sed -i 's/ 3/-3/g' $f
        sed -i 's/ 4/-4/g' $f
        sed -i 's/ 5/-5/g' $f
        sed -i 's/ 6/-6/g' $f
        sed -i 's/ 7/-7/g' $f
        sed -i 's/ 8/-8/g' $f
        sed -i 's/ 9/-9/g' $f
	sed -i 's/-1-/-01-/g' $f
        sed -i 's/-2-/-02-/g' $f
        sed -i 's/-3-/-03-/g' $f
        sed -i 's/-4-/-04-/g' $f
        sed -i 's/-5-/-05-/g' $f
        sed -i 's/-6-/-06-/g' $f
        sed -i 's/-7-/-07-/g' $f
        sed -i 's/-8-/-08-/g' $f
        sed -i 's/-9-/-09-/g' $f
	sed -i 's/-1 /-01 /g' $f
        sed -i 's/-2 /-02 /g' $f
        sed -i 's/-3 /-03 /g' $f
        sed -i 's/-4 /-04 /g' $f
        sed -i 's/-5 /-05 /g' $f
        sed -i 's/-6 /-06 /g' $f
        sed -i 's/-7 /-07 /g' $f
        sed -i 's/-8 /-08 /g' $f
        sed -i 's/-9 /-09 /g' $f


	tail -7 $f > $outreald/$nam
done

