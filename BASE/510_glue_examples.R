# ---
# title: "`r knitr::current_input()`"
# date: "`r paste('last updated', 
#     format(lubridate::now(), ' %d %B %Y'))`"
# output:   
#   html_document:  
#         code_folding: show
#         toc: true 
#         toc_depth: 2
#         toc_float: true
#   pdf_document:   
#     latex_engine: xelatex  
#     toc: true
#     toc_depth:  2   
# fontsize: 11pt   
# geometry: margin=0.4in,top=0.25in   
# TAGS:  sprintf, glue, paste0, vectorize, sQuote, eval, quote, today
# ---
# 
# -	GLUE:	examples
# -	REF:	[Glue](https://www.r-bloggers.com/2019/07/glue-magic-part-i/)
# 
```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,
                      comment = "      ##",
                      error = TRUE,
                      collapse = T   ) # easier to read
```

---
####	From Rweekly.org; Week 30?  29?
https://twitter.com/cararthompson/status/1550475986210361347
---

####  PURPOSE:  glue prints as regular text (not as char[])
  ### Interpreted Sting Literals - SEE glue.tidyverse.org

####	Example of glue and purrr::walk
```{r a_glue_purrr_example}

library(glue)
library(purrr)
# Setting things up


# Compare 2 print statements
greet = "Hello!"

# as string
print(glue::glue(greet))
print(quote(greet))

# But all these print as char[1]
print(greet) # vector
paste0(greet) # vector
print(paste0(greet))


penguin_salute <- function(penguin) {  
  
	#	Glue:  simple string
	# Without glue: get a char[1]

	print(glue::glue("Hi, {penguin}!"))       ##  prints as regular text 
	print(paste0("Hi ", penguin))             ##  prints as char[]

}

penguins <- c("Adelie", "Chinstrap", "Gentoo")

# Using a for loop
for(penguin in penguins) {  
  penguin_salute(penguin)  
}

# FAILS
Map(glue::glue, penguins)

#	FAILS: compare with vapply (TODO: remove final line of output, atomic vector)
vapply(penguins, 
function(x) {print(glue::glue("Hi, {x}!"))},
#			invisible("a") }

FUN.VALUE = character(length=1),
.NAMES = F)



# Using purrr
purrr::walk(penguins, penguin_salute)

# Output from both:
Hi, Adelie!
Hi, Chinstrap!
Hi, Gentoo!
```


### Both sprint and glue offer improved over print 
  *  REF:  [Glue](https://www.r-bloggers.com/2019/07/glue-magic-part-i/)


```{r if_run_knitr}

    glue("name of this file is {knitr::current_input()}\n")
          ## name of this file is 00002_glue.Rmd
    output_file  <- knitr::current_input()

```

####	invisible
```{r}

##	Compare:

    g  <- function(x) {
       list(x=x, a=2*x)
    }

    f  <- function(x) {
      invisible(list(x = x, a = 2*x))
    }

    g(2)  # prints the list

# $x
# [1] 2
# 
# $a
# [1] 4
# 

		f(2)   # nothing prints!  (Note:  using nvim's run and insert output WILL
		capture output)

##	also prints nothing

	ans1  <- g(2)
	ans  <- f(2)
```

### Why glue:: ?
-  less need to use paste0
-  saves couple of keystrokes, but easier to read
```{r glue}
x  <- 3
y  <- 4

paste0("x = ", x)
# [1] "x = 3"
paste0("y = ", y)
# [1] "y = 4"

glue("x = {x}\n")
# x = 3
```

### Glue can use r expressions/functions (number all files!)
```{r file_name}

## trival
  glue("1 + 1 = {1+1}")

## cute, prepend number to each file name in the directory
  l  <- list.files(".")
  glue("{1:length(l)}_{l}")


## sprintf + glue ?  
## Format prefix with zeros   (00001_file_name)
  prefix  <- sprintf("%04i", 1:length(l))
  glue("{prefix}_{l}")
```

#### glue and sQuote
```{r sQuote}
x  <- 55

##	Note, sQuote(x) returns char[1] 
		sQuote(x)
# [1] "‘55’"

## Compare

  glue("value of {quote(x)} is {x}")
# value of x is 55

  glue("value of {sQuote(quote(x))} is {x}")
  # value of ‘x’ is 55

quote(x) # supress eval
# x
```

#### glue & dates (goal:  today is 27JUL2022)
```{r glue_dates}


##	default is year 1st
Sys.Date()
# [1] "2022-07-27"


##	format using string format
format(Sys.Date(), "%d%b%Y")
# [1] "27Jul2022"

##  Error, format is fussy about format for x	
if (F) format("07-27-2022", "%d%b%Y")

## finally
glue("Today is a special day: ", {format(Sys.Date(), '%d%b%Y') })
# Today is a special day: 27Jul2022
```


### paste0 is vectorized; don't overlook
```{r paste0, attr.source='.numberLines'}
c1  <- letters[1:10]
c2   <- 1:length(c1)

paste0(c1, " = ", c2)


c3  <- sprintf("%04i", c2)
c3

paste0(c3, " = ", c1)
paste0(c3, "_", c1)

```

### print line numbers (pdf only?)
```{r, attr.source='.numberLines'}
if (TRUE) {
  x <- 1:10
  x + 1
}
```

```{r invisible}

g  <- function(x) {
   list(x=x, a=2*x)
}
f  <- function(x) {
  invisible(list(x = x, a = 2*x))
}

g(2)  # prints the list

f(2)   # nothing prints!

ans  <- f(2)
ans   # prints the list
```


```{r knit_exit(), include = FALSE  , eval=FALSE } 
# knitr::knit_exit()
```


```{r skeleton}
file="/home/jim/.config/nvim/templates/skeleton.Rmd"
```

```{r render, eval=FALSE, include=FALSE 	} 

## In doubt?   USE  knitr and do not waste time!

## Want to embed Latex, stick to pdf output (html?   never sure!)

# NOTE:   .tex only works with PDF
# NOTE:    tex will NOT work with html
# NOTE:    md_document is considered HTML, and latex commands may fail.
# in general, pdf will look nicer


## GOOD PRACTICE:
#  Refer to files relative to project root, which should remain as working dir.
#  So why using `here` ?

{
file <- "/home/jim/code/try_things_here/rmd/6000_glue_sprintf_examples.Rmd"
file  <- basename(file)
#file  <- here("rmd", file)
file  <- paste0(file.path("~/code/try_things_here/"),"rmd/", file)
file
}

output_dir  <- Sys.getenv("OUTPUT_DIR")
output_dir

rmarkdown::render(file,
                  output_format = "pdf_document",
                  output_dir = output_dir)


```
