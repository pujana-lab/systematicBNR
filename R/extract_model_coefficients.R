#' extract_model_coefficients
#' 
#' This function extracts the coefficients of the main covariable and returns them along the p value of the model into a data frame
#' 
#' @param model Model  Fitted model
#' @param main_covariable String  The main covariable label, this is the studied one, other covaraibles can be considered or not at the regression
#' 
#' @return DataFrame  The coefficients of the main covariable with the p value and adjusted R squared of the fitted model 
#' 
#' @export 

extract_model_coefficients <- function(model, main_covariable){

  fitSummary = summary(model)
  modelPval = 1-stats::pf(
    fitSummary$fstatistic[['value']],
    fitSummary$fstatistic[['numdf']],
    fitSummary$fstatistic[['dendf']]
  )

  coefficients = summary(model)$coefficients[main_covariable,]
  names(coefficients)  = c(
    'regression.Estimate',
    'regression.err',
    'regression.t.value',
    'regression.pval'
  )
  coefficients = as.data.frame(t(coefficients))

  coefficients[,'regression.pval.signif'] = gtools::stars.pval(coefficients[,'regression.pval'])

  coefficients[,'regression.model.adj.rsquare'] = fitSummary$adj.r.squared
  coefficients[,'regression.model.fstatP'] = modelPval
  coefficients[,'regression.model.fstatP.signif'] = gtools::stars.pval(modelPval)

  return(coefficients)

}
