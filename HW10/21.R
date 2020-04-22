#! /usr/bin/env Rscript

library('zipfR')

# functions
Likelihood <- function(f, n, m, E) {
	a <- f
	b <- f + E - 2*E*f
	
	alpha <- n+1
	beta <- m-n+1

	likelihood <- (Ibeta(b, alpha, beta) - Ibeta(a, alpha, beta)) / (b-a)

	return(likelihood)
}

Posterior <- function(f, likelihood, prior) {
	posterior <- likelihood * prior
	df <- 1/(length(f)-1)
	posterior <- posterior/(sum(posterior * df))
	return(posterior)
}

# Question 18
E <- 0.001
n <- 3
m <- 20
f <- seq(0, 1, length=100)

prior <- dunif(f, 0, 1)
posterior <- Posterior(f, Likelihood(f, n, m, E), prior)

plot(f, posterior, type='l', col='red', ylab='prior, posterior')
lines(f, prior, col='blue')

#print(posterior)

# Question 21
ns <- c(4, 0, 23, 53, 0, 0, 0, 0, 0, 21)
ms <- c(20, 40, 50, 60, 44, 56, 58, 34, 29, 40)

priors <- list()
priors[[1]] <- dunif(f, 0, 1)

priors[[2]] <- rep(0, length(f))
for(location in 1:length(ns)) {
	posterior <- Posterior(f, Likelihood(f, ns[location], ms[location], E), priors[[1]])
	priors[[2]] <- priors[[2]] + posterior/length(ns)
}

plot(f, priors[[2]], type='l', col='orange', ylab='prior')
lines(f, priors[[1]], type='l', col='blue')

print(round(priors[[2]][1], 3))

# Question 26
for(iter in 1:1000) {
	priors[[iter+1]] <- rep(0, length(f))
	for(location in 1:length(ns)) {
		posterior <- Posterior(f, Likelihood(f, ns[location], ms[location], E), priors[[iter]])
		priors[[iter+1]] <- priors[[iter+1]] + posterior/length(ns)
	}
}

lines(f, priors[[500]], type='l', col='green')
lines(f, priors[[1000]], type='l', col='red')

print(round(priors[[500]][1], 3))
print(round(priors[[1000]][1], 3))

# Question 29
probfreq <- function(f, n, m, E, prior, threshold) {
	post <- Posterior(f, Likelihood(f, n, m, E), prior)

	loc = 0
	for (i in 1:length(f)) {
		freq <- f[i]
		if (freq > threshold) {
			loc = i
			break
		}	
	}
	above_thresh <- sum(post[loc:length(post)])
	all <- sum(post[1:length(post)])
	prob <- above_thresh / all 
		
	return(prob)
}
n=53
m=60
threshold=0.81

plot(f, Posterior(f, Likelihood(f, n, m, E), priors[[1000]]))

print(probfreq(f,n,m,E,priors[[1]], threshold))
print(probfreq(f,n,m,E,priors[[1000]],threshold))
