## ---- echo = FALSE-------------------------------------------------------
library("purrr")
library("tallyr")

## ---- eval = FALSE-------------------------------------------------------
#  # install.packages("remotes")
#  remotes::install_github("gcfrench/tallyr")

## ------------------------------------------------------------------------
output <- iris[1:5, ] %>%
  pmap(
    function(...) {
      message(paste0("The sepal length is ", pluck(list(...), "Sepal.Length")), " cm")
      Sys.sleep(0.25)
    })

## ------------------------------------------------------------------------
output <- iris[1:5, ] %>%
  tally_counter() %>%
  pmap(
    function(...) {
      message(paste0("The sepal length is ", pluck(list(...), "Sepal.Length")), " cm")
      Sys.sleep(0.25)
    })

## ------------------------------------------------------------------------
output <- iris[1:5, ] %>%
  tally_counter() %>%
  pmap(
    function(...) {
      message(paste0(click(), ": The sepal length is ", pluck(list(...), "Sepal.Length")), " cm")
      Sys.sleep(0.25)
    })

## ------------------------------------------------------------------------
output <- iris[1:5, ] %>%
  tally_counter(type = "add") %>%
  pmap(
    function(...) {
      message(paste0(click(), ": The sepal length is ", pluck(list(...), "Sepal.Length")), " cm")
      Sys.sleep(0.25)
    })

