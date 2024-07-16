#  This is EXAMPLE

library(dplyr)
library(tibble)
library(admiraldev)

advs <- tribble(
  ~STUDYID,  ~USUBJID,      ~PARAMCD, ~PARAMN, ~AVAL, ~AVISITN, ~AVISIT,
  "CDISC01", "01-701-1015", "PULSE",        1,    61,        0, "BASELINE",
  "CDISC01", "01-701-1015", "PULSE",        1,    60,        6, "WEEK 6",
  "CDISC01", "01-701-1015", "DIABP",        2,    51,        0, "BASELINE",
  "CDISC01", "01-701-1015", "DIABP",        2,    50,        2, "WEEK 2",
  "CDISC01", "01-701-1015", "DIABP",        2,    51,        4, "WEEK 4",
  "CDISC01", "01-701-1015", "DIABP",        2,    50,        6, "WEEK 6",
  "CDISC01", "01-701-1015", "SYSBP",        3,   121,        0, "BASELINE",
  "CDISC01", "01-701-1015", "SYSBP",        3,   121,        2, "WEEK 2",
  "CDISC01", "01-701-1015", "SYSBP",        3,   121,        4, "WEEK 4",
  "CDISC01", "01-701-1015", "SYSBP",        3,   121,        6, "WEEK 6",
  "CDISC01", "01-701-1028", "PULSE",        1,    65,        0, "BASELINE",
  "CDISC01", "01-701-1028", "DIABP",        2,    79,        0, "BASELINE",
  "CDISC01", "01-701-1028", "DIABP",        2,    80,        2, "WEEK 2",
  "CDISC01", "01-701-1028", "DIABP",        2,    NA,        4, "WEEK 4",
  "CDISC01", "01-701-1028", "DIABP",        2,    NA,        6, "WEEK 6",
  "CDISC01", "01-701-1028", "SYSBP",        3,   130,        0, "BASELINE",
  "CDISC01", "01-701-1028", "SYSBP",        3,   132,        2, "WEEK 2"
)


# A dataset with all the combinations of PARAMCD, PARAM, AVISIT, AVISITN, ... which are expected.
advs_expected_obsv <- tribble(
  ~PARAMCD, ~AVISITN, ~AVISIT,
  "PULSE",         0, "BASELINE",
  "PULSE",         6, "WEEK 6",
  "DIABP",         0, "BASELINE",
  "DIABP",         2, "WEEK 2",
  "DIABP",         4, "WEEK 4",
  "DIABP",         6, "WEEK 6",
  "SYSBP",         0, "BASELINE",
  "SYSBP",         2, "WEEK 2",
  "SYSBP",         4, "WEEK 4",
  "SYSBP",         6, "WEEK 6"
)

derive_locf_records(
  dataset = advs,
  dataset_ref = advs_expected_obsv,
  by_vars = exprs(STUDYID, USUBJID, PARAMCD),
  order = exprs(AVISITN, AVISIT),
  keep_vars = exprs(PARAMN)
) |>
  dplyr::arrange(DTYPE) |>
  print(n = 30)

# For study purposes, identical formal args as dervice_locf_records
f = function(
  dataset,
  dataset_ref,
  by_vars,
  analysis_var = AVAL,
  order,
  keep_vars = NULL
){
  assert_data_frame(dataset_ref)
  #analysis_var =  assert_symbol(enexpr(analysis_var))
}

# Call, same as in example
z=f(
  dataset = advs,
  dataset_ref = advs_expected_obsv,
  by_vars = exprs(STUDYID, USUBJID, PARAMCD),
  order = exprs(AVISITN, AVISIT),
  keep_vars = exprs(PARARM)
  )
z
