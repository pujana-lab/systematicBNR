#' Perform ssGSEA pipeline for related signatures in defined genome.
#'
#' Encapsulates ssGSEA pipeline at GSVA package
#'
#' @param genome Genome expression object in matrix format, with samples in columns and genes in rows.
#' @param signatures Signatures list object
#' @param ... GSVA ssgsea extra parameters
build_ssgsea <- function(genome, signatures, ... ){
  ssGSEA = GSVA::gsva(genome, signatures, method = 'ssgsea', kcdf = 'Gaussian', ...)
  return(ssGSEA)
}

