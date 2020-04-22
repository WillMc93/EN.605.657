
speeds <- c(0.05, 0.06, 0.41)

weight <- function(speed, zom=FALSE) {
	prob_zom  <- 0.5

	mean_zom <- 1
	mean_per <- 3

	sd_zom <- 1
	sd_per <- 1

	dnom <- dnorm(speed, mean_zom, sd_zom)*prob_zom + dnorm(speed, mean_per, sd_per)*(1 - prob_zom)

	nom <- 0
	if (zom) {
		nom <- dnorm(speed, mean_zom, sd_zom)*(prob_zom)
	}
	else {
		nom <- dnorm(speed, mean_per, sd_per)*(1-prob_zom)
	}

	return(nom/dnom)
}

for(i in 1:length(speeds)) {
	print(weight(speeds[i], TRUE))
	print(weight(speeds[i], FALSE))
}
