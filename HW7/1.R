library(HMM)

states <- c('M1', 'M2', 'M3', 'M4', 'M5', 'I1', 'I2', 'I3', 'I4')
symbols <- c('A', 'T', 'C', 'G')

t1 <- 0.9
t2 <- 0.1
t3 <- 0.4
t4 <- 0.6
t5 <- 0
t6 <- 0

transitions <- matrix(data=c(0, t1, 0, 0, 0, t2, 0, 0, 0,
			     0, 0, t1, 0, 0, 0, t2, 0, 0,
			     0, 0, 0, t1, 0, 0, 0, t2, 0,
			     0, 0, 0, t5, t1, 0, 0, 0, t2,
			     0, 0, 0, 0, t6, 0, 0, 0, 0,
			     0, t4, 0, 0, 0, t3, 0, 0, 0,
			     0, 0, t4, 0, 0, 0, t3, 0, 0,
			     0, 0, 0, t4, 0, 0, 0, t3, 0,
			     0, 0, 0, 0, t4, 0, 0, 0, t3), 
		      byrow=TRUE, nrow=9, dimnames=list(states, states))

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

startProbs <- c(0.2, 0.2, 0.2, 0.2, 0.2, 0, 0, 0, 0)

hmm = initHMM(states, symbols, startProbs=startProbs, transProbs=transitions,
	      emissionProbs=emissions)

observations <- c('A', 'C', 'T', 'G', 'A')
print(viterbi(hmm, observations))

observations <- c('A', 'G', 'C', 'T', 'G', 'A')
print(viterbi(hmm, observations))

observations <- c('A', 'G', 'C', 'C', 'T', 'G', 'A')
print(viterbi(hmm, observations))

fundamental <- transitions[-5,-5]
fundamental <- solve(diag(length(fundamental[,1])) - fundamental)
print(fundamental)
avg_len <- 0
for (i in 1:(length(fundamental[,1]))) {
	print(i)
	avg_len <- avg_len + sum(fundamental[i,])
}
avg_len <- avg_len / (length(fundamental[,1]))
print(avg_len)

observations<-c("T", "A", "A", "A", "C", "T", "G", "A", "T", "T", "T")

print(viterbi(hmm,observations))