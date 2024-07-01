####   000000_here_experiment.R

# plant myself here
library(here)

# ---- packages? ----
# base::exists() ? all FAlSE !
base::exists(x = "base")
base::exists(x = "utils")
base::exists(x = "devtools")

library(devtools)
base::exists(x = "devtools")

# ----

y <- 3
base::exists(x = "y") # TRUE

search()
# usethis::browse_github()
base::exists("browse_github", mode = "function") # TRUE
base::exists("browse_github") # TRUE

f <- function(string) base::exists(string)
f("y")
f(c("mp3Files", "package:usethis"))

# ---- here() ----
here()

# END
#
