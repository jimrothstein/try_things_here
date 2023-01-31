# STUDY  httr::   url.r code
#
# READABLE:
#https://tools.ietf.org/html/rfc3986
#
# GOAL:   What is  'params'
# STATUS:  might be part of query?  do not know
#
# FAKE URI
url  <- "https://tools.ietf.org:80/html/rfc3986?a=hello;b=jim"

library(stringr)
pull_off <- function(pattern) {
    if (!str_detect(url, pattern)) return(NULL)

    piece <- str_match(url, pattern)[, 2]
    url <<- str_replace(url, pattern, "")

    piece
  }
#
 query <- pull_off("\\?(.*)$")
query

  if (!is.null(query)) {
    query <- httr::parse_query(query)
  }

# ===============================
 # This is where params appears
# ===============================
 # What does this do?
  params <- pull_off(";(.*)$")
  params
