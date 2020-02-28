library('markovchain')

states = c('aa', 'Aa', 'AA')

tMatrix <- matrix(data=c(0.4, 0.4, 0.2, 0.25, 0.5, 0.25, 0.2, 0.4, 0.4),
	byrow=TRUE, nrow=3, dimnames=list(states, states))

markov <- new('markovchain', transitionMatrix=tMatrix)

steadyState <- steadyStates(markov)

print(steadyState)