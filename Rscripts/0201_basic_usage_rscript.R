#!/usr/bin/env Rscript
# basic_usage_rscript  --- some useful basics
#
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


