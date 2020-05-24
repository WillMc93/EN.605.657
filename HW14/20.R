#! /usr/bin/env Rscript

library('HMM')

observations <- 'AABDCABECDDDDDDDDDDDEBABBDEEACBDAAEDDDDDDDDDABDEACCDDDDDACEEBDECACEDDDDDDBDCAEAEDCBDEADECBDDDDDDDDDDDDCCCBEDA'
output <- unlist(strsplit(observations, ''))

states <- c(1, 2, 3)
symbols <- unique(output)
set.seed(13)

mul = 0.9
set_thing <- function(p, multiplyer=mul) {
	return (mul * (1-p))
}

p12 <- runif(1)
p23 <- runif(1)
p31 <- runif(1)

p11 <- runif(1, min=set_thing(p12, 1-mul), max=set_thing(p12))
p13 <- 1 - p12 - p11

p22 <- runif(1, min=set_thing(p23, 1-mul), max=set_thing(p23))
p21 <- 1 - p23 - p22

p33 <- runif(1, min=set_thing(p31, 1-mul), max=set_thing(p31))
p32 <- 1 - p31 - p33

print(p12 + p11 + p13 == 1)
print(p21 + p22 + p23 == 1)
print(p31 + p32 + p33 == 1)

transProbs <- matrix(c(p11, p12, p13, p21, p22, p23, p31, p32, p33), byrow=TRUE, nrow=3)
print(transProbs)

hmm <- initHMM(states, symbols, transProbs=transProbs)
result <- baumWelch(hmm, output, maxIterations=200)
print(result$hmm)
