#' get_environment returns tibble of environment
#'
#'
#'
#' @export
get_environment  <- function() {

# each row is char[1]	, 82 x 1
# 
t <- tibble::tibble(environment = Sys.getenv())

# z  <- tibble::tibble(env=names(t$environment),
#                   values = t[[1]])

}
