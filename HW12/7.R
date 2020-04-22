#!/usr/bin/env Rscript

library('Hmisc')

pz <- 1/2
meanz <- 1
sdz <- 1

meanp <- 3
sdp <- 1

speed <- c(0.05, 0.06, 0.41, 0.83, 0.85, 1.22, 1.82, 2.15, 2.41, 2.76, 1.12, 
	   0.25, 0.52, 0.97, 0.90, 1.73, 1.87, 1.82, 2.49, 3.20)

mstep <- function(pz, meanz, sdz, meanp, sdp) {
	#print(c(meanz, sdz, meanp, sdp))
	for(iter in 1:1000) {
		weightz <- dnorm(speed, mean=meanz, sd=sdz)*pz /
			(dnorm(speed, mean=meanp, sd=sdp)*(1-pz) +
				dnorm(speed, mean=meanz, sd=sdz)*pz)
		
		meanz <- wtd.mean(speed, weightz)
		sdz <- sqrt(wtd.var(speed, weightz, normwt=TRUE))
		
		meanp <- wtd.mean(speed, 1-weightz)
		sdp <- sqrt(wtd.var(speed, 1-weightz, normwt=TRUE))

		pz <- sum(weightz) / length(speed)
		#if (iter %% 10 == 0) {
		#	print(c(meanz, sdz, meanp, sdp))
		#}	
	}
	return(pz)
}

print(mstep(1/2, 1, 1, 3, 1))
print(mstep(1/5, 2, 2, 3, 1))
print(mstep(1/5, 2, 2, 2, 1))
print(mstep(1/5, 2, 1, 2, 1))

