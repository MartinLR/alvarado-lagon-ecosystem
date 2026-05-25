###
# a data preparation
###

# this script takes the files landuse.rds
# and prod_species.rds to prepare the data frame
# for modeling

# 1. Load libraries 
library(tidyverse)
library(janitor)

# 2. Load data
landuse <- readRDS("landuse.rds")
prod    <- readRDS("prod_species.rds")

# 3. Join and transform data
als_df <- 
  prod |> 
  inner_join(landuse) |> 
  ungroup() |>  
  mutate(
    # 1. Raw Logs
    log_natural_raw = log(mangrove + wetland),
    log_agri_raw    = log(livestock + sugarcane),
    
    # 2. Global Centering (Now it will calculate across all years, not within them)
    log_natural     = log_natural_raw - mean(log_natural_raw, na.rm = TRUE),
    log_agri        = log_agri_raw - mean(log_agri_raw, na.rm = TRUE),
    
    # 3. Proper Continuous Year Trend (0 to 11)
    year_trend      = year - min(year),
    
    # 4. 2008 Shock Dummies
    shock_2008 = if_else(year == 2008, 1, 0)
  )

glimpse(als_df)

# save data frame
saveRDS(als_df, "als_df.rds")


