# tallyr

## Overview

The main goal of **tallyr** is to provide a quick and easy way to monitor progress whilst iterating 
through a data frame, applying a function to each row at a time. This can be useful when the time 
taken for this step is sufficiently long enough to run the Script in the background, coming back to 
the console at regular intervals to see how the script is progressing. The number of rows remaining 
to be processed is easily displayed in the console so that you can see at a glance how far the
script has progressed and how far there is to go.

## Installation

The package is on github and can be installed through the devtools package
```{r, eval = FALSE}
# install.packages("devtools")
install_github("gcfrench/tallyr")
```

There are two function in the package

* `tally_counter()` initiates the counter setting the count to the number of rows to be iterated 
through. The counter counts downwards to zero during the iteration step. This behaviour can be 
changed through the type argument so that the counter counts upwards from zero to the total 
number of iterations. 
*  `click()` updates the counter, either decreasing or increasing the count
by one. This up-to-date count can then be displayed in the console.

## Using the counter

The counter is initiated by passing the data frame into the `tally_counter()` function. This can
be done within a pipeline containing the iteration step.

As an example take the first five rows of the iris dataset and return the sepal
length for each row by passing each row one at a time into a function.

```{r}
iris_five <- iris[1:5, ]
output <- iris_five %>% 
  by_row(
  function(x) {
    message(paste0("The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })
```

This time the tally counter can be initiated just before running the iteration step by adding the 
`tally_counter()` function within the pipeline. On running the pipe an initial message will show
the the counter has been turned on.

```{r}
output <- iris_five %>% 
  tally_counter() %>% 
  by_row(
  function(x) {
    message(paste0("The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })
```

Now to display the count during each iteration step just add the `click()` function to a message
within your function. Each time the function is run the counter will be updated and displayed in the
console.

```{r}
output <- iris_five %>% 
  tally_counter() %>% 
  by_row(
    function(x) {
    message(paste0(click(), ": The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })
```

## Changing the counter behaviour

By default the counter counts down from the total number of row to be iterated over, as this allows
a quick assessment of how far there is to go with the iteration step, but this behaviour can be
changed so that the counter counts up from zero instead.

You can alter this behaviour via the `type` argument. On passing **add** to this argument the
counter will increase sequentially whilst passing **subtract** the counter will decrease
sequentially.

```{r}
output <- iris_five %>% 
  tally_counter(type = "add") %>% 
  by_row(
  function(x) {
    message(paste0(click(), ": The sepal length is ", as.numeric(x[, "Sepal.Length"])), " cm")
    Sys.sleep(0.25)
  })
```


