#!/bin/bash
##author: Zhaoxin Ban
##This is used for calculating the percentile value for the new value
##put every txt file from STEP02 into 03.CALC_PERCENT/SOURCE folder, and cat each line to catenate them into those files. 
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/"
iinputd="$based/02.DEPTH_INTEGRAL/vic"
inputd="$based/03.CALC_PERCENT/vic.sm.from.2018/"
rm $inputd/*.txt
cp $iinputd/*.txt $inputd/
for f in $inputd/*.txt
do
	python -c "import datetime as dt; print (dt.datetime.now()-dt.datetime(2017,12,31))"|awk '{print $1}' >> $inputd/temp
	nam=`basename $f`
	while read var1
	do
		var1=`echo "${var1}-1" |bc`
		head -$var1 $f > $inputd/new$nam
		mv $inputd/new$nam $inputd/$nam
		sed -i 's/-/ /g' $f 
	done<$inputd/temp
#	rm $inputd/temp
done
