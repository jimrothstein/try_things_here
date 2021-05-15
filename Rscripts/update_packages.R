#!/usr/bin/env Rscript
#
#
# FIRST:  run ./update_old_packages.Rd
# PURPOSE:   updates R packages
# USAGE:    ./update_packages.R  at COMMAND LIME
# Works!
#
print("update.packages()")
Sys.time()

{
begin  <- Sys.time()
    update.packages(ask = FALSE , checkBuild=TRUE)
    end  <- Sys.time()
    diff  <- end - begin
    diff
}
