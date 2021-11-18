#!/bin/bash
##Source: /Downloads/02.15.smdatabase/qctestdata/soilscape/test/daily/new/delbreak/integral/junk
based="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/"
inputd="$based/01.CHANGE_FORMAT/vic"
outputd="$based/02.DEPTH_INTEGRAL/vic"

mkdir $outputd
while read var1 var2 var3 var4 var5
do	
	awk -v v3=$var3 -v v4=$var4 -v v5=$var5 '{ind=$1; a[ind]=($2+$3+$4*(0.5-v4-v3)/v5)/500} END {for (y in a) print y, a[y]}' $inputd/$var1.txt|sort -k1,1 > $outputd/$var1.txt
done <$based/scp.use.name_coor_depth.index
