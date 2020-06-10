[![Build Status](https://travis-ci.org/lpalomerol/inmuneAssociation.svg?branch=master)](https://travis-ci.org/lpalomerol/inmuneAssociation)

# Identification of immune/stromal cell quantitative trait loci linked to cancer risk

This package contains the pipeline and tools developed for the study entitled "Immune Cell Associations with Cancer Risk". This pipeline was developed and is maintained by Luis Palomero and Roderic Espin (MA Pujana’s lab, Catalan Institute of Oncology, IDIBELL).

The pipeline includes the R package ConsensusTME (Jiménez-Sánchez et al., 2019; https://github.com/cansysbio/ConsensusTME), ssGSEA in Gene Set Variation Analysis (GSVA) (Hänzelmann et al., 2013; 10.18129/B9.bioc.GSVA), R/qtl2 (Broman et al., 2019; https://github.com/rqtl/qtl2), and bestNormalize (https://github.com/petersonR/bestNormalize).

## Installation

To install it use the R package devtools and its function install_github. Open an R session and enter the following commands:

```
install.packages(c("devtools","curl")) ##Installs devtools 
library(devtools)
install_github("pujana-lab/systematicBNR",ref="master")
```

## Pipeline

Before running the regression analysis, three steps should be completed: 1) delete cases with empty data and covariables without variability; 2) apply *bestNormalize* regression to output variable; 3) apply *Stepwise AIC* pipeline to delete covariables non-informative. The main function output (systematic_regression) returns the results as 1-row data.frame object, ideally defined to run in a loop.
 
