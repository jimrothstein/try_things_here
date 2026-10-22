---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: sho
        toc: true 
        toc_depth: 2
        toc_float: true
        mathjax: default
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  2   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  
---

####	PURPOSE:  Display US House Seats vs Year.(Total=437)


{
library(data.table)
library(tibble)
t  <- tribble(
		~year, ~dems, ~repub,
		1964, 295, 140,
		1966, 248, 187,
		1968, 243, 192,
		1970, 255, 180,
		1972, 243, 192,
		1974, 291, 144,
		1976, 292, 143,
		1978, 277, 158,
		1980,	243,	192,
		1982,	269,	166,
		1984,	253,	182,
		1986,	258,	177,
		1988,	260,	175,
		1990,	268,	167,
		1992,	259,	176,
		1994,	205,	230,
		1996,	208,	227,
		1998,	212,	223,
		2000,	213,  222,
		2002, 206,  229,
		2004, 203,  232,
		2006,	233,  202,
		2008, 257,  178,
		2010, 193,  242,
		2012, 201,	234,
		2014,	188,	247,
		2016,	241,	194,
		2018,	235,	200,
		2020,	222,	213

		)

}


{
t
dput(t)
}

####	convert to dt and test
{
	dt  <- as.data.table(t)
	dt

	#	tighten !
	dt[, year:=as.integer(year)]

	dt[, dems:=as.integer(dems)]

	dt[, repub:=as.integer(repub)]
dt

}

{

	dt  <- dt[, .(year, dems, repub, diff= dems-repub, total = dems+repub)]
	dt

}


####	base - forgot!  how does abline work?
{
	plot(x=dt$year, y=dt$diff, type="p")

	x=dt$year
	z=5
	length(x)

	y=rep(c(0), length(x))
	abline(h=0)
	
	abline(x,y,   type = "b", lty = 1, pch = 4, col = 1:nlevels(z))
	lines(x=x,y=y,   type = "b", lty = 1, pch = 4, col = 1:nlevels(z))

	legend(title="By year, ....")
}

####	png
{
filename  <- "~/Downloads/print_and_delete/out.png"

png(filename = filename,
         width = 960, height = 480, units = "px", pointsize = 12)
	base::plot(x=dt$year, y=dt$diff, type="p",
						 main=paste0("By year, 1964-2020","\n", "Seat Advantage:  Democrats - Republicans"),
						col=ifelse(dt$diff>0,"blue","red"),
			 pch=19)
		


	abline(h=0)
	#abline(x,y,   type = "b", lty = 1, pch = 4, col = 1:nlevels(z))
	#lines(x=x,y=y,   type = "b", lty = 1, pch = 4, col = 1:nlevels(z))

	#legend(legend="By year, ....")

dev.off()
}


####	ggplot2
{
##  Use r-graphics cookbook (mostly ggplot2)
library(ggplot2)

dt
ggplot(data=dt, aes(x=year, y=diff  )) +

   # geom_line() +
    geom_point()

ggsave(filename= "DIFF.png", device="png")
getwd()
}


