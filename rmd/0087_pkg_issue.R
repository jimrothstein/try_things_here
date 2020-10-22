# 060A_reprex_pkg_issue.R


# ---- use reprex in code ----

# ---- including in .Rprofile ----
# library(devtools)
# library(reprex)


# ---- EX 1 ----
# works
reprex ({
	devtools::build(pkg = "~/code/r_mp3_files")
	devtools::load_all(path = "~/code/r_mp3_files")
}, venue="R")

## reprex outputs
devtools::build(pkg = "~/code/r_mp3_files")
#>   
   checking for file ‘/home/jim/code/r_mp3_files/DESCRIPTION’ ...
  
✔  checking for file ‘/home/jim/code/r_mp3_files/DESCRIPTION’ (604ms)
#> 
  
─  preparing ‘mp3Files’:
#>    checking DESCRIPTION meta-information ...
  
✔  checking DESCRIPTION meta-information
#> 
  
─  checking for LF line-endings in source and make files and shell scripts
#> 
  
─  checking for empty or unneeded directories
#>    Removed empty directory ‘mp3Files/R/ ’
#> 
  
─  building ‘mp3Files_0.1.0.tar.gz’
#> 
  
   
#> 
#> [1] "/home/jim/code/mp3Files_0.1.0.tar.gz"
devtools::load_all(path = "~/code/r_mp3_files")
#> Loading mp3Files
#> 
#> Attaching package: 'rlang'
#> The following objects are masked from 'package:purrr':
#> 
#>     %@%, as_function, flatten, flatten_chr, flatten_dbl, flatten_int,
#>     flatten_lgl, flatten_raw, invoke, list_along, modify, prepend,
#>     splice

# ---- BUT ----
reprex({
	devtools::install(pkg = "~/code/r_mp3_files")
}, venue = "R")


## reprex output
devtools::install(pkg = "~/code/r_mp3_files")
#> Error: HTTP error 401.
#>   Bad credentials
#> 
#>   Rate limit remaining: 56/60
#>   Rate limit reset at: 2020-02-09 06:43:23 UTC
#> 
#> 
devtools::session_info()
