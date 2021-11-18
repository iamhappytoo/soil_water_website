gmtset BASEMAP_TYPE  plain
gmtset LABEL_FONT_SIZE 18p
gmtset HEADER_FONT_SIZE 18p
gmtset GRID_PEN_PRIMARY	2t4_4:p
gmtset GRID_PEN_SECONDARY 0t4_4:p
gmtset DOTS_PR_INCH 1800
inputd="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/04.MAPDATA/bayesianhistory/datafordates/"
outputd="/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/05.MAPPING/bayesianhistory"
cd $inputd
file=$1
#grdfile=${file}".grd"
figurename=$(echo "$file" | gawk 'BEGIN{FS="."} {print $1".jpg"}')
figuretitle=$(echo "$file" | gawk 'BEGIN{FS="."} {print $1}')
minvalue=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $8}')
maxvalue=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $9}')
#value_interval=$(echo $minvalue $maxvalue | gawk '{print ($2-$1)/50}')
#value_scale=$(echo $minvalue $maxvalue | gawk '{printf("%.1f", ($2-$1)/5)}')
minlo=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $2-1}')
maxlo=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $3+1}')
#dlo=$(echo $minlo $maxlo | | gawk '{print ($2-$1)/50}'
minla=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $5-1}')
maxla=$(minmax $file | gawk 'BEGIN{FS="[</>]"} {print $6+1}')
#dla=$(echo $minla $maxla | | gawk '{print ($2-$1)/50}'
#xyz2grd ${file} -R${minlo}/${maxlo}/${minla}/${maxla} -G${grdfile} -I${dlo}/${dla} -V
#makecpt -Cseis -T${minvalue}/${maxvalue}/${value_interval} -Z > polar1.cpt
#makecpt -Cseis -T0/100/1 -Z > polar1.cpt
#grdimage ${grdfile} -Cpolar1.cpt  -R${minlo}/${maxlo}/${minla}/${maxla} -JX6id/5id  -P -K -X1i -Y2i -Ba2f1:"Latitude":/a2f1:"Longitude"::."Image_${figurename}":WSen > ${figurename}
cd "/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update"
#pscoast -R-90/270/-80/90 -Jj90/1:400000000 -B45g45/30g30 -Dc -A10000 -Glightgray -W0.25p -P \
#pscoast -R${minlo}/${maxlo}/${minla}/${maxla} -Jj119/1:9000000 -X1i -Y1i -Ba2f1g5:"Latitude":/a2f1g5:"Longitude"::."Soil moisture percentile (%) ${figuretitle}":WSEN  -P -K -Dh -W -S235/235/255 -G211/211/211 -A1000 -Na -Lf-122/34/35/200k > $outputd/${figurename}
#pscoast -R-125/${maxlo}/32/${maxla} -Jj119/1:9000000 -X1i -Y3i -Ba2f1g5:"Latitude":/a2f1g5:"Longitude"::."Soil moisture percentile (%) ${figuretitle}":WSEN  -P -K -Dh -W -S235/235/255 -G211/211/211 -A1000 -Na -Lf-122/34/35/200k > $outputd/${figurename}
pscoast -R-125/${maxlo}/32/${maxla} -Jj119/1:9000000 -X1i -Y3i -Ba2f1g5:"Latitude":/a2f1g5:"Longitude"::."Soil moisture percentile (%) ${figuretitle}":WSEN  -P -K -Dh -W -S235/235/255 -G211/211/211 -A1000 -Na > $outputd/${figurename}
psxy -R-125/${maxlo}/32/${maxla} -Jj119/1:9000000 -Cpolar2.cpt -Sc0.1 -W1p/0/0/0 -P -K -O $inputd/$file >> $outputd/${figurename}
psscale -D3i/-0.5i/10c/0.6ch -O -Cpolar2.cpt -B:Percentile: -L >> $outputd/${figurename}
#echo ${value_scale}
convert $outputd/${figurename} $outputd/${figurename}

