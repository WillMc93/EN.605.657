library(HMM)

states <- c('M1', 'M2', 'M3', 'M4', 'M5', 'I1', 'I2', 'I3', 'I4')
symbols <- c('A', 'T', 'C', 'G')

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
#print(fundamental)

print(sum(fundamental[1:5,], fundamental[10:11,])/7)

ei <- 0.25
emissions <- matrix(data=c(0.7, 0.1, 0.1, 0.1, 0.0,
			   0.1, 0.1, 0.7, 0.1, 0.0,
			   0.1, 0.8, 0.1, 0.0, 0.0,
			   0.1, 0.1, 0.1, 0.7, 0.0,
			   0.8, 0.0, 0.0, 0.2, 0.0,
			   ei, ei, ei, ei, 0.0,
			   ei, ei, ei, ei, 0.0,
			   ei, ei, ei, ei, 0.0,
			   ei, ei, ei, ei, 0.0,
			   0.0, 0.0, 0.0, 0.0, 1.0,
			   ei, ei, ei, ei, 0.0,
			   ei, ei, ei, ei, 0.0),
		    byrow=TRUE, nrow=12, dimnames=list(states, symbols))

t1 <- 0.9
t2 <- 0.1
t3 <- 0.4
t4 <- 0.6
t5 <- 0
t6 <- 0
nn <- 0.8
cc <- 0.8

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

hmm <- initHMM(states, symbols, startProbs=startProbs, transProbs=transitions, emissionProbs=emissions)

q21 <- c('T', 'A', 'A', 'A', 'C', 'T', 'G', 'A', 'T', 'T', 'T')
q21 <- viterbi(hmm, q21)
#print(q21)

q22 <- "AAACTAGATGCTATGGCATT"
q22 <- unlist(strsplit(q22, ''))
q22 <- viterbi(hmm, q22)
print(q22)
