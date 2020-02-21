states=c("we", "don’t", "need", "no", "education", "thought", "control", "dark", "sarcasm",  "in", "the", "classroom") 

transitionMatrix<-matrix(data=c(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 1/3, 1/3, 0, 1/3, 0, 0, 0, 0,
1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), byrow=TRUE,  nrow=12, dimnames=list(states, states))

library("markovchain")

mchainObject <- new("markovchain", transitionMatrix = transitionMatrix)

t0 = "we"
paste(t0, paste(rmarkovchain(n=8, object=mchainObject, t0=t0), collapse=" "), collapse=" ")


transitionMatrix[12, 1] <- 1
transitionMatrix[12, 12] <- 0
mchainObject <- new("markovchain", transitionMatrix = transitionMatrix)

is.irreducible(mchainObject)

transitionMatrix[12, 1] <- 0
transitionMatrix[12, 4] <- 1
mchainObject <- new("markovchain", transitionMatrix = transitionMatrix)

is.irreducible(mchainObject)

transitionMatrix[12, 1] <- 1
transitionMatrix[12, 4] <- 0
mchainObject <- new("markovchain", transitionMatrix = transitionMatrix)

transitionMatrix2 <- transitionMatrix %*% transitionMatrix

transitionMatrix100 <- transitionMatrix
for (i in 2:100) {
	transitionMatrix100 <- transitionMatrix100 %*% transitionMatrix
}
print(round(transitionMatrix100['need', 'thought'], 6))
print(round(transitionMatrix100['we', 'thought'], 6))





