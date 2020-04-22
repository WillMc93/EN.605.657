#!/usr/bin/env Rscript

x <- seq(0, 1, length = 100)
prior <- dbeta(x, 4, 4)
posterior <- dbeta(x, 8, 6)

plot(x, posterior, type='l', col='red', ylab='prior, posterior')
lines(x, prior, col='blue')
