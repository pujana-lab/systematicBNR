context("preprocess_effect_variable")
test_that("Should normalize data applying bestNormalize method", {

  #Arrange
  set.seed(12345)
  input_values = rnorm(2000, 0, 1)
  #Act
  normalized_data = preprocess_effect_variable(input_values, standardize = FALSE, remove_outliers = TRUE)
  data_attr = attributes(normalized_data)
  best_norm = attr(normalized_data, 'bestNormalize')
  #Assert
  applied_transformation = attr(best_norm$chosen_transform, 'class')[[1]]

  expect_equal(as.numeric(normalized_data)[1:10], input_values[1:10])
  expect_equal(sum(is.na(normalized_data)),  16)

  expect_equal(applied_transformation, 'no_transform')
})




