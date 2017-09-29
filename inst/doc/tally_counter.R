## ---- echo = FALSE-------------------------------------------------------
library("magrittr")
library("purrrlyr")
library("tallyr")

## ---- eval = FALSE-------------------------------------------------------
#  # install.packages("devtools")
#  install_github("gcfrench/tallyr")

## ------------------------------------------------------------------------
iris_five <- iris[1:5, ]
output <- iris_five %>% 
  by_row(
  function(x) {
    message(paste0("The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })

## ------------------------------------------------------------------------
output <- iris_five %>% 
  tally_counter() %>% 
  by_row(
  function(x) {
    message(paste0("The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })

## ------------------------------------------------------------------------
output <- iris_five %>% 
  tally_counter() %>% 
  by_row(
    function(x) {
    message(paste0(click(), ": The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })

## ------------------------------------------------------------------------
output <- iris_five %>% 
  tally_counter(type = "add") %>% 
  by_row(
  function(x) {
    message(paste0(click(), ": The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })

