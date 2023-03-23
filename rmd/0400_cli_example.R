#   USAGE:   Rscript -e "source('...')"
#
#   R console does NOT display embellishments
library("cli")

name <- "jimbo"
pkg <- "dplyr"
cli::cli_text("hi {.emph {name}}")
cli::cli_code("hi {.code x = 5)")
cli::cli_text("hi {.strong {name}}")
cli::cli_text("hi {.pkg {pkg}}")
cli::cli_text("hi {.url https://www.nytimes.com } is covered in paywall.")
