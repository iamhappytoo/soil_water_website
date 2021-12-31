setwd("/home/zban/Downloads/02.15.smdatabase/wholets/vicwholets/")
data=read.table("integral321.txt")
data[,2]=log(data[,2])
mx=mean(data[,2])
S2x=var(data[,2])
l=length(data[,2])  ##l=N1+N2
list=list.files()
ls=length(list)
setwd("/home/zban/Downloads/02.15.smdatabase/wholets/obswholets/")
data1=read.table("321.csv")
  N1=0
  N2=0
  N1ysum=NULL
  N1xsum=NULL
  N2xsum=NULL
  t=1
  m=1
  n=1
  data1[,1] <- factor(data1[,1], levels=data[,1])
  for(i in 1:l)
  {
    if(is.na(data1[t,2])){
      N2=N2+1
      N2xsum[n]=data[i,2]
      n=n+1
    }
    else{
      if(data1[t,1]==data[i,1])##If they are at the same date, t can increase, or t will remain at 1 or t
      {
        if(data1[t,2]>0){
          N1=N1+1  ##This is for calculating N1
          N1ysum[m]=log(data1[t,2])  ##This is for calculating my1 and Sy1
          N1xsum[m]=data[i,2]
          m=m+1
        }
        else if(data1[t,2]==0){
          N2=N2+1
          N2xsum[n]=data[i,2]
          n=n+1
        }
        t=t+1
      }
      else{
        N2=N2+1
        N2xsum[n]=data[i,2]
        n=n+1
      }
    }
  }
  my1=mean(N1ysum) #Use sum to get my1
  S2y1=var(N1ysum) #Use sum to get Sy1
  Sy1=sd(N1ysum)
  mx2=mean(N2xsum)
  S2x2=var(N2xsum)
  Sx2=sd(N2xsum)
  mx1=mean(N1xsum)
  S2x1=var(N1xsum)
  r=cor(N1xsum,N1ysum)
  result=rep(0,l)
  t=1
  alpha2=N2*(N1-4)*(N1-1)/((N2-1)*(N1-3)*(N1-2))
  for(i in 1:l)
  {
    if(is.na(data1[t,2])){
      result[i]=my1+N2/(N1+N2)*r*Sy1/Sx2*(mx2-mx1)+sqrt(1/(N1+N2-1)*((N1-1)*S2y1+(N2-1)*r*r*S2y1/S2x1*S2x2+(N2-1)*alpha2*(1-r*r)*S2y1+N1*N2/(N1+N2)*r*r*S2y1/S2x1*(mx2-mx1)^2))/Sx2*(data[i,2]-mx)
    }
    else{
      if(data1[t,1]==data[i,1]){
        if(data1[t,2]>0){
          result[i]=log(data1[t,2])
        }
        else if(data1[t,2]==0){
          result[i]=my1+N2/(N1+N2)*r*Sy1/Sx2*(mx2-mx1)+sqrt(1/(N1+N2-1)*((N1-1)*S2y1+(N2-1)*r*r*S2y1/S2x1*S2x2+(N2-1)*alpha2*(1-r*r)*S2y1+N1*N2/(N1+N2)*r*r*S2y1/S2x1*(mx2-mx1)^2))/Sx2*(data[i,2]-mx)
        }
        t=t+1
      }
      else{
        result[i]=my1+N2/(N1+N2)*r*Sy1/Sx2*(mx2-mx1)+sqrt(1/(N1+N2-1)*((N1-1)*S2y1+(N2-1)*r*r*S2y1/S2x1*S2x2+(N2-1)*alpha2*(1-r*r)*S2y1+N1*N2/(N1+N2)*r*r*S2y1/S2x1*(mx2-mx1)^2))/Sx2*(data[i,2]-mx)
      }
    }
  }
  for(i in 1:l)
  {
    result[i]=exp(result[i])
  }
  write.table(result, file="checkresult.txt",row.names= FALSE)

