n <- 30

x <- seq(0, n)

y <- dbinom(x, n, 0.1)

plot(x,y , col='blue', xlab="Number of Heads", ylab="Probability", pch=16)
