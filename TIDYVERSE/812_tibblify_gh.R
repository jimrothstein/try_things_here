812_tibblify_gh.R
library(tibblify)

# -----------
# Examples:  Github users, Guess specs, modify, tifflify again
# -----------
library(tibblify)

gh_users_small <- 
        purrr::map(gh_users, ~ .x[c("followers", "login", "url", "name", "location", "email", "public_gists")])

# 1 list containing 4 other lists (each of length 7)
str(gh_users_small, max.level=1)
names(gh_users_small[[1]])

# email has no spec?
tibblify(gh_users_small)

# Guess !
guess_tspec(gh_users_small)

spec <- tspec_df(
  login_name = tib_chr("login"),
  tib_chr("name"),
  tib_int("public_gists"),
  tib_int("followers")
)

tibblify(gh_users_small, spec)

