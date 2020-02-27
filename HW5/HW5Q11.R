p <- 0.01
N <- 4

states <- seq(from=0, to=N)

fromState <- matrix(rep(states, each=N+1), byrow=TRUE, nrow=N+1)
toState <- matrix(rep(states, times=N+1), byrow=TRUE, nrow=N+1)

transitionMatrix <- dbinom(fromState-toState, fromState, 1*(1-p)^(N-fromState))

print(fromState - toState)

rownames(transitionMatrix) <- states
colnames(transitionMatrix) <- states
print(transitionMatrix)