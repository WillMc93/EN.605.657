#!/usr/bin/env Rscript

library("markovchain")

states = c('MS', 'MTR')
transitionMatrix <- matrix(data=c(0.156, 0.844, 0.5, 0.5), byrow=TRUE, nrow=2, dimnames=list(states, states))

mchainObject <- new('markovchain', transitionMatrix=transitionMatrix)
ss <- steadyStates(mchainObject)
print(ss)
