suppressMessages(library('markovchain'))

states <- seq(from=1, to=5)
symbols <- c('all', 'you', 'need', 'is', 'love')

transitions <- matrix(data=c(2/11, 9/11, 0, 0, 0,
	0, 0, 1, 0, 0,
	0, 0, 0, 1, 0,
	0.5, 0, 0, 0, 0.5,
	3/12, 0, 0, 2/12, 7/12),
	byrow=TRUE, nrow=5, dimnames=list(states, states))

emissions <- matrix(data=c(8/11, 0, 0, 0, 3/11,
	0, 8/9, 0, 0, 1/9,
	0, 0, 8/9, 0, 1/9,
	0, 0, 0, 8/10, 2/10,
	0, 0, 0, 0, 1),
	byrow=TRUE, nrow=5, dimnames=list(states, symbols))

chain <- new('markovchain', transitionMatrix=transitions)

Pi <- steadyStates(chain)
r_Pi <- Pi # rounded pi

for (i in 1:length(Pi)) {
	r_Pi[1,i] <- round(Pi[1,i], 5)
}

joint_prob <- function(path, Pi)  {
	lyric <- c('love', 'love', 'is', 'all')

	prob <- unname(Pi[1, path[1]])
	
	for (i in 1:length(path)) {
		prob <- prob * emissions[path[i], lyric[i]]
	
		if (i != length(path)) {
			prob <- prob * transitions[path[i], path[i+1]]
		}
	
	}

	return(prob)
}

path10 <- c(5,5,4,1)
path11 <- c(2,3,4,1)
path12 <- c(1,2,3,4)
pathx <- c(4,5,4,1)

print(joint_prob(path10, Pi))
print(joint_prob(path11, Pi))
print(joint_prob(path12, Pi))
print(joint_prob(pathx, Pi))


grid <- expand.grid(1:5, 1:5, 1:5, 1:5)
total_prob = 0
for (i in 1:length(grid[,1])) {
	path <- c(grid[i,1], grid[i,2], grid[i,3], grid[i,4])

	total_prob <- total_prob + joint_prob(path, Pi)
}

print(total_prob)

