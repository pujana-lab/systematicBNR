context("systematic_regression")

test_that("Should run complete regression and return summarised rows", {

  #Arrange
  set.seed(12345)
  n = 42
  phenotypes = data.frame(
    sample = sprintf('user_%s', 1:n),
    signature =  rnorm(n, 10, 4),
    gender = c('male', rep('female', n-1)),
    age = floor(c(NA, runif(n-1, 35, 70))),
    stringsAsFactors = FALSE
  )
  phenotypes = phenotypes[order(phenotypes$signature),]
  phenotypes$stage = c(rep('stage_1', n/3),  rep('stage_2', n/3), rep('stage_3', n/3))
  phenotypes$prs = phenotypes$signature + rnorm(n, 2, 4)

  #Act
  out = systematic_regression(
    phenotypes,
    effect_variable = 'signature',
    main_covariable = 'prs',
    sample_variable = 'sample',
    phenotype_variables = 'ALL'
  )

  #Assert
  expect_equal(nrow(out), 1)
  expect_equal(out$signature, 'signature')
  expect_lt(out$regression.pval, 0.05)
  expect_lt(out$regression.model.fstatP, 0.001)

})
