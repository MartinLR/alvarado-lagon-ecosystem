###
# EDA
###

#load libraries
#load libraries
library(tidyverse)
library(ggeasy)

#load data
landuse <- readRDS("landuse.rds")
prod <- readRDS("prod_species.rds")

#join data
als <-
  prod |> 
  inner_join(landuse)

#plot pro vd land use
theme_set(theme_classic())

#mangrove
als |> 
  ggplot(aes(log(mangrove), log(prod_val), col = nombre_principal)) + 
  geom_point() +
  easy_legend_at("bottom")

#wetland
als |> 
  ggplot(aes(log(wetland), log(prod_val), col = nombre_principal)) + 
  geom_point() +
  easy_move_legend("bottom")

# livestok
als |> 
  ggplot(aes(log(livestock), log(prod_val), col = nombre_principal)) + 
  geom_point() +
  easy_move_legend("bottom")

# sugarcane
als |> 
  ggplot(aes(log(sugarcane), log(prod_val), col = nombre_principal)) + 
  geom_point() +
  easy_move_legend("bottom")

#regression models
