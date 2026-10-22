library(rlang)
library(magrittr)
library(dplyr)

#### Maya exampls, Chapter 8, error Handling {{{

#### get the data# {{{
if (!file.exists("data.rds")) {
brewing_materials <-
	readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewing_materials.csv')

beer_taxed <- 
	readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_taxed.csv')

brewer_size <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/brewer_size.csv')

beer_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_states.csv')

l  <- list(brewing_materials, beer_taxed, brewer_size, beer_states)

# saveRDS is preferred, but can save only 1 object
saveRDS(l,"data.rds")

} else {
l  <- readRDS("data.rds")
}
# }}}

env_names(current_env())

#### basic examples, try, tryCatch ...# {{{
# construct tibble of column names & types
brewing_materials  <- l[[1]]
beer_tax  <- l[[2]]
beer_size  <- l[[3]]
beer_size	

tibble(data = "brewing_materials", 
			 f_name = names(brewing_materials), 
			 c_type = sapply(brewing_materials, class) )
lapply(brewing_materials, is.na(x))

# 

# --------------
# Errors
# --------------

# 1. stop with .call=FALSE
beer_mean <- function(x) {
  if (!is.numeric(x)) {
    stop("Need numeric column", call.=FALSE) #<<
    mean(data[[x]])
  } else{
    mean(x)
  }
}

beer_mean(beer_states$state)


# ===============

# 2. same example using abort, now include metadata

beer_mean <- function(x) {
  if (!is.numeric(x)) {
    abort( #<<
      message = "Need numeric column", #<<
      arg = x #<<
    ) #<<
    mean(data[[x]])
  } else{
    mean(x)
  }
}

beer_mean(beer_states$state)

# 3. same example but now we use abort + glue to show the column name that produced the error

beer_mean <- function(data, x) {
  column_name <- deparse(substitute(x))
  msg <- 
		glue::glue("Can't calculate mean, {column_name} is not numeric") 
	if (!is.numeric(data[[x]])) {
		rlang::abort(
      message = msg,
      arg = column_name,
      data = data
    )
    mean(data[[x]])
  } else {
    mean(data[[x]])
  }
}

beer_mean(beer_states, "state")

str(rlang::catch_cnd(beer_mean(beer_states, "state")))# }}}


# --------------
# Warnings
# --------------

# If the ‘truncated’ parameter is non-zero, the ‘ymd’ functions also
# check for truncated formats. For example ‘ymd()’ with ‘truncated =
# 2’ will also parse incomplete dates like ‘2012-06’ and ‘2012’.

# forcing 2008 into a date 2008-01-01
beer_state <-
  beer_taxed %>%
  mutate(year = lubridate::ymd(year, truncated = 2L))

is.Date <- function(x) {
  inherits(x, c("Date", "POSIXt"))
}

beer_mean <- function(data, x) {

  column_name <- deparse(substitute(x))

  if (is.Date(data[[x]])) {
    warning(glue::glue("Are you sure you wanna calculate the mean? {column_name} is of type date"))
    mean(data[[x]])
  } else {
    mean(data[[x]])
  }
}

beer_mean(beer_state, "year")

# --------------
# Messages
# --------------

basic_summary_stats <- function(data, x, round_n = NULL, quiet = FALSE) {

  column_name <- deparse(substitute(x))

  if (is.null(round_n)) {

    if (isFALSE(quiet)) message("round_n argument null, rounding to 2 digits by default") #<<

    data %>%
      summarise(
        missing = sum(is.na(data[[column_name]])),
        mean = round(mean(!is.na(data[[column_name]])), 2),
      )
  } else {
    data %>%
      summarise(
        missing = sum(is.na(data[[column_name]])),
        mean = round(mean(!is.na(data[[column_name]])), round_n),
      )
  }
}

  beer_states %>% basic_summary_stats(barrels)
  beer_states %>% basic_summary_stats(barrels, 4)
  beer_states %>% basic_summary_stats(barrels, quiet = TRUE)


# --------------
# try
# --------------

# 1. assignment inside the function

# -----------
# supress
# ----------

# 1. supress warning/message
# I don't want this to be a dumb example - when would we actually do this?
# maybe creating a wrapper function around some function that produces a warning
# that doesn't really apply in our use case?

# ------------
# try
#-------------


# ------------
# tryCatch
# ------------

# 1. with finally argument - usually an on.exit type function

# ------------
# withCallingHandlers()
# ------------

# 1. some bubblibg type example but this barely made sense to me


# ==================
## deparse EXAMPLE
# ==================
	# deparse:  r expr (uneval) --->  string
	# substituted:  value ----> calling_env value
	plop <- function(a, b) {
  	cat("You entered", 
				deparse(substitute(b)), 
				"as `b` \n")
  a * 10
}
plop(a = 2, b = var_doesnt_exist)

## SAME !
plop1 <- function(a, b) {
  	cat("You entered", 
				substitute(b), 
				"as `b` \n")
  a * 10
}
plop1(a = 2, b = var_doesnt_exist)

 
#
library(ggplot2)
ggplot(brewer_size, aes(n_of_brewers, total_barrels)) +
	geom_point()

# }}}

```{r source}
source("008_misc_code.R")
```

