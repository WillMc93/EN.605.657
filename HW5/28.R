a <- 0.4 # alpha
b <- 0.3 # beta
d <- -a-2*b # diagonal

nucleotides <- c('A', 'G', 'C', 'T')

transitionMatrix <- matrix(data=c(d, a, b, b, a, d, b, b, b, b, d, a, b, b, a, d), byrow=TRUE, nrow=4, dimnames=list(nucleotides, nucleotides))

eigen(transitionMatrix)$vectors[,1]/sum(eigen(transitionMatrix)$vectors[,1])


