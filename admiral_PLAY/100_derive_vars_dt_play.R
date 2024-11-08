# derive_vars_dt.R
#https://pharmaverse.github.io/admiral/reference/derive_vars_dt.html

# file:  R/derive_vars_dt.R
# function:  impute_dtc_dt
# GOAL:  conversion rules

# returns either NA or yyyy-mm-dd
# highest?   Y > M > D > h > m > s
# date_imputation (default, for Y,M,D) is first
# for "D" imputation, must have M in original

# 01 setup  --------
library(admiral)
args(impute_dtc_dt)

dates <- c(
  "2019-07-18T15:25:40",
  "2019-07-18T15:25",
  "2019-07-18T15",
  "2019-07-18",
  "2019-02",
  "2019",
  "2019",
  "2019---07",
  ""
)
res = tibble(dates=dates)
res

# 02 no impute -------------
#' # No date imputation (highest_imputation defaulted to "n")
res1 = impute_dtc_dt(dtc = dates)
res = dplyr::mutate(res, res1)
res

# 03 M only ---------

#' # Impute to first day/month if date is partial
#  note: date_imputation default is first
res2 = impute_dtc_dt(
  dtc = dates,
  highest_imputation = "M"
)

res = dplyr::mutate(res, res2)
res

# 03A Select highest imputation
res3A = impute_dtc_dt(
  dtc = dates,
  highest_imputation
)

res = dplyr::mutate(res, res2)
res

# M, "01-01" date_imputation ---------


#' # Same as above (b/c first)
#' impute_dtc_dt(
#'   dtc = dates,
#'   highest_imputation = "M",
#'   date_imputation = "01-01"
#' )

#' # Same as above (b/c first)
res3 = impute_dtc_dt(
  dtc = dates,
  highest_imputation = "n",
  date_imputation = "01-01"
)

res = dplyr::mutate(res, res3)
res

# 4 last -----
#' # Impute to last day/month if date is partial
res4= impute_dtc_dt(
  dtc = dates,
  highest_imputation = "M",
  date_imputation = "last",
)

res = dplyr::mutate(res, res4)
res

# 5 -----------------------------------------------------------------------
wrapper = function(dtc, highest_imputation, date_imputation, min_dates, max_dates  ) {
  # dtc must be char()
  res = tibble(dates = dtc)
  highest  = impute_dtc_dt(dtc = dtc, highest_imputation=highest_imputation)
  res = dplyr::mutate(res , highest)
  res
}
wrapper(dtc=dates, "M")
wrapper(dtc=dates, "D")

# 

# 6 -----------------------------------------------------------------------


# 7 -----------------------------------------------------------------------

# 

# 8 -----------------------------------------------------------------------


