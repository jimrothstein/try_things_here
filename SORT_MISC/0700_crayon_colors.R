library(crayon)

# 	Use R interactive
# > source("0700_crayon_colors.R")
cat(yellow("... This is yellow\n\n"))
cat("... to highlight the " %+% red("search term") %+%
  " in a block of text\n")

cat(yellow$underline("... This is yellow with underline\n\n"))
