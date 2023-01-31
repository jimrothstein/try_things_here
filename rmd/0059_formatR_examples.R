---
TAGS:  sessionInfo, args, formatR::
---
## 059_format_R_examples

library(formatR)
options(error = traceback)
traceback()



## begin
s<-sessionInfo()
str(s)
s$R.version$version.string

# compare	
formatR::usage(glm)	
args(glm)

# example	
# copy to clipboard, in console: tidy_source()
## my first comment, sloppy but gets teh job done
	x=1
y= 0
  z=3	

## example
## copy o clip
## in console,  tidy_source(indent=10)
if (TRUE) {
  x = 1  # inline comments
  } else {
  	x = 2
  	print("Oh no... ask the right bracket to go away!")
  }
 
