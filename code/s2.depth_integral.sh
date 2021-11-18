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
mkdir $outputd
mkdir $outputd1
##unify and integral different depth data from hmt.
##HERE IS TO UPDATE THE HISTORICAL DATA 
#for f in $dhmt/*.txt
#do
#	nam=`basename $f`
#	echo $nam
#	awk '{ind=$2; if($3*$4*$5*$6*$7!=0) {a[ind]=0.5*0.02*($3*2*5+($3+$4)*(10-5)+($4+$5)*(15-10)+($5+$6)*(20-15)+($6+$7)*(50-20))} else if(($3 == 0) && ($4*$5*$6*$7 != 0)) {a[ind]=0.5*0.02*($4*10*2+($4+$5)*(15-10)+($5+$6)*(20-15)+($6+$7)*(50-20))} else if (($4 ==0) && ($3*$5*$6*$7 !=0)) {a[ind]=0.5*0.02*($3*2*5+($3+$5)*(15-5)+($5+$6)*(20-15)+($6+$7)*(50-20))} else if (($5 ==0) && ($3*$4*$6*$7 !=0)) {a[ind]=0.5*0.02*($3*2*5+($3+$4)*(10-5)+($4+$6)*(20-10)+($6+$7)*(50-20))} else if (($6 ==0) && ($3*$4*$5*$7 !=0)) {a[ind]=0.5*0.02*($3*2*5+($3+$4)*(10-5)+($4+$5)*(15-10)+($5+$7)*(50-15))} else if (($3 == 0) && ($4 == 0) && ($5*$6*$7 != 0)) {a[ind]=0.5*0.02*($5*2*15+($5+$6)*(20-15)+($6+$7)*(50-20))} else if (($4 == 0) && ($5 == 0) && ($3*$6*$7 != 0)) {a[ind]=0.5*0.02*($3*2*5+($3+$6)*(20-5)+($6+$7)*(50-20))} else if(($5 == 0) && ($6 == 0) && ($3*$4*$7 != 0)) {a[ind]=0.5*0.02*($3*2*5+($4+$3)*(10-5)+($4+$7)*(50-10))} else if (($3 == 0) && ($5 == 0) && ($4*$6*$7 != 0)) {a[ind]=0.5*0.02*($4*10*2+($6+$4)*(20-10)+($7+$6)*(50-20))} else if (($4 == 0) && ($6 == 0) && ($3*$5*$7 == 0)) {a[ind]=0.5*0.02*($3*5*2+($5+$3)*(15-5)+($7+$5)*(50-15))} else if (($3 == 0) && ($6 == 0) && ($4*$5*$7!=0)) {a[ind]=0.5*0.02*($4*10*2+($5+$4)*(15-10)+($7+$5)*(50-15))} else if (($3 == 0) && ($4 == 0) && ($6 == 0) && ($5*$7!=0)) {a[ind]=0.5*0.02*($5*15*2+($7+$5)*(50-15))} else if (($3 == 0) && ($4 == 0) && ($5 == 0) && ($6*$7 != 0)) {a[ind]=0.5*0.02*($6*20*2+($7+$6)*(50-20))} else if (($3 == 0) && ($5 == 0) && ($6 == 0) && ($4*$7 !=0)) {a[ind]=0.5*0.02*($4*10*2+($7+$4)*(50-10))} else if(($4 == 0) && ($5 == 0) && ($6 == 0) && ($3*$7!=0)) {a[ind]=0.5*0.02*($3*5*2+($7+$3)*(50-20))} else {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -n -k1 > $outputdhmt/$nam
#done
##HERE IS TO CALCULATE THE REALTIME DATA
#for f in $outputdhmt
#do
#	nam=`basename $f`
#	tail -7 $f >> $outputdhmt1/$nam
#done
##unify and integral different depth data from nrcs.
for f in $dnrcs/*.txt
do
	nam=`basename $f`
	echo $nam
	awk '{ind=$1; if(($2 !=0) && ($3!=0) && ($4!=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(20-5)+($3+$4)*(50-20))} else if(($2 == 0) && ($3 !=0) && ($4 != 0)) {a[ind]=0.5*0.02*($3*20*2+($3+$4)*(50-20))} else if (($2 !=0) && ($3 ==0) && ($4 != 0)) {a[ind]=0.5*0.02*($2*2*5+($2+$4)*(50-5))} else {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd/$nam
done
##HERE IS TO CALCULATE THE REALTIME DATA OF NRCS
for f in $dnrcs1/*.txt
do
        nam=`basename $f`
        echo $nam
        awk '{ind=$1; if(($2 !=0) && ($3!=0) && ($4!=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(20-5)+($3+$4)*(50-20))} else if(($2 == 0) && ($3 !=0) && ($4 != 0)) {a[ind]=0.5*0.02*($3*20*2+($3+$4)*(50-20))} else if (($2 !=0) && ($3 ==0) && ($4 != 0)) {a[ind]=0.5*0.02*($2*2*5+($2+$4)*(50-5))} else {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd1/$nam
done
##unify and integral different depth data from scan.
for f in $dscan/*.txt
do
	nam=`basename $f`
	echo $nam
	awk '{ind=$1; if($2*$3*$4*$5!=0) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$4)*(20-10)+($4+$5)*(50-20))} else if(($2 == 0) && ($3*$4*$5 != 0)){a[ind]=0.5*0.02*($3*10*2+($3+$4)*(20-10)+($4+$5)*(50-20))} else if (($3 ==0) && ($2*$4*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$4)*(20-5)+($4+$5)*(50-20))} else if (($4 ==0) && ($2*$3*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$5)*(50-10))} else if (($2 ==0) && ($4 ==0) && ($3*$5 !=0)){a[ind]=0.5*0.02*($3*2*10+($3+$5)*(50-10))} else if(($2 ==0) && ($3 ==0) && ($4*$5 !=0)){a[ind]=0.5*0.02*($4*2*20+($4+$5)*(50-20))} else if(($3 ==0) && ($4 ==0) && ($2*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$5)*(50-5))} else if(($5==0) || (($2==0) && ($3==0) && ($4==0))) {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd/$nam
done
##HERE IS TO CALCULATE THE REALTIME DATA OF SCAN
for f in $dscan1/*.txt
do
        nam=`basename $f`
        echo $nam
        awk '{ind=$1; if($2*$3*$4*$5!=0) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$4)*(20-10)+($4+$5)*(50-20))} else if(($2 == 0) && ($3*$4*$5 != 0)){a[ind]=0.5*0.02*($3*10*2+($3+$4)*(20-10)+($4+$5)*(50-20))} else if (($3 ==0) && ($2*$4*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$4)*(20-5)+($4+$5)*(50-20))} else if (($4 ==0) && ($2*$3*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$5)*(50-10))} else if (($2 ==0) && ($4 ==0) && ($3*$5 !=0)){a[ind]=0.5*0.02*($3*2*10+($3+$5)*(50-10))} else if(($2 ==0) && ($3 ==0) && ($4*$5 !=0)){a[ind]=0.5*0.02*($4*2*20+($4+$5)*(50-20))} else if(($3 ==0) && ($4 ==0) && ($2*$5 !=0)){a[ind]=0.5*0.02*($2*2*5+($2+$5)*(50-5))} else if(($5==0) || (($2==0) && ($3==0) && ($4==0))) {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd1/$nam
done
##unify and integral different depth data from soilscape.
##unify and integral different depth data from uscrn.
for f in $duscrn/*.txt
do
	nam=`basename $f`
	echo $nam
	awk '{ind=$1; if($2*$3*$4*$5!=0) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$4)*(20-10)+($4+$5)*(50-20))} else if(($2 == 0) && ($3*$4*$5 != 0)) {a[ind]=0.5*0.02*($3*10*2+($3+$4)*(20-10)+($4+$5)*(50-20))} else if (($3 ==0) && ($2*$4*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$4)*(20-5)+($4+$5)*(50-20))} else if (($4 ==0) && ($2*$3*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$5)*(50-10))} else if (($2 ==0) && ($4 ==0) && ($3*$5 !=0)) {a[ind]=0.5*0.02*($3*2*10+($3+$5)*(50-10))} else if(($2 ==0) && ($3 ==0) && ($4*$5 !=0)) {a[ind]=0.5*0.02*($4*2*20+($4+$5)*(50-20))} else if(($3 ==0) && ($4 ==0) && ($2*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$5)*(50-5))} else if(($5==0) || (($2==0) && ($3==0) && ($4==0))) {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd/$nam
done
##HERE IS TO CALCULATE THE REALTIME DATA OF USCRN
##unify and integral different depth data from uscrn.
for f in $duscrn1/*.txt
do
        nam=`basename $f`
        echo $nam
        awk '{ind=$1; if($2*$3*$4*$5!=0) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$4)*(20-10)+($4+$5)*(50-20))} else if(($2 == 0) && ($3*$4*$5 != 0)) {a[ind]=0.5*0.02*($3*10*2+($3+$4)*(20-10)+($4+$5)*(50-20))} else if (($3 ==0) && ($2*$4*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$4)*(20-5)+($4+$5)*(50-20))} else if (($4 ==0) && ($2*$3*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$3)*(10-5)+($3+$5)*(50-10))} else if (($2 ==0) && ($4 ==0) && ($3*$5 !=0)) {a[ind]=0.5*0.02*($3*2*10+($3+$5)*(50-10))} else if(($2 ==0) && ($3 ==0) && ($4*$5 !=0)) {a[ind]=0.5*0.02*($4*2*20+($4+$5)*(50-20))} else if(($3 ==0) && ($4 ==0) && ($2*$5 !=0)) {a[ind]=0.5*0.02*($2*2*5+($2+$5)*(50-5))} else if(($5==0) || (($2==0) && ($3==0) && ($4==0))) {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd1/$nam
done
##HERE IS TO CALCULATE THE REALTIME DATA OF WRCC
#for f in $dwrcc1/*.txt
#do
#	nam=`basename $f`
#	echo $nam
#	awk '{ind=$1; if(($2 !=0) && ($3!=0) && ($4!=0)) {a[ind]=0.5*0.02*($2*2*10+($2+$3)*(20-10)+($3+$4)*(50-20))} else if(($2 == 0) && ($3 !=0) && ($4 !=0)) {a[ind]=0.5*0.02*($3*20*2+($3+$4)*(50-20))} else if (($2 !=0) && ($3 == 0) && ($4 != 0)) {a[ind]=0.5*0.02*($2*2*10+($2+$4)*(50-10))} else {a[ind]=0}} END {for (y in a) print y, a[y]}' $f|sort -k1,1 > $outputd1/$nam
#done
##HERE IS TO UPDATE THE HISTORY DATA
#for f in $dwrcc/*.txt
#do
#	nam=`basename $f`
#	cat $outputd1/$nam >> $outputd/$nam
#done
