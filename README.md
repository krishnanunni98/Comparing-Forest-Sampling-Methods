# Comparing Forest Sampling Methods

## Project Overview

This exercise compares simple random sampling, systematic sampling, and stratified sampling for estimating mean stand volume from a 50-stand forest inventory dataset. The goal is to assess how sampling design affects precision, standard error, and confidence intervals. 

## Objectives

- Estimate mean stand volume using simple random sampling.
- Estimate mean stand volume using systematic sampling.
- Estimate mean stand volume using stratified sampling.
- Compare estimates with the full dataset mean.
- Assess precision using standard errors and 95% confidence intervals. 

## Data

- 50 stands
- Stand volume (m³/ha)
- Prior stand-register volume
- Stand development class (2 = young, 4 = mature) 

## Methodology

### Simple Random Sampling
- Drew 10 stands without replacement.
- Calculated sample mean, variance, standard error, and 95% confidence interval. 

### Systematic Sampling
- Sorted stands by prior stand-register volume.
- Selected a random starting point among the first five stands.
- Chose every fifth stand afterward. 

### Stratified Sampling
- Stratified the data by stand development class.
- Allocated the sample proportionally across the two strata.
- Calculated the combined stratified mean and standard error. 

## Main Results

- Full-data mean volume: **212.9014 m³/ha**
- Simple random sample mean: **187.171 m³/ha**
- Systematic sample mean: **191.446 m³/ha**
- Stratified sample mean: **250.216 m³/ha** :contentReference[oaicite:16]{index=16}

## Skills Demonstrated

- Sampling design
- Inventory estimation
- Confidence interval interpretation
- Statistical computation in R
- Basic forest inventory methodology 

