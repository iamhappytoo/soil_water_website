#!/usr/local/bin/python
import numpy as np
import pandas as pd
import argparse
import pdb
from glob import glob
from os.path import basename
from pathlib import Path
for ffname in glob("/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/sm.from.2018/*.txt"):
	nam=basename(ffname)
#	print(ffname)
	aalld = np.loadtxt(ffname)
#	pctl =  np.empty(len(aalld), dtype=float)
	ddate = aalld[:,1]*100+aalld[:,2]
	uudate = np.unique(ddate) ###!!!!so far we are in 2018 so we do not need to do so. But later we are not 2018..!!!!
#	for fname in glob("/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/sm.history/*.txt"):   ###get data
#		nam=basename(fname)    ##nam=pctl.454.txt like example
		#fout = open("pctl."+nam, "w")  ##write to new result.

# prepare data
	alld = np.loadtxt("/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/bayesian.sm.history/"+nam)
	data = alld[0:7305,:]  ### skip the first and last two years
	date = data[:,1]*100+data[:,2]
	ymd = data[:,0]*10000+data[:,1]*100+data[:,2]
#	udate = np.unique(date)  ###get unique date index
		
# date loop
	for di in range(len(uudate)):   ###only calculate the percentile for date in sm.from.2018/*.txt
		iindm =  np.nonzero(ddate==uudate[di])[0]
    	 	ddatam = aalld[iindm,:]
	 	ssm = ddatam[:, 3]
		indm = np.nonzero(date==uudate[di])[0]    ###if the date is equals to the di row and the first column of array udate ( like di=3 column=0, udate[3]=104, date=104 have several row indexes) then indm becomes an array storing the index
		ymdm = ymd[indm]     ###ymd is also an array from (19980101-20171231) 
		datam = data[indm,:]    ###data stores the corresponding sm data.
# get all pentad for the same date
		sm = datam[:, 3]    ###remember udate stores the sm data. 
			#sm_od = np.sort(sm) # get increasing sm array
# Start comparison
		for i in range(len(ssm)):
			thisssm = ddatam[i,3]
			###comparison start: I have sm_od with len(sm), I have thisssm to be compared, I want to get indsm to show the relative rank of thissm in the part. I put this in the sm_od link
			compsm =  np.empty(len(sm)+1, dtype=float)
			for j in range(len(compsm)-1):
				compsm[j] = sm[j]
			compsm[len(compsm)-1] = thisssm
			sm_od = np.sort(compsm)
			indsm = np.nonzero(sm_od==thisssm)[0]
			m = iindm[i]
			if sm_od[indsm[0]] == 0:
				pctl = 0
			elif indsm[0] == 0:
  				pctl = 0.7/(len(sm)+0.4)
			elif indsm[0] == len(compsm)-1:
				pctl = (len(sm)-0.3)/(len(sm)+0.4)
			else: 
				pctl = (thisssm-sm_od[indsm[0]-1])/(sm_od[indsm[0]+1]-sm_od[indsm[0]-1])*(1/(len(sm)+0.4))+(indsm[0]-0.3)/(len(sm)+0.4)
			###comparison end, get pctl
			#m = iindm[i]
			aalld[m,3]=pctl	

####End the process
####Start write the file
#	p = pathlib.Path("/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/pctl.from.2018/")
	fout = open("/raid4/forecast/pnw_sw_monitor/soil_moisture_obs_update/03.CALC_PERCENT/bayesian.pctl.from.2018/pctl."+nam, "w")
	for i in range(len(aalld[:,0])):
	#	with p.open("pctl."+nam, "w") as f:
        	fout.write(str(int(aalld[i,0]))+' '+str(int(aalld[i,1]))+' '+str(int(aalld[i,2]))+' '+"{0:.4f}".format(aalld[i,3])+"\n")
			#str(pctl[i])+"\n")
	fout.close()
