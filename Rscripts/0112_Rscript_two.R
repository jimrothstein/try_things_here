#!/usr/bin/env Rscript
# at commnad line
# 
# =================================
# SELF-CONTAINED
# USAGE:  ./095_R_script_execute.R
#
# OTHER CLI:
#	-	Run R 									# loads whole thing
#	-	Rscript -e "8*8"  			# returns answer only
#	
# =================================
print("hello")
args <- commandArgs(trailingOnly = F)
print(args)
