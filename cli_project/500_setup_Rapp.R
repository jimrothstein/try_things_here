
# Install dev version of Rapp package
pak::pak("r-lib/Rapp")
remotes::install_github("r-lib/Rapp")


# Add to launcher to path
Rapp::install_pkg_cli_apps("Rapp")


# For each, R snippet you write
# Make code executable (chmod +x)


# Test in R, run example 

library(Rapp)
Rapp::run("./510_simple_Rapp.R")   # if has x permission
#  tails

# at shell prompt,  runs like bash code   (do not need to preface with Rscript ...)
# ./510_simple_Rapp.R
