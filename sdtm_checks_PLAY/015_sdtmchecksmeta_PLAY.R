#  sdtmchecks - practice area
#  Misc info about pkg=sdtmchecks

library(sdtmchecks)
library(testthat)

# finds pkg, objects ect,
search()

# find package
utils::getAnywhere(sdtmchecksmeta)

# all objects
base::objects(package:sdtmchecks)


### PURPOSE:  Understand R code for sdtmchecksmeta 

### For understanding one check function, see:  020_

### shortcut for 
meta = sdtmchecksmeta

names(sdtmchecksmeta)

#

sdtmchecksmeta[1:5, 1]
sdtmchecksmeta[1:5, c("check")]
sdtmchecksmeta[1:5, c("fxn_in")]
sdtmchecksmeta[1:5, c("pdf_return")]

sdtmchecksmeta[1:5, c(1,2,3,4,8, 11)
