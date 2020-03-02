a <- 0.4 # alpha
b <- 0.3 # beta
g <- 0.2 # gamma
d <- -a-b-g # diagonal

nucleotides <- c('A', 'G', 'C', 'T')

transitionMatrix <- matrix(data=c(d, a, b, g, a, d, g, b, b, g, d, a, g, b, a, d), byrow=TRUE, nrow=4, dimnames=list(nucleotides, nucleotides))

print(eigen(transitionMatrix))

eigen(transitionMatrix)$vectors[,1]/sum(eigen(transitionMatrix)$vectors[,1])


