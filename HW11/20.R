#!/usr/bin/env Rscript

library(plot3D)

M <- mesh(seq(0, 1, length=100), seq(0, 1, length=100))
f <- M$x^2*M$y*(1 - M$y)^2*(1 - M$x - M$y + M$x*M$y)*(M$x + M$y - M$x*M$y)^3

persp3D(M$x, M$y, f)

M <- mesh(seq(0, 1, length=1000), seq(0, 1, length=1000))
f <- M$x^2*M$y*(1 - M$y)^2*(1 - M$x - M$y + M$x*M$y)*(M$x + M$y - M$x*M$y)^3

the_max <- which(f==max(f), arr.ind=TRUE)
print(the_max)

xy <- c(the_max[1, 1], the_max[1, 2])
temp <- seq(0, 1, length=1000)
xy <- c(temp[xy[1]],temp[xy[2]])

check <- function(x, y) {
	f <- x^2*y*(1 - y)^2*(1 - x - y + x*y)*(x + y - x*y)^3
	return(f)
}
print(check(xy[1], xy[2])== max(f))
