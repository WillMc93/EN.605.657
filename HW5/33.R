a <- 0.1 # alpha
b <- 0.2 # beta
g <- 0.3 # gamma
d <- 0.4 # delta

# diagonal expressions
e1 <- -a - 2*g
e2 <- -b - 2*g
e3 <- -b - 2*d
e4 <- -a - 2*d

print(c(e1, e2, e3, e4))

nucleotides <- c('A', 'G', 'C', 'T')

transitionMatrix <- matrix(data=c(e1, a, g, g, b, e2, g, g, d, d, e3, b, d, d, a, e4), byrow=TRUE, nrow=4, dimnames=list(nucleotides, nucleotides))

print(eigen(transitionMatrix))

eigen(transitionMatrix)$vectors[,4]/sum(eigen(transitionMatrix)$vectors[,4])


