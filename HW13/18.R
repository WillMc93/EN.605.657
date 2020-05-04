#!/usr/bin/env Rscript

isoform <- c("ATTGGCCCTGGCAA", "ATTGGCTTACTGTTGAA")

l <- c(12, 15)

read <- c('TTG', 'TGG', 'CTG', 'TAC', 'GGC')

w <- c(1, 1, 0.9)

getPrz <- function(n, i, j, isoform, l, read, w) {
	if (j >= nchar(isoform[i]) - 1) {
		return(0)
	}
	else {
		readLetters <- unlist(strsplit(read[n], ''))
		isoformLocLet <- substr(isoform[i], j, j + length(w) - 1)
		isoformLocLet <- unlist(strsplit(isoformLocLet, ''))

		return(prod((readLetters == isoformLocLet)*(w) + (readLetters != isoformLocLet)*(1-w)/3))
	}
}

prz <- array(dim=c(length(read), length(isoform), max(l)))
for (n in 1:length(read)) {
	for (i in 1:length(isoform)) {
		for (j in 1:max(l)) {
			prz[n,i,j] = getPrz(n, i, j, isoform, l, read, w)
		}
	}
}

print(prz[2, 1, 3])

theta <- c(0.5, 0.5)

pzr <- array(dim=c(length(read), length(isoform), max(l)))

for (n in 1:length(read)) {
	for (j in 1:max(l)) {
		pzr[n,,j] <- prz[n,,j] * theta[]/l[]
	}
	denominator <- sum(pzr[n,,])
	pzr[n,,] <- pzr[n,,] / denominator
}

print(round(pzr[2,2,3], 3))
print(round(sum(pzr[2,,])))

for (iter in 1:100) {
	pzr <- array(dim=c(length(read), length(isoform), max(l)))

	for (n in 1:length(read)) {
		for (j in 1:max(l)) {
			pzr[n,,j] <- prz[n,,j] * theta[]/l[]
		}
		denominator <- sum(pzr[n,,])
		pzr[n,,] <- pzr[n,,] / denominator
	}
	for (i in 1:length(isoform))
		theta[i] = sum(pzr[,i,])/length(read)
}

print(round(theta[2], 3))
print(theta)