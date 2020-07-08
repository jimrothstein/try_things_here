# 021_R_efficient_coding.R
 
# see:
# https://csgillespie.github.io/efficientR/set-up.html

# ---- R help ----
?mpg   # mpg is dataset (if loaded)
?stats  # package
?reprex # function

?ggplot   # function

??reprex  # topic
??ggplot   # topic 
??pch      # topic 
??regression

help.search("pch")  # long form


Sys.info()  # Linux 4.4.52 - ....
list.files(all.files = TRUE) # show hidden too

# ---- 001 monitor -----
# BIG

elements <- 1e8   # 1e9 and laptop crashes, rebootsS
X <- as.data.frame(
        matrix(rnorm(elements), nrow=elements/10)
)

r1 <- lapply(X,median)

r2 <- parallel::mclapply(X, median)


# ---- 002 update  all R packages ----
update.packages(ask = FALSE)


# ----  003 view all installed R packages? ----
# at cmd line  which needed?
# apt-get cache search "^r-*" | sort

# ---- 004 R startup ----

# In this order, R seeks .Rprofile $R_HOME, $HOME, project directory
?Startup
R.home() # /usr/lib/R
site_path = R.home(component = "home") # /usr/lib/R
fname = file.path(site_path, "etc", "Rprofile.site") # /usr/lib/R/etc/Rprofile.site

file.exists(fname) # True

# 
file.exists("~/.Rprofile") # True, also

# ----- 005 .Rprofile (project) ----
# be sure exists 
file.exists(".Rprofile") # TRUE
# options?
options()
# 2 sign digits  (3.7)
options(prompt = "R> ", digits = 2, show.signif.stars = FALSE, continue = "  ")

getOption("repos")  # cran.rstudio.com

fortunes::fortune(50)  # error
.Last = function() {
        
        message("Goodbye at ", date(), "\n")
}
.Last()