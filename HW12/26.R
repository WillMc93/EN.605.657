#!/usr/bin/env Rscript

pz <- 1/2
ps <- c('Z'=1/2, '~Z'=1/2)
pm <- c('Z'=1/2, '~Z'=1/2)

s <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE)
m <- c(TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE)
z <- c(TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE)

step <- function(pz, ps, pm, max_iter=1000) {
	for (iter in 1:max_iter) {
		weight <- c(1, 1, 1, 1, ps['Z'], 1-ps['Z'], pm['~Z'], 1-pm['~Z'], pz, 1-pz, 1)
		pz <- sum(z*weight)/sum(weight)
		ps['Z'] <- sum(z*s*weight)/sum(weight*z)
		ps['~Z'] <- sum((!z)*s*weight)/sum(weight*(!z))
		pm['Z'] <- sum(z*m*weight)/sum(weight*z)
		pm['~Z'] <- sum((!z)*m*weight)/sum(weight*(!z))
	}
	final <- c(pz, ps, pm)
	names(final) <- c('pz', 'ps.Z', 'ps.~Z', 'pm.Z', 'pm.~Z')
	final
}
final <- step(pz, ps, pm, max_iter=1)

pm1 <- c(final['pm.Z'], final['pm.~Z'])

KL <- function(valA, valB) {
	return(valA * log(valA / valB) + (1-valA)*log((1-valA) / (1- valB)))
}

#KL10 = pm1*log(pm1/pm) + (1-pm1)*log((1-pm1)/(1-pm))
#KL01 = pm*log(pm/pm1) + (1-pm)*log((1-pm)/(1-pm1))

KL10 <- KL(pm1, pm)
KL01 <- KL(pm, pm1)
print(KL10)
print(KL01)

final2 <- step(pz, ps, pm, max_iter=2)
final3 <- step(pz, ps, pm, max_iter=3)

pm2 <- c(final2['pm.Z'], final2['pm.~Z'])
pm3 <- c(final3['pm.Z'], final3['pm.~Z'])

KL21 <- KL(pm2, pm1)
KL32 <- KL(pm3, pm2)

print(KL21)
print(KL32)