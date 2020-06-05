context("stepwise_fit_model")

build_random_phenotype <- function(n){
  phenotypes = data.frame(
    age = runif(n, 45, 70),
    gender = sample(c('male', 'female'), n, replace = TRUE)
  )
  return(phenotypes)
}

test_that("Should return a list with two models: base and akaike fitted one when called", {

  #Arrange
  set.seed(12345)

  y = preprocess_effect_variable(rnorm(100, 0, 1))
  phenotypes = build_random_phenotype(100)

  #Act
  models = stepwise_fit_model(y, phenotypes, trace = FALSE)


  #Assert
  expect_equal(length(models), 2)
  expect_equal(class(models$base), 'lm')
  expect_equal(class(models$fit_stepwise), 'lm')
  #As 'pheno' variables are not correlated, should not include them in model
  expect_equal(names(models$fit_stepwise$coefficients), '(Intercept)')

})

test_that("When lower-upper models provided, should uses them as parameter", {

  #Arrange
  set.seed(12345)
  y = preprocess_effect_variable(rnorm(100, 0, 1))
  phenotypes = build_random_phenotype(100)

  #Act
  models = stepwise_fit_model(
    y, phenotypes, trace = TRUE,
    scope = list(
      lower = ~ age, upper = ~ .
    )
  )

  #Assert
  stepwise_model_attr = attributes(models$fit_stepwise)

  expect_equal(length(models), 2)
  expect_equal(class(models$base), 'lm')
  expect_equal(class(models$fit_stepwise), 'lm')
  expect_equal(names(models$fit_stepwise$coefficients), c( '(Intercept)', 'age'))
  expect_equal(length(stepwise_model_attr$prediction), length(y))
  expect_equal(length(stepwise_model_attr$untransformed_prediction), length(y))

  expect_equal(
    cor(
      stepwise_model_attr$untransformed_prediction,
      stepwise_model_attr$prediction
    ),
    1
  )
})
