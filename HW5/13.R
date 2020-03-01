growpaths <- function(paths) {
	for(n in 1:length(paths)) {
		path <- paths[[n]]
		lastS = path$S[length(path$S)]
		lastI = path$I[length(path$I)]
		if(lastS>0 && lastI>0) {
			paths[[n]] <- rbind(path, data.frame(S=lastS, I=0))
			for(i in 1:lastS) {
				paths[[length(paths)+1]] <- rbind(path, data.frame(S=lastS-i, I=i))
				paths <- growpaths(paths)
			}
		}
	}
	return(paths)
}

paths <- list()
paths[[length(paths) + 1]] <- data.frame(S=c(3), I=c(1))
paths <- growpaths(paths)

duration5 <- max(which(paths[[5]]$I != 0))


p <- 0.2
for(n in 1:length(paths)) {
	paths[[n]]$P[1] <- 1
	for (i in 1:(length(paths[[n]]$S) - 1)) {
		paths[[n]]$P[i+1] <- dbinom(paths[[n]]$S[i]-paths[[n]]$S[i+1], paths[[n]]$S[i], 1-(1-p)^paths[[n]]$I[i])
	}
}

print(paths)

duration <- 0
for(n in 1: length(paths)) {
	path <- paths [[n]]
	pathDuration <- max(which(path$I != 0))
	pathProbability <- prod(path$P)
	duration <- duration + pathDuration * pathProbability
}

print(duration)

secondary <- 0
for (n in 1: length(paths)) {
	path <- paths[[n]]
	pathInfections <- sum(path$I) - 1
	pathProbability <- prod(path$P)
	secondary <- secondary + pathInfections * pathProbability
}

print(secondary)