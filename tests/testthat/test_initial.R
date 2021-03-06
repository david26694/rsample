context("Initial splitting")

library(testthat)
library(rsample)
library(purrr)

dat1 <- data.frame(a = 1:20, b = letters[1:20])

test_that('default param', {
  set.seed(11)
  rs1 <- initial_split(dat1)
  expect_equal(class(rs1), c("rsplit", "mc_split"))
  tr1 <- training(rs1)
  ts1 <- testing(rs1)
  expect_equal(nrow(tr1), nrow(dat1)*3/4)
  expect_equal(nrow(ts1), nrow(dat1)/4)
})

test_that('default time param', {
  rs1 <- initial_time_split(dat1)
  expect_equal(class(rs1), "rsplit")
  tr1 <- training(rs1)
  ts1 <- testing(rs1)
  expect_equal(nrow(tr1), floor(nrow(dat1) * 3/4))
  expect_equal(nrow(ts1), ceiling(nrow(dat1) / 4))
  expect_equal(tr1, dplyr::slice(dat1, 1:floor(nrow(dat1) * 3/4)))
})
