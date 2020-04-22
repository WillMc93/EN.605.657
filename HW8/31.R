#! /usr/bin/env Rscript

expect <- function(alpha, beta, seq) {

	x <- seq(0, 1, length=100)

	prior <- dbeta(x, alpha, beta)
	
	for (i in strsplit(seq, '')[[1]]) {
		if (i == 'G' || i == 'C') {
			alpha = alpha + 1
		}
		if (i == 'A' || i == 'T') {
			beta = beta + 1
		}
	}

	posterior <- dbeta(x, alpha, beta)
	print(alpha, beta)
	expected <- integrate(dbeta, 0, 1, shape1=alpha, shape2=beta)

	return(expected)
}
print(expect(4, 4, "ATCGCG"))
