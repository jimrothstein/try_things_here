# 020_rstudioapi_create_pkg.R

library("rstudioapi")
library(devtools)
build()
document()
install()


# ---- works
getwd()
document("./pkg_keyShortcuts")
fct_keyShortcuts() # works
# ----

library(pkgkeyShortcuts)

check()
#
# keyStrokeShortcuts_function <- function() {
        rstudioapi::insertText(" %>% ")
}
