library(lubridate)
library(timeDate)
###This is a script that consider lunar year, consider moving window, while doesn't consider update in soil moisture extension.
setwd("/home/zban/Downloads/02.15.smdatabase/wholets/vicwholets/longrecordsta/")
list=list.files()
ls=length(list)
for(ll in 1:ls) 
{
  data=read.table(list[ll])
  setwd("/home/zban/Downloads/02.15.smdatabase/wholets/obswholets/longrecordsta/")
  data1=read.table(list[ll])
  setwd("/home/zban/Downloads/02.15.smdatabase/wholets/vicwholets/longrecordsta/")
  smvic=array(0,dim=c(7305,31))
  date=array(0,dim=c(7305,31))
  numdate=rep(0,7305)
  for (i in 1:7305)
  {
    numdate[i]=data[i,1]
  }
  for(i in 1:7305){
    for(j in 1:31){
      if(i+j-1==7305){
        temp=7305
      }
      else{
        temp=(i+j-1)%%7305
      }
      smvic[i,j]=data[temp,2]
      date[i,j]=data[temp,1]
    }
  }
  l=length(data1[,1])
  date1=data1[,1]
  numdate1=rep(0,l)
  for (i in 1:l)
  {
    numdate1[i]=julian(as.Date(date1[i]), origin = as.Date("1997-12-31"))
  }
  smobs=array(0,dim=c(7305,31))
  temp=array(0,dim=c(31,2))
  for(i in 1:l){
    if(numdate1[i]<=7305){ ###here 1161 value
      temp=which(date == numdate1[i], arr.ind=T)
      for(j in 1:31){
        smobs[temp[j,1],temp[j,2]]=data1[i,2] 
      } 
    }
  }
  Adde=c(365,365,366,365,365,365,366,365,365,365,366,365,365,365,366,365,365,365,366)
  Addl=c(365,366,365,365,365,366,365,365,365,366,365,365,365,366,365,365,365,366,365)
  Addy=c(790,2251,3712,5173,6634) ##this is the index of rows whose middle is Feb 29
  result=rep(0,7305)
  for (start in 1:366){
    try=rep(0,20)
    m=start
    vicx=NULL ##To save 20 years of data for one date
    obsx=NULL
    if(m==60){#if m is Feb 29
      for (i in 1:5){
        vicx=c(vicx,smvic[Addy[i],])
        obsx=c(obsx,smobs[Addy[i],])
      }##get vic and obs 20 years (5 lunar years) windows series and save them in vicx and obsx respectively
    }  else if(m<60){
      n=1
      try[n]=m
      vicx=c(vicx,smvic[m,])
      obsx=c(obsx,smobs[m,])
      for(t in 1:19){
        ##if it is not Feb29
        m=m+Adde[t]
        n=n+1
        try[n]=m
        if(m==7305){
          cc=7305 
        }  else{
          cc=m%%7305
        }
        vicx=c(vicx,smvic[cc,])
        obsx=c(obsx,smobs[cc,])
      }##get vic 20 year of series
    } else if(m>60){
      m=m-1
      n=1
      try[n]=m
      vicx=c(vicx,smvic[m,])
      obsx=c(obsx,smobs[m,])
      for(t in 1:19){##if it is not Feb29
        m=m+Addl[t]
        n=n+1
        try[n]=m
        if(m==7305){
          cc=7305 
        }  else{
          cc=m%%7305
        }
        vicx=c(vicx,smvic[cc,])
        obsx=c(obsx,smobs[cc,])
      }##get vic 20 year of series
    }
    mx=mean(vicx)
    S2x=var(vicx) ##This part is the same for both Feb 29 and non Feb 29 days
    nonzero=NULL
    zero=NULL
    nonzero=which(obsx!=0) ##list of index of nonzero value in obs
    zero=which(obsx==0) ##list of index of zero value in obs
    N1=length(nonzero)  ##N1 is the number of nonzero value in obs
    N2=length(obsx)-N1  ##N2 is the number of zero value in obs
    obsy1=rep(0,N1) ##store the nonzero value in obs and in original order
    vicx2=rep(0,N2)
    vicx1=rep(0,N1)
    for(i in 1:N1){
      obsy1[i]=obsx[nonzero[i]]
      vicx1[i]=vicx[nonzero[i]]
    }
    for(i in 1:N2){
      vicx2[i]=vicx[zero[i]]
    }
    my1=mean(obsy1)
    S2y1=var(obsy1)
    Sy1=sd(obsy1)
    mx2=mean(vicx2)
    S2x2=var(vicx2)
    Sx2=sd(vicx2)
    if(Sx2==0){
      sprintf("Sx2=0")
      break
    }
    mx1=mean(vicx1)
    S2x1=var(vicx1)
    if(S2x1==0){
      sprintf("S2x1=0")
      break
    }
    r=cor(vicx1,obsy1)
    if(((N2-1)==0)||((N1-3)==0)||((N1-2)==0))
    {
      sprintf("N2-1= ", N2-1)
      sprintf("N1-3= ", N1-3)
      sprintf("N1-2= ", N1-2)
      break
    } 
    alpha2=N2*(N1-4)*(N1-1)/((N2-1)*(N1-3)*(N1-2))
    if(start==60) ##calculate all of the years that has the same date: Feb 29
    {
      for(i in 1:5){
        if(smobs[Addy[i],16]==0){
          rel=my1+N2/(N1+N2)*r*Sy1/Sx2*(mx2-mx1)+sqrt(1/(N1+N2-1)*((N1-1)*S2y1+(N2-1)*r*r*S2y1/S2x1*S2x2+(N2-1)*alpha2*(1-r*r)*S2y1+N1*N2/(N1+N2)*r*r*S2y1/S2x1*(mx2-mx1)^2))/Sx2*(smvic[Addy[i],16]-mx)
          temp=which(date == date[Addy[i],16], arr.ind=T)
          if(is.na(rel))
          {
            sprintf("result is NA, start is %i, t is %i",start, t)
            break
          } 
          result[Addy[i]]=rel  
        } else if(smobs[Addy[i],16]>0){
          temp=which(date == date[Addy[i],16], arr.ind=T)
          result[Addy[i]]=smobs[Addy[i],16]
          if(is.na(rel))
          {
            sprintf("result is NA when smobs record shouldn't be zero! Start is %i, t is %i", start, t)
            break
          } 
        }
      }
    } 
    if(start!=60)
    {
      for(t in 1:20){
        if(smobs[try[t],16]==0){
          rel=my1+N2/(N1+N2)*r*Sy1/Sx2*(mx2-mx1)+sqrt(1/(N1+N2-1)*((N1-1)*S2y1+(N2-1)*r*r*S2y1/S2x1*S2x2+(N2-1)*alpha2*(1-r*r)*S2y1+N1*N2/(N1+N2)*r*r*S2y1/S2x1*(mx2-mx1)^2))/Sx2*(smvic[try[t],16]-mx)
          temp=which(date == date[try[t],16], arr.ind=T)
          if(is.na(rel))
          {
            sprintf("result is NA. start is %i, t is %i", start,t)
            break
          } 
          result[try[t]]=rel
        }
        else if(smobs[try[t],16]>0){
          temp=which(date == date[try[t],16], arr.ind=T)
          rel=smobs[try[t],16]
          result[try[t]]=rel
        }
      }
    } ##finish calculating the statistics for all non lunar days
  }
  setwd("/home/zban/Downloads/02.15.smdatabase/wholets/vicwholets/movingwindow.no.log.no.update.result/")
  write.table(result, file=list[ll],row.names= FALSE)
  setwd("/home/zban/Downloads/02.15.smdatabase/wholets/vicwholets/longrecordsta/")
}
