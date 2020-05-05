#!/usr/bin/env Rscript

library(bnlearn)
library(Rgraphviz)

setwd('~/Desktop/EN.605.657/HW14/')

mushroomData <- read.table('data/agaricus-lepiota.data', sep=',')

names(mushroomData) <- c('edible', 'cap_shape', 'cap_surface', 'cap_colour',
						 'bruises', 'odor', 'gill_attachment', 'gill_spacing',
						 'gill_size', 'gill_colour', 'stalk_shape', 'stalk_root',
						 'stalk_surface_above_ring', 'stalk_surface_below_ring', 
						 'stalk_colour_above_ring', 'stalk_colour_below_ring',
						 'veil_type', 'veil_colour', 'ring_number', 'ring_type', 
						 'spore_print_colour', 'population', 'habitat')

mushroomData <- mushroomData[colnames(mushroomData) != 'veil_type']

head(mushroomData, n=10)

mushroomData1 <- mushroomData[1:7]

structure <- hc(mushroomData1)

