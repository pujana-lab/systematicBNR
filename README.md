[![Build Status](https://travis-ci.org/lpalomerol/inmuneAssociation.svg?branch=master)](https://travis-ci.org/lpalomerol/inmuneAssociation)

# Systematic Linear Regressions tool

This package contains the software tools developed for running the experiments which support the results explained at "Immune Cell Associations with Cancer Risk", paper pending of publication.

## Pipeline

  Before running  each regression three big steps are applied: 
    - First of all we have removed users with empty data values and covariables without variability.
    - Then we have applied *bestNormalize* regression pipeline to output variable
    - Thirt step implies the application of *Stepwise AIC* pipeline to eliminate covariables potentially non informative.
  The main function output (systematic_regression) returns the results as 1-row data.frame object, ideally defined to run inside a loop.
  
  
  
To install it, the easiest is to use the R package devtools and its function install_github. To do so, open an R session and enter

```
install.packages(c("devtools","curl")) ##Installs devtools 
library(devtools)
install_github("pujana-lab/systematicBNR",ref="master")
```