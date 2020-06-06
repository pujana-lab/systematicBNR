#' Cleans a phenotypes dataframe, tlhis is a helper function for systematic analysis.
#'
#' Removes samples with at leas one NA value and phenotypes where all values describe the same values.
#'
#' @param phenotypes data_frame with at least a samples column and some phenotype columns to be included.
#' @param samples_colname string Column with the samples data.
#' @param phenotypes_to_include String list with the list of phenotypes which should be included.
#'
#' @return DataFrame Rownames are the sample ids (of sample_colnames) and content
#'    contains the included phenotypes.
#'
#' @export
preprocess_phenotypes <- function(phenotypes, samples_colname, phenotypes_to_include){
  samples = phenotypes[,samples_colname]
  pheno_clean = phenotypes[,unique(phenotypes_to_include)]
  rownames(pheno_clean) = samples

  pheno_clean = pheno_clean[stats::complete.cases(pheno_clean),]

  pheno_variabilitiy = apply(pheno_clean, 2, function(column){
    length(unique(column))
  })
  pheno_clean = pheno_clean[,pheno_variabilitiy > 1, drop = FALSE]
  return(pheno_clean)
}
