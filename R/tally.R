# parent counter object
counter <- R6::R6Class("counter",
  private = list(
    ..start = NULL,
    ..end = NULL,
    ..count = NULL,
    ..increment = NULL,
    ..pad = NULL,
    ..status = "ON"
  ),
  public = list(
    counter = function() {
      if (private$..increment == "add") {
        private$..count <- private$..count + 1
      } else if (private$..increment == "subtract") {
        private$..count <- private$..count - 1
      }
      if (private$..count == private$..end) {
        private$..status <- "OFF"
      }
    },
    display = function() {
      message(stringr::str_c(stringr::str_pad(private$..count, private$..pad, pad = "0")))
    },
    finalize = function() {
      message("tally counter OFF")
    }
  ),
  active = list(
    status = function() {
      private$..status
    }
  )
)

# child add counter object
counter_add <- R6::R6Class("counter_add",
  inherit = counter,
  public = list(
    initialize = function(limit) {
      private$..end <- limit
      private$..start <- 0L
      if (nchar(as.character(limit)) < 4) {
        private$..pad <- 4
      } else {
        private$..pad <- nchar(as.character(limit))
      }
      private$..count <- private$..start
      private$..increment <- "add"
      message("tally counter ON")
      self$display()
    }
  )
)

# child subtract counter object
counter_subtract <- R6::R6Class("counter_add",
   inherit = counter,
   public = list(
     initialize = function(limit) {
       private$..end <- 0L
       private$..start <- limit
       if (nchar(as.character(limit)) < 4) {
           private$..pad <- 4
       } else {
           private$..pad <- nchar(as.character(limit))
       }
       private$..count <- private$..start
       private$..increment <- "subtract"
       message("tally counter ON")
       self$display()
       }
    )
)


#' tally_counter
#'
#'  This function initiates a new tally counter with the count limit set to the number of rows in the data frame
#'  that will be used to interate over. The counter can either increase from zero to the number of rows set or
#'  decrease from the number of rows to zero.
#'
#' @param data a data frame to be used in subsequent iteration
#' @param type character string indicating type of counter to use, either adding or subtracting counts
#'
#' @return the data frame is returned so that the function is pipe friendly
#' @export
#'
#' @examples
#' data <- data.frame(x = 1:10)
#' tally_counter(data, type = "add")
tally_counter <- function(data, ...) {

  # get function arguements
  arg_list <- list(...)
  max_limit <- nrow(data)

  # create counter object in new counter_env environment
  assign("counter_env", new.env(parent = emptyenv()), envir = globalenv())
  if (!length(arg_list)) {
    assign("counter_obj", counter_add$new(limit = max_limit), envir = counter_env, inherits = FALSE)
  } else if (arg_list$type == "add") {
    assign("counter_obj", counter_add$new(limit = max_limit), envir = counter_env, inherits = FALSE)
  } else if (arg_list$type == "subtract") {
    assign("counter_obj", counter_subtract$new(limit = max_limit), envir = counter_env, inherits = FALSE)
  } else {
    stop("Incorrect tally counter type, type must be either add or subtract")
  }

  # return data frame to allow use in piping
  invisible(data)
}

#' click
#'
#' This function adds or subtracts one from the counter depending on the tally counter type used as defined with the
#' tally_counter function. It prints the current count to the console with a minimum padding of four characters. Once
#' counter has finished counter is removed from its environment
#'
#' @export
#'
#' @examples
#' data <- data.frame(x = 1:10)
#' tally_counter(data, type = "add")
#' click()
click <- function() {

  # get counter object
  counter_obj <- get("counter_obj", envir = counter_env)

  # increment counter object and check current counter status
  counter_obj$counter()

  # display current counter count
  counter_obj$display()

  # remove counter object and enviromnent if counter finished
  if (counter_obj$status == "OFF") {
      rm(counter_obj, envir = counter_env)
      rm(counter_env, envir = globalenv())
      gc()
  }
}

