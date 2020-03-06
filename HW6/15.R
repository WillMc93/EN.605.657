library('markovchain')
library('HMM')

states <- seq(from=1, to=5)
symbols <- c('all', 'you', 'need', 'is', 'love')

transitions <- matrix(data=c(2/11, 9/11, 0, 0, 0,
	0, 0, 1, 0, 0,
	0, 0, 0, 1, 0,
	0.5, 0, 0, 0, 0.5,
	3/12, 0, 0, 2/12, 7/12),
	byrow=TRUE, nrow=5, dimnames=list(states, states))

emissions <- matrix(data=c(8/11, 0, 0, 0, 3/11,
	0, 8/9, 0, 0, 1/9,
	0, 0, 8/9, 0, 1/9,
	0, 0, 0, 8/10, 2/10,
	0, 0, 0, 0, 1),
	byrow=TRUE, nrow=5, dimnames=list(states, symbols))

chain <- new('markovchain', transitionMatrix=transitions)
Pi <- steadyStates(chain)

observations <- c('love', 'love', 'is', 'all')

hmm = initHMM(states, symbols, startProbs=Pi, transProbs=transitions, emissionProbs=emissions)

logForwardProbabilities <- forward(hmm, observations)
print(exp(logForwardProbabilities))

viterbi <- viterbi(hmm, observations)
print(viterbi)