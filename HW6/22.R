library(HMM)

states <- c('AT-rich', 'GC-rich')
alphabet <-c('A', 'T', 'C', 'G')

emissions <- matrix(c(0.45, 0.45, 0.05, 0.05, 0.05, 0.05, 0.45, 0.45),
		    byrow=TRUE, nrow=2)

hmm <- initHMM(states, alphabet, emissionProbs = emissions)

seq <- "ATTATTAATACGGGCCAATTAGGGCCCAGGCCCTGCGTCCCCCCCCTTATTTTTCGTA"

data <- unlist(strsplit(seq, ''))

result <- baumWelch(hmm, data)
print(result)

num23 <- round(result$hmm$transProbs['AT-rich', 'GC-rich'], 3)
num24 <- sum(result$hmm$emissionProbs['GC-rich', 1:2])
num24 <- round(num24, 3)

print(num23)
print(num24)

viterbi <- viterbi(hmm, data)

ATiso <- 0
GCiso <- 0
previous <- viterbi[1]
for (i in 2:length(viterbi)) {
	basic_cond <- i == length(viterbi) || previous != viterbi[i]

	ATcond <- basic_cond && previous == states[1]
	GCcond <- basic_cond && previous == states[2]

	if (ATcond) {
		ATiso <- ATiso + 1
		previous <- viterbi[i]
	}
	if (GCcond) {
		GCiso <- GCiso + 1
		previous <- viterbi[i]
	}
}

print(paste(c('AT isochores:', ATiso), collapse=' '))
print(paste(c('GC isochores:', GCiso), collapse=' '))

max_GC <- 0
count <- 0
for (i in 1:length(viterbi)) {
	if (viterbi[i] == states[2]) {
		count <- count + 1
	}
	if (viterbi[i] == states[1]) {
		if (count > max_GC) {
			max_GC <- count
		}

		count <- 0
	}
}

print(max_GC)
