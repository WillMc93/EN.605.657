library(HMM)

states <- c('M1', 'M2', 'M3', 'M4', 'M5', 'I1', 'I2', 'I3', 'I4')
symbols <- c('A', 'T', 'C', 'G')


ei <- 0.25
emissions <- matrix(data=c(0.7, 0.1, 0.1, 0.1,
			   0.1, 0.1, 0.7, 0.1,
			   0.1, 0.8, 0.1, 0.0,
			   0.1, 0.1, 0.1, 0.7,
			   0.8, 0.0, 0.0, 0.2,
			   ei, ei, ei, ei,
			   ei, ei, ei, ei,
			   ei, ei, ei, ei,
			   ei, ei, ei, ei),
		    byrow=TRUE, nrow=9, dimnames=list(states, symbols))


# 10+ from here
states <- c(states, 'T', 'N', 'C')
symbols <- c(symbols, 'end')

sp <- 1/7
startProbs <- c(sp, sp, sp, sp, sp, 0, 0, 0, 0, 0, sp, sp)


t1 <- 0.9
t2 <- 0.1
t3 <- 0.4
t4 <- 0.6
t5 <- 0
t6 <- 0
nn <- 0.4
cc <- 0.4

transitions <- matrix(data=c(0, t1, 0, 0, 0, t2, 0, 0, 0, 0, 0, 0,
			     0, 0, t1, 0, 0, 0, t2, 0, 0, 0, 0, 0,
			     0, 0, 0, t1, 0, 0, 0, t2, 0, 0, 0, 0,
			     0, 0, 0, t5, t1, 0, 0, 0, t2, 0, 0, 0,
			     0, 0, 0, 0, t6, 0, 0, 0, 0, 0, 0, 1,
			     0, t4, 0, 0, 0, t3, 0, 0, 0, 0, 0, 0,
			     0, 0, t4, 0, 0, 0, t3, 0, 0, 0, 0, 0,
			     0, 0, 0, t4, 0, 0, 0, t3, 0, 0, 0, 0,
			     0, 0, 0, 0, t4, 0, 0, 0, t3,  0, 0, 0,
			     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			     (1-nn), 0, 0, 0, 0, 0, 0, 0, 0, 0, nn, 0,
			     0, 0, 0, 0, 0, 0, 0, 0, 0, (1-cc), 0, cc),
		      byrow=TRUE, nrow=12, dimnames=list(states, states))

fundamental <- transitions[-10, -10]
fundamental <- solve(diag(length(fundamental[1,])) - fundamental)
print(fundamental)

print(sum(fundamental[10,]))
