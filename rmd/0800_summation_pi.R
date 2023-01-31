##	file <- "0800_summation_pi.R"
##	PURPOSE:   large (but infinite) summation:   compare sapply to recursion (tail recursion not supported)
# R
#
#
#'  example(object) provides worked examples of quoted object:
    example(round)

#'  help(package = <pkg>) (opens window)
    help(package = data.table)


#'  help on topic (opens window)
    ?files

#'  help.search("S3")   # general search (opens window)
    help.search("S3")

#'  apropos("S3")      # returns char[]
    apropos("S3")

    #'
/*  comments
    spin does not seem to like ANY yaml header
    file <- "1010_R_help_commands.R  "
    knitr::spin("~/code/try_things_here/rmd/1010_R_help_commands.R")
*/


##---------
##	sapply, generates pi
##---------
f  <- function(k) {
	(-1)^(k+1)/(2*k-1)

}
f(1)
f(2)
f(3)


4*sum(sapply(1:10^6, f))


##-----------------------------------------------------
#'	recursive does NOT work very well... C-stack limit
#'	NOTE:  exists 'tail recursion' but R does not support.
#'	If the last line of a function is a call to itself, some languages will `reuse` the existing stack.   This does not add a stack entry and allows repeated calls.   R does NOT support this.
##-----------------------------------------------------

g		 <- function(k) {
	if (k == 0 )  return(0)
	 (-1)^(k+1)/(2*k-1) + g(k-1)
}

rbenchmark::benchmark( {
	4*g(10^3)
}
	)

4*g(10^3)

