trueA <- 5 #setting up parameters for the linear model ax+b+N=y, here is to assign value to a
trueB <- 0 #assign value to b
trueSd <- 10 #assign value to the standard deviation of the error for the linear model
sampleSize <- 31 #assign a sample size

# create independent x-values 
x <- (-(sampleSize-1)/2):((sampleSize-1)/2) #create x with symmetric around zero
# create dependent values according to ax + b + N(0,sd)
#generate y according to the parameters we defined and the range of x we selected, N is from a normal distribuiton N(0,sd)
y <- trueA * x + trueB + rnorm(n=sampleSize,mean=0,sd=trueSd) 


plot(x,y, main="Test Data") #do a scatter plot of x and y

#write a function that calculate the likelihood of us observing the data, given the parameters of the linear model
likelihood <- function(param){ #make a function called likelihood with input vector 'param'
  a = param[1] #a=the first number in vector param
  b = param[2] #b=the second number in vector param
  sd = param[3] #sd=the third number in vector param
  
  pred = a*x + b #calculate the predicted value of y using the given parameters a and b
  #making the probability density function (in logarithm) of the deviation between true y and predicted y.
  singlelikelihoods = dnorm(y, mean = pred, sd = sd, log = T) 
  sumll = sum(singlelikelihoods) #sum up the values to obtain the overall likelihood (equals the logarithm of their product)
  return(sumll) #return the overall likelihood
}

# Example: plot the likelihood profile of the slope a
#make function 'slopevalue' which given a slope x, return the overall likelihood 
slopevalues <- function(x){return(likelihood(c(x, trueB, trueSd)))}
slopelikelihoods <- lapply(seq(3, 7, by=.05), slopevalues ) #give x a range of values to put in the function 'slopevalue'
#plot x vs the overall likelihood calculated
plot (seq(3, 7, by=.05), slopelikelihoods , type="l", xlab = "values of slope parameter a", ylab = "Log likelihood")

# Prior distribution
prior <- function(param){ #make a function called prior to specify the prior distribution for the parameters
  a = param[1] #a will be the first number in vector 'param'
  b = param[2] #b will be the second number in vector 'param'
  sd = param[3] #c will be the third number in vector 'param'
  aprior = dunif(a, min=0, max=10, log = T) #specify the prior distribution of a to be a uniform distribution from 0-10
  bprior = dnorm(b, sd = 5, log = T) #specify the prior distribution of b to be a normal distribution with b as mean, sd=5
  sdprior = dunif(sd, min=0, max=30, log = T) #specify the prior distribution of sd to be a uniform distribution from 0-30
  return(aprior+bprior+sdprior) #return the sum of their probabilities in logarithms
}

posterior <- function(param){ #make a function called posterior that will take in the a vector consisting all parameters 
  return (likelihood(param) + prior(param)) #posterior distribution equals to the product of likelihood and prior
  #since both distributions are in logarithms, simple take the sum to get posterior
}


######## Metropolis algorithm ################

proposalfunction <- function(param){ #set up a proposal function that will take in a vector that contains its parameter
  return(rnorm(3,mean = param, sd= c(0.1,0.5,0.3))) #return 3 observations of random deviates with specified mean and sd
}

run_metropolis_MCMC <- function(startvalue, iterations){ #set up the function that takes two parameters, startvalue and iterations
  chain = array(dim = c(iterations+1,3)) #create a matrix chain that has iterations+1 rows and 3 columns
  chain[1,] = startvalue #set the first row of chain equals to startvalue
  for (i in 1:iterations){ #for each i from 1 to number of iterations
    proposal = proposalfunction(chain[i,]) #proposal equals the result of the proposalfunction with the first row of chain as input
    
    probab = exp(posterior(proposal) - posterior(chain[i,])) #calculate the acceptance probability
    if (runif(1) < probab){ #if the acceptance probability is larger than the probability r generated from the uniform distribution
      chain[i+1,] = proposal #jump the value from the previous one to the new proposed value
    }else{
      chain[i+1,] = chain[i,] #otherwise, stay at the old value
    }
  }
  return(chain) #after completing the iterations, return chain
}

startvalue = c(4,0,10) #specified the starting values
chain = run_metropolis_MCMC(startvalue, 10000) #calculate chain value using the function with the startvalue and 10K iterations

burnIn = 5000 #set burnIn to 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),])) #calculate the acceptance rate after discarding the biased results


### Summary: #######################

par(mfrow = c(2,3)) #setting the plots to be displayed in two rows and 3 columns
hist(chain[-(1:burnIn),1],nclass=30, , main="Posterior of a", xlab="True value = red line" ) #histogram of posterior a
abline(v = mean(chain[-(1:burnIn),1])) #add a line of the mean value of posterior a
abline(v = trueA, col="red" ) #add a red line of the value of true A
hist(chain[-(1:burnIn),2],nclass=30, main="Posterior of b", xlab="True value = red line") #histogram of posterior b
abline(v = mean(chain[-(1:burnIn),2])) #add a line at mean of posterior b
abline(v = trueB, col="red" ) #add a red line of the value of true B
hist(chain[-(1:burnIn),3],nclass=30, main="Posterior of sd", xlab="True value = red line") #histogram of posterior sd
abline(v = mean(chain[-(1:burnIn),3]) ) #add a line of the mean of posterior sd
abline(v = trueSd, col="red" ) #add a red line of the value of true Sd

#plot to show how posterior a value jumped throughout iterations
plot(chain[-(1:burnIn),1], type = "l", xlab="True value = red line" , main = "Chain values of a", ) 
abline(h = trueA, col="red" ) #add a red line of the value of trueA
#plot to show how posterior b value jumped throughout iterations
plot(chain[-(1:burnIn),2], type = "l", xlab="True value = red line" , main = "Chain values of b", )
abline(h = trueB, col="red" ) #add a red line of the value of trueB
#plot to show how posterior sd value jumped throughout iterations
plot(chain[-(1:burnIn),3], type = "l", xlab="True value = red line" , main = "Chain values of sd", )
abline(h = trueSd, col="red" ) #add a red line of the value of trueSd

# for comparison:
summary(lm(y~x)) #a summary of the linear regression with x regressed onto y.