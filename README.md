# systematicBNR

**Identification of immune/stromal cell quantitative trait loci linked to cancer risk**

This package contains the pipeline and tools developed for the study:

**Palomero L, Galván-Femenía I, de Cid R, Espín R, Barnes DR, CIMBA, et al. Antoniou AC, Lázaro C, Pujana MA. Immune Cell Associations with Cancer Risk.** *iScience*. 2020;23(7):101296. [DOI: 10.1016/j.isci.2020.101296](https://doi.org/10.1016/j.isci.2020.101296) · [PMID: 32622267](https://pubmed.ncbi.nlm.nih.gov/32622267)

This pipeline was developed and is maintained by Luis Palomero and Roderic Espín (MA Pujana's lab, Catalan Institute of Oncology, IDIBELL).

> **Note:** the published paper's Methods section cites [systematicQTL](https://github.com/pujana-lab/systematicQTL) as the code repository for the QTL analysis pipeline. `systematicBNR` provides [add: what BNR covers specifically — e.g., the regression/normalization component] used alongside it. See `systematicQTL` for the complementary pipeline.

## Dependencies

The pipeline includes:
- **ConsensusTME** (Jiménez-Sánchez et al., 2019) — [github.com/cansysbio/ConsensusTME](https://github.com/cansysbio/ConsensusTME)
- **GSVA** (single-sample GSEA; Hänzelmann et al., 2013) — `10.18129/B9.bioc.GSVA`
- **R/qtl2** (Broman et al., 2019) — [github.com/rqtl/qtl2](https://github.com/rqtl/qtl2)
- **bestNormalize** — [github.com/petersonR/bestNormalize](https://github.com/petersonR/bestNormalize)

## Installation

```r
install.packages(c("devtools", "curl"))
library(devtools)
install_github("pujana-lab/systematicBNR", ref = "master")
```

## Pipeline

Before running the regression analysis, three steps should be completed:

1. Delete cases with empty data and covariates without variability
2. Apply `bestNormalize` regression to the output variable
3. Apply a Stepwise AIC pipeline to remove non-informative covariates

The main function output (`systematic_regression`) returns results as a 1-row `data.frame` object, ideally called in a loop across variables.

## Citation

If you use this code, please cite the publication above.

## Authors

Luis Palomero and Roderic Espín
