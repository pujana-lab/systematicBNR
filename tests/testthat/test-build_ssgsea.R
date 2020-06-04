library(testthat)

context("build_ssgsea")

build_fake_expr_matrix <- function(ngenes, nsamples){
  fake_expr_matrix = matrix(rnorm(ngenes * nsamples, mean = 10, sd = 4), ncol = nsamples)
  colnames(fake_expr_matrix) = sprintf('sample_%d', 1:ncol(fake_expr_matrix))
  rownames(fake_expr_matrix) = sprintf('gene_%d',   1:nrow(fake_expr_matrix))
  return(fake_expr_matrix)
}

test_that("Should perform ssGSEA pipeline over a user-genes matrix and gene list", {

  #Arrange
  fake_rnaseq = build_fake_expr_matrix(2000, 10)
  fake_rnaseq = rbind(
    fake_rnaseq,
    'top_gene1' = c(rnorm(10, 15, 1)),
    'top_gene2' = c(rnorm(10, 15, 1)),
    'top_gene3' = c(rnorm(10, 15, 1)),
    'top_gene4' = c(rnorm(10, 15, 1)),
    'top_gene5' = c(rnorm(10, 15, 1)),
    'top_gene6' = c(rnorm(10, 15, 1))
  )


  fake_signatures = list(
    signature_a = sample(rownames(fake_rnaseq), 10),
    signature_b = sample(rownames(fake_rnaseq), 15),
    signature_c = sample(rownames(fake_rnaseq), 20),
    top_signature = sprintf('top_gene%d', 1:6)
  )

  #Act
  ssgseas = build_ssgsea(fake_rnaseq, fake_signatures, verbose = FALSE, parallel.sz = 1)
  #Assert
  expect_equal(nrow(ssgseas), length(fake_signatures))
  expect_equal(ncol(ssgseas), ncol(fake_rnaseq))
  expect_true(mean(ssgseas['top_signature',]) > mean(ssgseas['signature_a',]))
  expect_true(mean(ssgseas['top_signature',]) > mean(ssgseas['signature_b',]))
  expect_true(mean(ssgseas['top_signature',]) > mean(ssgseas['signature_c',]))
})


