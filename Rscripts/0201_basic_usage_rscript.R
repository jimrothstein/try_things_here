#!/usr/bin/env Rscript
# basic_usage_rscript  --- some useful basics
#
#
#
#  K E E P 
# ===========
#
# chmod 744 should suffice
#
print("hello")
Sys.time()
print("== all args ==")
# char[] of all args
args  <- commandArgs()
print(args)


print("== only trailing ==")
args  <- commandArgs(trailingOnly = T)
print(args)

# ======================================================
# At CLI, ask R to run just one expression and return:
# ======================================================

# USAGE:  >Rscript -e ' expression '
#
# > Rscript -e '2+2' -e '3+3'
