context("Remove outliers")

test_that("should remove outliers when identified", {

  #Arrange
  values = c(runif(100, 1, 2), 1000, 1000)

  #Act
  clean_outliers = suppressWarnings(
    remove_outliers(values)
  )

  #Assert
  expect_equal(sum(is.na(clean_outliers)), 2)
})
