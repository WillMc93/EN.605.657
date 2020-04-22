#!/usr/bin/env Rscript

x <- seq(0, 1, length = 100)
prior <- 140*x^3*(1-x)^3
posterior <- 10296*x^7*(1-x)^5

plot(x, posterior, type='l', col='red', ylab='prior, posterior')
lines(x, prior, col='blue')
