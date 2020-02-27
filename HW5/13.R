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

duration <- max(which(paths[[5]]$I != 0))
print(duration)