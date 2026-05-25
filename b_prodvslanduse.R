###
# random effects model
###

#this scrip uses the als_df.rds data frame(
#to model a random effects model 
#the mentioned model explains fishery production
#in terms of land use

# 1. load libraries
library(tidyverse)
library(lme4)
library(lmerTest) 
library(broom.mixed)
library(janitor)
library(boot)

# 2. load data
als_df <- readRDS("als_df.rds")
glimpse(als_df)

# 3. EDA
#natural land
als_df |> 
  ggplot(aes(log_natural_raw, log(prod),
             col = nombre_principal)) +
  geom_point()

# agriculture land
als_df |> 
  ggplot(aes(log_natural_raw, log(prod),
             col = nombre_principal)) +
  geom_point()

# prod over time
als_df |> 
  ggplot(aes(year, prod, col = nombre_principal)) + 
  geom_line()

###  models
# Baseline naive model
m1 <- lm(log(prod) ~ log_natural_raw + log_agri_raw,
         data = als_df)

summary(m1)

# re model with species and year: singularity issue
m2 <- lmerTest::lmer(
  log(prod) ~ log_natural_raw + log_agri_raw +
    (1 | nombre_principal) + (1 | year), 
  data = als_df
)

# # re model centered with species and year: singularity issue
m3 <- lmerTest::lmer(
  log(prod) ~ log_natural + log_agri + 
    (1 | nombre_principal) + (1 | year), 
  data = als_df
)

summary(m3)

# re witout time effect: no singularity
m4 <- lmerTest::lmer(
  log(prod) ~ log_natural + log_agri +
    (1 | nombre_principal), 
  data = als_df
)

# Uniform Macro-Shock (1 parameter for 2008)
m5 <- lmer(
  log(prod) ~ log_natural + log_agri + shock_2008 + 
    (1 | nombre_principal), 
  data = als_df
)

# The Asymmetric Macro-Shock (Nested interaction, 5 parameters)
m6 <- lmer(
  log(prod) ~ log_natural + log_agri + shock_2008:nombre_principal + 
    (1 | nombre_principal), 
  data = als_df
)

summary(m6)

# evaluación
AIC(m1,m2, m3, m4, m5, m6)
BIC(m1,m2, m3, m4, m5, m6)

