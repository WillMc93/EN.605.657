a <- 0.02
b <- 0.01

nucleotides <- c('A', 'G', 'C', 'T')

exp <- 1 - a - 2*b

transitionMatrix <- matrix(data=c(exp, a, b, b, a, exp, b, b, b, b, exp, a , b, b, a, exp), byrow=TRUE, nrow=4, dimnames=list(nucleotides, nucleotides))

transitionMatrix6 <- transitionMatrix
for (i in 2:6) {
	transitionMatrix6 <- transitionMatrix6 %*% transitionMatrix
}
print(transitionMatrix6)
