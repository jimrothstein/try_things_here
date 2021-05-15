#!/usr/bin/env Rscript
#
#
# PURPOSE:   updates old R packages
# USAGE:    ./update_old_packages.R  at COMMAND LIME
# Works!
#
Sys.time()
{
  begin  <- Sys.time()
  update.packages(ask = F,
                oldPkgs = old.packages(),
                checkBuilt=T)
  end  <- Sys.time()
  diff  <- end - begin
  diff
}
