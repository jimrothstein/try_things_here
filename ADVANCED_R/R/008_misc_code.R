
# source("008_misc_code.R")
# source(here("book_advanced_R", "008_misc_code.R"))

# Problem 8.
# ============

# Step 1, wrapper
verify_package_installed  <- function(pkg){
#	if (!rlang::is_installed(pkg)) {

	if (!requireNamespace(pkg)) {
		message=glue::glue("Please install `{pkg}`")
		meta=pkg
		abort(message=message, 
					class="pkg_not_installed_error",
					meta=pkg)
	
	}
}

# TEST the wrapper
	verify_package_installed("rlang")
	verify_package_installed("pkg")

# function
# ==========
	
## REAL code to deal with an error											
f  <- function(pkg) {
	tryCatch(
					 verify_package_installed(pkg),
					 error = function(e) e,
					 pkg_not_installed_error = function (p) cat(p$meta)
					 )

}
f("pkg")
f("rlang")



