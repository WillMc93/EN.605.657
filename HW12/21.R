#!/usr/bin/env Rscript

pz <- 1/2
ps <- c('Z'=1/2, '~Z'=1/2)
pm <- c('Z'=1/2, '~Z'=1/2)

s <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE)
m <- c(TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE)
z <- c(TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE)

step <- function(pz, ps, pm) {
	for (iter in 1:1000) {
		weight <- c(1, 1, 1, 1, ps['Z'], 1-ps['Z'], pm['~Z'], 1-pm['~Z'], pz, 1-pz, 1)
		pz <- sum(z*weight)/sum(weight)
		ps['Z'] <- sum(z*s*weight)/sum(weight*z)
		ps['~Z'] <- sum((!z)*s*weight)/sum(weight*(!z))
		pm['Z'] <- sum(z*m*weight)/sum(weight*z)
		pm['~Z'] <- sum((!z)*m*weight)/sum(weight*(!z))
	}
	return(c('pz'=pz, 'ps'=ps, 'pm'=pm))
}

#print(c(pz, pm, ps))
#print(step(pz, ps, pm))

pz <- 1/3
pm <- c('Z'=1/3, '~Z'=1/3)
ps <- c('Z'=1/3, '~Z'=1/3)
print(c(pz, pm, ps))
final <- step(pz, ps, pm)

pz <- final['pz']
pm <- c(final['pm.Z'], final['pm.~Z'])
names(pm) <- c('Z', '~Z')
#print(pm)

ps <- c(final['ps.Z'], final['ps.~Z'])
names(ps) <- c('Z', '~Z')
#print(ps)

psmz <- ps['Z']*pm['Z']*pz / (ps['Z']*pm['Z']*pz + ps['~Z']*pm['~Z']*(1-pz))

slowhuman <- ps['~Z']*(1-pm['~Z'])*(1-pz) 
slowhuman <- (ps['~Z']*(1-pm['~Z'])*(1-pz) + ps['Z']*(1-pm['Z'])*pz)
print(slowhuman)

print(c(ps['~Z'], 1-pm['~Z'], 1-pz, ps['Z'], 1-pm['Z'], pz))
