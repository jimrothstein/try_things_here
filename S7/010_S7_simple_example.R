2024 - 04 - 22

##
library(S7)
library(testthat)

# define a new S7 class, dog
dog <- S7::new_class("dog", properties = list(
  name = class_character,
  age = class_numeric
))
dog


##  function dog() is constructor, with empty defaults.
dog()
# <dog>
#  @ name: chr(0)
#  @ age : int(0)


## create instance
lola <- dog("lola", age = 11)
lola


## tests
testthat::test_that("Checks if S7", {
  expect_no_error(S7::check_is_S7(dog))
  expect_no_error(S7::check_is_S7(dog()))
  expect_no_error(S7::check_is_S7(lola))
})

attributes(lola)
class(lola)
typeof(lola)

testthat::test_that("Check parent", {
  expect_false(inherits(lola, what = c("S3")))
  expect_false(inherits(lola, what = c("S4")))
  expect_true(inherits(lola, what = c("S7_object")))
})
