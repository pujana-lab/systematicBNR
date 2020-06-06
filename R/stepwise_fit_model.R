#' Fit best model linear regression model using AIC as criterion.
#'
#' Two models are returned, a base model which includes all values at phenotypes dataframe, and
#' a stepwise fitted model using Akaike Information Criterion.
#'
#' @param y Array of values
#' @param phenotypes Data frame with phenotype-related covariables
#' @param ... List of other parameters related with MASS::stepAIC function
#' @return List with base and fitted linear regression models.
#'
#' @examples
#' \dontrun{
#'   stepwise_fit_model(
#'     y = rnorm(100, 1, 10),
#'     data.frame(covar = rnorm(100,  1, 1), covar2 = rnorm(100, 1, 1) )
#'   )
#'
#'
#'   stepwise_fit_model(
#'     y = rnorm(100, 1, 10),
#'     data.frame(covar = rnorm(100,  1, 1), covar2 = rnorm(100, 1, 1) ),
#'     scope = list(
#'       lower = ~ covar,
#'       upper = ~ .
#'     )
#'   )
#'
#' }
#' @export
stepwise_fit_model <- function(y, phenotypes, ...){

    base_model = stats::lm(y ~ ., data = phenotypes)

    fit_stepwise = MASS::stepAIC(base_model, ...)
    prediction = stats::predict(base_model, type = 'response')
    raw_prediction = stats::predict(
      attr(y, 'bestNormalize'),
      prediction,
      inverse = TRUE
    )

    attr(fit_stepwise, 'prediction') = prediction
    attr(fit_stepwise, 'untransformed_prediction') = raw_prediction

    return(
      list(
        base = base_model,
        fit_stepwise = fit_stepwise
      )
    )

}
