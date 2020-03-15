#!/usr/bin/env Rscript

library(HMM)

states1 <- c('M1', 'M2', 'M3', 'M4', 'M5', 'I1', 'I2', 'I3', 'I4', 'T', 'N', 'C')
states2 <- c('m1', 'm2', 'm3', 'm4', 'm5', 'i1', 'i2', 'i3', 'i4')
states <- c(states1, states2)

symbols <- c('A', 'T', 'C', 'G', 'end')

t1 <- 0.9
t2 <- 0.1
t3 <- 0.4
t4 <- 0.6
NM1 <- 0.1
Nm1 <- 0.1
NN <- 1 - (NM1 + Nm1)
CC <- 0.8
CT <- 1 - CC

buildTrans <- function(M2M3, m2m3, M2m3, m2M3) {

	transitionLTop <- matrix(data=c(0, t1, 0, 0, 0, t2, 0, 0, 0, 0, 0, 0,
					   0, 0, M2M3, 0, 0, 0, t2, 0, 0, 0, 0, 0,
					   0, 0, 0, t1, 0, 0, 0, t2, 0, 0 ,0, 0,
					   0, 0, 0, 0, t1, 0, 0, 0, t2, 0, 0, 0,
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
					   0, t4, 0, 0, 0, t3, 0, 0, 0, 0, 0, 0,
					   0, 0, t4, 0, 0, 0, t3, 0, 0, 0, 0, 0,
					   0, 0, 0, t4, 0, 0, 0, t3, 0, 0, 0, 0,
					   0, 0, 0, 0, t4, 0, 0, 0, t3, 0, 0, 0,
					   0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
					   NM1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NN, 0, 
					   0, 0, 0, 0, 0, 0, 0, 0, 0, CT, 0, CC), 
				    byrow=TRUE, nrow=12, dimnames=list(states1, states1))

	transitionRBot <- transitionLTop[1:9, 1:9]
	row.names(transitionRBot) <- paste(states2)
	colnames(transitionRBot) <- paste(states2)
	transitionRBot['m2', 'm3'] <- 1 - M2m3 - transitionRBot['m2', 'i2']

	transitionRTop <- matrix(0, length(states1), length(states2), dimnames=list(states1, states2))
	transitionRTop['M2', 'm3'] <- M2m3
	transitionRTop['N', 'm1'] <- Nm1

	transitionLBot <- matrix(0, length(states2), length(states1), dimnames=list(states2, states1))
	transitionLBot['m2', 'M3'] <- m2M3
	transitionLBot['m5', 'C'] <- 1

	transition <- rbind(cbind(transitionLTop, transitionRTop), cbind(transitionLBot, transitionRBot))

	return(transition)
}

e1 <- 0.25
emission1 <- matrix(data=c(0.7, 0.1, 0.1, 0.1, 0.0,
			   0.1, 0.1, 0.7, 0.1, 0.0,
			   0.1, 0.8, 0.1, 0.0, 0.0,
			   0.1, 0.1, 0.1, 0.7, 0.0,
			   0.8, 0.0, 0.0, 0.2, 0.0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0,
			   0.0, 0.0, 0.0, 0.0, 1.0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0),
		    byrow=TRUE, nrow=length(states1), dimnames=list(states1, symbols))

emission2 <- matrix(data=c(0.4, 0.2, 0.2, 0.2, 0.0,
			   0.2, 0.2, 0.4, 0.2, 0.0,
			   0.1, 0.8, 0.1, 0.0, 0.0,
			   0.1, 0.0, 0.0, 0.9, 0.0,
			   0.9, 0.0, 0.0, 0.1, 0.0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0,
			   e1, e1, e1, e1, 0),
		    byrow=TRUE, nrow=length(states2), dimnames=list(states2, symbols))

emission <- rbind(emission1, emission2)

sp <- 1/12
startProbs <- c(sp)
for (i in 2:length(states)) {
	if ((i >= 2 && i <= 5) || (i >= 11 && i <= 17)) {
		startProbs <- c(startProbs, sp)
	}
	if ((i >= 6 && i <= 10) || (i >= 18 && i <= 21)) {
		startProbs <- c(startProbs, 0)
	}
}


# default 
transitionDefault <- buildTrans(0.8, 0.8, 0.1, 0.1)
hmm <- initHMM(states, symbols, startProbs=startProbs, transProbs=transitionDefault, emissionProbs=emission)

observation <- unlist(strsplit("GTTTACTGAACACACCC", split=''))

defaultMatch <- viterbi(hmm, observation)

for (i in seq(from=0.75, to=0.1, by=-0.01)) {
	j <- 1 - i - 0.1
	transition <- buildTrans(i, i, j, j)

	hmm <- initHMM(states, symbols, startProbs=startProbs, transProbs=transition, emissionProbs=emission)

	thisMatch <- viterbi(hmm, observation)

	if (isFALSE(all(thisMatch==defaultMatch))) {
		print(c(i, j, thisMatch))
		break
	}
}
