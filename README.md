# Analysis of the Alvarado Lagoon System (ALS)

This repository contains the data pipeline and statistical analysis evaluating the impact of land use changes on fishery productivity within the Alvarado Lagoon System. 

## 📋 Table of Contents
* [Project Overview](#project-overview)
* [Structure & Workflow](#structure--workflow)
* [Prerequisites](#prerequisites)
* [Results](#results)

---

## 🔬 Project Overview
The objective of this analysis is to model how different land use patterns affect regional fishery productivity over time. Using linear mixed-effects models, we account for both fixed environmental/agricultural predictors and random time-series or group-level variations.

## 🛠 Structure & Workflow

The analysis is structured to run sequentially:

1. **`a_data_preparation.R`** Processes the raw `.rds` data files, handles data cleaning/interpolation, and constructs the unified dataset required for modeling.
   
2. **`b_prodvslanduse.R`** Loads the prepared dataframe and estimates the effects of land use on fishery productivity. The statistical framework utilizes random effects models via the `lmerTest` package.

## 📦 Prerequisites

To run these scripts, you will need **R** installed along with the following packages:
```R
install.packages(c("lmerTest", "tidyverse"))
