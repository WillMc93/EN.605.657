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

structhc1 <- hc(mushroomData1)
structgs1 <- gs(mushroomData1)
structa1 <- aracne(mushroomData1)

structhc2 <- hc(mushroomData2)
structgs2 <- gs(mushroomData2)
structa2 <- aracne(mushroomData2)

graphviz.plot(structhc1)
graphviz.plot(structhc2)

graphviz.plot(structgs1)
graphviz.plot(structgs2)

graphviz.plot(structa1)
graphviz.plot(structa2)
