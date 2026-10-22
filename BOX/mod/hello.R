# Box module
# mod/hello.R

# USAGE:

# box::use(
#   tibble,
#   mod/hello   # no .R extension
# )
# hello$hello("jim")

#' @export
hello = function (name) {
  message('Hello, ', name, '!')
}

#' @export
bye = function (name) {
  message('Goodbye ', name, '!')
}
