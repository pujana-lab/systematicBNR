#' Systematic regression function which performs the complete pipeline and returns the results flattened into a data frame row
#'
#' @param dataset  DataFrame This dataframe contains the whole data, combining sample ids, phenotypes and independent variables
#' @param effect_variable      String The dependent variable label
#' @param main_covariable      String The main covariable label, this is the studied one, other covaraibles can be considered or not at the regression.
#' @param sample_variable      String The name of the column where the sample names are defined.
#' @param phenotype_variables  Array|"ALL" The list of covariables that cuould be included. Columns not defined in this array will be excluded from the study.
#'
#' @return DataFrame           One row dataframe with all the phentoype values
#'
#' @export
systematic_regression <- function(dataset,  effect_variable, main_covariable, sample_variable = 'sample', phenotype_variables = 'ALL' ){

  if(length(phenotype_variables) == 1 & paste(phenotype_variables, collapse = ',') == 'ALL'){
    phenotype_variables = colnames(dataset)[!(colnames(dataset) %in%  c(sample_variable, effect_variable))]
  }

  pheno_clean = preprocess_phenotypes(dataset, sample_variable, c(phenotype_variables, effect_variable, main_covariable))
  y_norm = preprocess_effect_variable(pheno_clean[,effect_variable], allow_orderNorm = FALSE)
  pheno_clean = pheno_clean[,colnames(pheno_clean) != effect_variable]

  models = inmuneAssociation::stepwise_fit_model(y_norm, pheno_clean, scope = list(
    lower = stats::as.formula(sprintf('~ %s', main_covariable)),
    upper = ~ .
  ), trace = 0)

  aic_model = models$fit_stepwise
  coefficients = extract_model_coefficients(aic_model, main_covariable)

  out = data.frame(
      signature = effect_variable,
      covariates = paste(names(aic_model$coefficients)[-1], collapse = ','),
      n = length(aic_model$model),
      stringsAsFactors = FALSE

  )
  out = cbind(out, coefficients, transformation = attr(y_norm, 'chosenTransformation'))

  return(out)
}


