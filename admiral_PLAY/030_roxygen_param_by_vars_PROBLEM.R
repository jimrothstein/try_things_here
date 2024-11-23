# Although the original function (1st one below) seems to print the
# new line characters ('\n', ) when the documentation is actually
# rendered these \n are interpreted correctly to print new lines, in
# the documentation.

# So NO problems!


roxygen_param_dataset <- function(expected_vars = NULL) {
  if (is.null(expected_vars)) {
    dataset_text <- "Input dataset"
  } else {
    dataset_text <- paste0(
      "Input dataset \n \n",
      "The variables specified by the ",
      ansi_collapse(map_chr(expected_vars, ~ paste0("`", ., "`"))),
      " argument",
      if_else(length(expected_vars) > 1, "s", ""),
      " are expected to be in the dataset."
    )
  }
  return(dataset_text)
}

roxygen_param_dataset2 <- function(expected_vars = NULL) {
  if (is.null(expected_vars)) {
    dataset_text <- "Input dataset"
  } else {
    dataset_text <- glue::glue(paste0(
      "Input dataset \n \n",
      "The variables specified by the ",
      ansi_collapse(map_chr(expected_vars, ~ paste0("`", ., "`"))),
      " argument",
      if_else(length(expected_vars) > 1, "s", ""),
      " are expected to be in the dataset."
    ))
  }
  return(dataset_text)
}

vars = c("A", "B", "Z")
roxygen_param_dataset(vars)
roxygen_param_dataset2(vars)
