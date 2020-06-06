context("Preprocess_covar_table")

test_that("Where all phenotypes have variability and without nulls, returns all pheno selected variables for all samples ", {
  #Arrange

  phenotypes = data.frame(
    sample = sprintf('user_%s', 1:5),
    gender = c('male', 'male', rep('female', 3)),
    age = seq(50, 54, 1),
    stringsAsFactors = FALSE
  )

  #Act
  clean_pheno = preprocess_phenotypes(
    phenotypes,
    'sample', c('age', 'gender')
  )

  #Assert
  expect_equal(nrow(clean_pheno), 5)
  expect_equal(colnames(clean_pheno), c('age', 'gender'))

})

test_that("With phenotypes without variability, this column should be removed ", {
  #Arrange

  phenotypes = data.frame(
    sample = sprintf('user_%s', 1:5),
    gender = c(rep('female', 5)),
    age = seq(50, 54, 1),
    stringsAsFactors = FALSE
  )

  #Act
  clean_pheno = preprocess_phenotypes(
    phenotypes,
    'sample', c('age', 'gender')
  )

  #Assert
  expect_equal(nrow(clean_pheno), 5)
  expect_equal(colnames(clean_pheno), c('age'))

})


test_that("With samples with at least one null, they should be removed, and should be performed before removing variability ", {
  #Arrange

  phenotypes = data.frame(
    sample = sprintf('user_%s', 1:5),
    gender = c('male', rep('female', 4)),
    age = c(NA, seq(51, 54, 1)),
    stringsAsFactors = FALSE
  )

  #Act
  clean_pheno = preprocess_phenotypes(
    phenotypes,
    'sample', c('age', 'gender')
  )

  #Assert
  expect_equal(rownames(clean_pheno), phenotypes$sample[-1])
  expect_equal(nrow(clean_pheno), 4)
  expect_equal(colnames(clean_pheno), c('age'))

})

