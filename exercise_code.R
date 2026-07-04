
# EXERCISE: Forest Estimates

###############################################################################

###################
# LOAD INPUT DATA # 
###################
rm(list=ls()) # Clear the environment

# Add here the path where the input data is located in your own computer. Examples:
data <- read.table("C:/Users/demo1/exercise_data.txt", sep="\t", header=T)
#data <- read.table("F:/FIaM2021/Ex.1/exercise1_2021_data.txt", sep="\t", header=T)

##########################
# RANDOM SAMPLING WITHOUT REPLACEMENT
##########################
N <- length(data$Stand) # population size
n <- 10 # sample size

sample <- data[sample(N,n),]
#names(sample)

s1.mean <- mean(sample$Volume)
s1.variance <- var(sample$Volume) # This is needed to calculate the standard error of the mean
s1.std.error <- sqrt((s1.variance/n)*((N-n)/N)) # for sampling without replacement

# Conficence intervals (95%):
s1.lwrCI <- s1.mean - 1.96*s1.std.error
s1.uprCI <- s1.mean + 1.96*s1.std.error

# Alternativelly, compute the quantile (abcissa) of a standard normal distribution (mean=0; std=1)
# should be computed for alpha/2, as it is two-tailed analysis.
# s1.lwrCI <- s1.mean - qnorm(1-0.05/2,0,1)*s1.std.error
# s1.uprCI <- s1.mean + qnorm(1-0.05/2,0,1)*s1.std.error

print("RANDOM SAMPLING WITHOUT REPLACEMENT:") 
# Sample mean
s1.mean
# Sample standard deviation
sqrt(s1.variance) # or sd(sample$Volume)
# Standard error of the mean in the sample:
s1.std.error
# Lower 95% confidence limit:
s1.lwrCI
# "Upper 95% confidence limit:
s1.uprCI

print("Observed mean and standard deviation of the volume in the whole data:")
# Mean volume
mean(data$Volume)
# Standard deviation
sd(data$Volume) # Compare also the standard deviation

##########################
# SYSTEMATIC SAMPLING 
##########################
# sort the data in order of increasing volume (according to the old management plan)
data.v <- data[order(data$Volume_stand_register),] 
#head(data.v) # stands are sorted with respect to volume_stand_register

# without replacement, taking samples of 10 out of 50 makes 5 groups:
syst <- N/n
# therefore, for systematic sampling, we pick every 5th sample
start.s <- sample(syst,1) # the starting point is chosen at random
i = start.s;
syst.sample <- c()	# create the object where to add the sample units
while (i <= N){	
	row <- data.v[i,]	# pick the row i
	syst.sample  <- rbind(syst.sample, row) # add it to the sample
	i=i+syst	# go for the next 5th row
}
#syst.sample

s2.mean <- mean(syst.sample$Volume)
s2.variance <- var(syst.sample$Volume)
s2.std.error <- sqrt((s2.variance/n)*((N-n)/N)) # for sampling without replacement

# Conficence intervals (95%):
s2.lwrCI <- s2.mean - 1.96*s2.std.error
s2.uprCI <- s2.mean + 1.96*s2.std.error

print("SYSTEMATIC SAMPLING:") 
# Sample mean
s2.mean
# Sample standard deviation
sqrt(s2.variance)
# Standard error of the mean in the sample:
s2.std.error
# Lower 95% confidence limit:
s2.lwrCI
# "Upper 95% confidence limit:
s2.uprCI

##########################
# STRATIFIED SAMPLING 
##########################
# the tasks of Simple Random Sampling are repeated, but in this case separatelly for each stratum
# final estimates are weighted sums of separate estimates for each strata 

# separate into two strata by development class
stratum2 <- data[data$Stand_development_class==2,] 
stratum4 <- data[data$Stand_development_class==4,]

# stratum size
N2 <- length(stratum2$Stand) 
N4 <- length(stratum4$Stand)
# proportions of each stratum over the total
prop2 <- N2/N 
prop4 <- N4/N
# sample size for each stratum
n2 <- round(prop2*n) 
n4 <- round(prop4*n)
# random sampling without replacement within each stratum
sample2 <- stratum2[sample(N2,n2),] 
sample4 <- stratum4[sample(N4,n4),]

# means of each strata and their weighted sums
s3.mean2 <- mean(sample2$Volume) 
s3.mean4 <- mean(sample4$Volume)
s3.mean <- s3.mean2*prop2 + s3.mean4*prop4

# variances of each strata, and all stratas combined 
s3.variance2 <- var(sample2$Volume)
s3.variance4 <- var(sample4$Volume)
s3.variance <- s3.variance2 + s3.variance4     # No weighing here because all stratas are observed and sampling was done independently within each of them

# choose either way to calculate the standard error of the mean
s3.std.error <- sqrt((1/N^2)*((((N2^2*s3.variance2)/n2)*((N2-n2)/N2))+(((N4^2*s3.variance4)/n4)*((N4-n4)/N4))))
#s3.std.error <- sqrt(((prop2^2*(s3.variance2/n2))+(prop4^2*(s3.variance4/n4)))-(prop2*(s3.variance2/N)+prop4*(s3.variance4/N)))

# Conficence intervals (95%):
s3.lwrCI <- s3.mean - 1.96*s3.std.error
s3.uprCI <- s3.mean + 1.96*s3.std.error

print("STRATIFIED SAMPLING:") 
# Sample mean
s3.mean
# Sample standard deviation
sqrt(s3.variance)
# Standard error of the mean in the sample
s3.std.error
# Lower 95% confidence limit
s3.lwrCI
# "Upper 95% confidence limit
s3.uprCI

# NOTE: The results of different sampling methods will (most likely) change 
# every time you re-run the script because the samples are chosen randomly!

# End of the R-script