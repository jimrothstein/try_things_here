
   library(tibble)

   cm <- tribble(
     ~STUDYID,  ~USUBJID,       ~CMGRPID, ~CMREFID,  ~CMDECOD,
     "STUDY01", "BP40257-1001", "14",     "1192056", "PARACETAMOL",
     "STUDY01", "BP40257-1001", "18",     "2007001", "SOLUMEDROL",
     "STUDY01", "BP40257-1002", "19",     "2791596", "SPIRONOLACTONE"
   )
   facm <- tribble(
     ~STUDYID,  ~USUBJID,       ~FAGRPID, ~FAREFID,  ~FATESTCD,  ~FASTRESC,
     "STUDY01", "BP40257-1001", "1",      "1192056", "CMATC1CD", "N",
     "STUDY01", "BP40257-1001", "1",      "1192056", "CMATC2CD", "N02",
     "STUDY01", "BP40257-1001", "1",      "1192056", "CMATC3CD", "N02B",
     "STUDY01", "BP40257-1001", "1",      "1192056", "CMATC4CD", "N02BE",
     "STUDY01", "BP40257-1001", "1",      "2007001", "CMATC1CD", "D",
     "STUDY01", "BP40257-1001", "1",      "2007001", "CMATC2CD", "D10",
     "STUDY01", "BP40257-1001", "1",      "2007001", "CMATC3CD", "D10A",
     "STUDY01", "BP40257-1001", "1",      "2007001", "CMATC4CD", "D10AA",
     "STUDY01", "BP40257-1001", "2",      "2007001", "CMATC1CD", "D",
     "STUDY01", "BP40257-1001", "2",      "2007001", "CMATC2CD", "D07",
     "STUDY01", "BP40257-1001", "2",      "2007001", "CMATC3CD", "D07A",
     "STUDY01", "BP40257-1001", "2",      "2007001", "CMATC4CD", "D07AA",
     "STUDY01", "BP40257-1001", "3",      "2007001", "CMATC1CD", "H",
     "STUDY01", "BP40257-1001", "3",      "2007001", "CMATC2CD", "H02",
     "STUDY01", "BP40257-1001", "3",      "2007001", "CMATC3CD", "H02A",
     "STUDY01", "BP40257-1001", "3",      "2007001", "CMATC4CD", "H02AB",
     "STUDY01", "BP40257-1002", "1",      "2791596", "CMATC1CD", "C",
     "STUDY01", "BP40257-1002", "1",      "2791596", "CMATC2CD", "C03",
     "STUDY01", "BP40257-1002", "1",      "2791596", "CMATC3CD", "C03D",
     "STUDY01", "BP40257-1002", "1",      "2791596", "CMATC4CD", "C03DA"
   )

   derive_vars_atc(cm, facm)

library(dplyr)

data_transposed = function(
    dataset_merge,
    #jby_vars,
    #id_vars = NULL,
    key_var,
    value_var
    #filter = NULL,
    #relationship = NULL
    ) {
#browser()
#  key_var = enquote(key_var)
#  value_var = enquote(value_var)
  dataset_merge %>%
#    filter_if(filter) %>%
    pivot_wider(
      names_from = !!key_var,
      values_from = !!value_var,
      #id_cols = c(as.character(by_vars), as.character(id_vars))
    )
}

# the call
data_transposed(
  dataset_merge = facm,
#  by_vars = exprs(USUBJID, CMREFID = FAREFID),
#  id_vars = exprs(FAGRPID),
  key_var = expr(FATESTCD),
  value_var = expr(FASTRESC)

#  filter,
#  relationship = NULL
)
)


)

#' cm %>%
#'   derive_vars_transposed(
#'     facm,
#'     by_vars = exprs(USUBJID, CMREFID = FAREFID),
#'     id_vars = exprs(FAGRPID),
#'     key_var = FATESTCD,
#'     value_var = FASTRESC
#'   ) %>%
#'   select(USUBJID, CMDECOD, starts_with("CMATC"))

