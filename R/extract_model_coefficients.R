
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
