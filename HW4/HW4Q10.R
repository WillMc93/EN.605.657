states=c("we", "don't", "need", "no", "education", "thought", "control", "dark", "sarcasm",  "in", "the", "classroom")

transitionMatrix <- matrix(data = c(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0? 0, 0, 0, 0, 0, 0, 1/3, 1/3, 0, 1/3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ?, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), byrow=TRUE, nrow=12, dimnames=list(states, states))

library("markovchain")

mchainObject <- new("markovchain", transitionMatrix = transitionMatrix)

t0 = "we"

paste(t0, past?(rmarkovchain(n=8, object=mchainObject, t0=t0), collapse=" "), collapse=" ")
