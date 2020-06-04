#' Preprocess effect variable
#' Applies bestNormalize package (optionally) removes outliers (defined by 1.5 IQR)
#'
#' @param values Array with values
#' @param remove_outliers Flag to detect potential outliers and "remove" them setting as NA.
#' @param ... Extra parameters for bestNormalize function
#'
#' @return out Array with clean data
preprocess_effect_variable <- function(values, remove_outliers = FALSE, ...){
  normalized_data  = bestNormalize::bestNormalize(values, ...)
  out = normalized_data$x.t
  attr(out, 'bestNormalize') = normalized_data

  if(remove_outliers){
    out = remove_outliers(out)
  }

  return(out)
}
