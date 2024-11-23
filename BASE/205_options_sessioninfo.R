## 	Basic package info, including options in calendR?
{
  sessioninfo::session_info()

  .Options[grep("nvimcom", names(.Options))]
  # 	.Options[grep('nvimcom || calendR || dplyr', names(.Options))]
}

# ------------ Change option, then reset---------------
# SPELLING!     getOption (singular) but options (plural)
#
# Get option value
old <- getOption("digits")
old
print(pi)
# [1] 3.1416


# change
options("digits" = 20)
print(pi)
# [1] 3.141592653589793116

# change back
options("digits" = old)
print(pi)
# [1] 3.1416

# -------------------------------------------------------
#
#
z <- utils::sessionInfo()
z[["running"]]
# [1] "GalliumOS 3.1"
