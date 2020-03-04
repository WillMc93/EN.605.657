library('markovchain')

states = seq(from=1, to=5)

transitions <- matrix(data=c(2/11, 9/11, 0, 0, 0,
0, 0, 1, 0, 0,
0, 0, 0, 1, 0,
0.5, 0, 0, 0, 0.5,
3/12, 0, 0, 2/12, 7/12), byrow=TRUE, nrow=5, dimnames=list(states, states))

chain <- new('markovchain', transitionMatrix=transitions)

pi <- steadyStates(chain)

for (i in 1:length(pi)) {
	pi[1,i] <- round(pi[1,i], 5)
}
print(pi)