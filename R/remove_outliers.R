#' Detects which values lies beyond the extremes of the whiskers of a box plot and marks them
#' 
#' @param values Array  A numeric array to mark outliers
#' 
#' @return A numeric array with outliers value as NA
#' 
#' @export


remove_outliers <- function(values){

  outlierVals = grDevices::boxplot.stats(as.numeric(values))$out

  mayOutlier = as.numeric(values %in% outlierVals)
  outliers = which(mayOutlier > 0)

  if(length(outliers) > 0){
    warning(
      sprintf(
        '%d outliers detected and removed: [%s]',
        length(outliers),
        paste(outliers, collapse = ',')
      )
    )
    values[outliers] <- NA
  }
  return(values)
}
