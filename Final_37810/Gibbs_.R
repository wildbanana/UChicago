Gibbs_<-function(x0,y0,iterations,B,burnIn=0)
{
  if(x0>0&&x0<B&&y0>0&&y0<B)
  {
    x<-c(x0,rep(NA,iterations-1))
    y<-c(y0,rep(NA,iterations-1))
    for(i in 1:(iterations-1))
    {
      x[i+1]<-(-log(1-runif(1)*(1-exp(-y[i]*B)))/y[i])
      y[i+1]<-(-log(1-runif(1)*(1-exp(-x[i+1]*B)))/x[i+1])
    }
    x<-x[-(1:burnIn)]
    y<-y[-(1:burnIn)]
    return(data.frame(x,y))
  }
 else
   stop("Initial values incorrect")
}