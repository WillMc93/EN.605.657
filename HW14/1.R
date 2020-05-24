#!/usr/bin/env Rscript

library(bnlearn)
library(Rgraphviz)

base_d <- '~/Desktop/EN.605.657/HW14/'
graph_d <- '~/Desktop/EN.605.657/HW14/graphs'

setwd(base_d)

mushroomData <- read.table('data/agaricus-lepiota.data', sep=',')

names(mushroomData) <- c('edible', 'cap_shape', 'cap_surface', 'cap_colour',
						 'bruises', 'odor', 'gill_attachment', 'gill_spacing',
						 'gill_size', 'gill_colour', 'stalk_shape', 'stalk_root',
						 'stalk_surface_above_ring', 'stalk_surface_below_ring', 
						 'stalk_colour_above_ring', 'stalk_colour_below_ring',
						 'veil_type', 'veil_colour', 'ring_number', 'ring_type', 
						 'spore_print_colour', 'population', 'habitat')

mushroomData <- mushroomData[colnames(mushroomData) != 'veil_type']

gen_graphs <- function(data, offset='', wd=graph_d) {
	curr_d <- getwd()
	setwd(wd)

	graphs <- list(hc(data), gs(data), aracne(data))

	for (i in 1:length(graphs))
		graph <- graphs[[i]]

		graphviz.plot(graph)

	setwd(curr_d)
}


mushroomData1 <- mushroomData[1:7]
mushroomData2 <- mushroomData[1:8]

#gen_graphs(mushroomData1)
#gen_graphs(mushroomData2, offset='1')


# Question 7
structure <- hc(mushroomData2)
parameters <- bn.fit(structure, mushroomData2)

print(parameters)
print(bn.fit(structure, mushroomData2))

# Question 11
structure <- hc(mushroomData1)
score <- bnlearn::score(structure, mushroomData1)
#print(score)

# Question 12
edgeReversedStructure <- reverse.arc(structure, 'edible', 'odor')
score <- bnlearn::score(edgeReversedStructure, mushroomData1)
#print(score)

# Question 13
edgeReversedStructure <- reverse.arc(edgeReversedStructure, 'bruises', 'gill_attachment')
score <- bnlearn::score(edgeReversedStructure, mushroomData1)
#print(score)
