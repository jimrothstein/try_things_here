## pivot wider
## EXAMPLE from `admiral` package, but should be self-contained

   library(dplyr)
   library(tibble)
   library(tidyr)

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

## simplest possible !

## will need these
by_vars = exprs(USUBJID, CMREFID = FAREFID)
id_vars = exprs(FAGRPID)

# for uniqueness
(id_cols = c(as.character(by_vars), as.character(id_vars)))

wide = tidyr::pivot_wider(data = facm,
                   names_from = FATESTCD, ,
                   values_from = FASTRESC,
                   id_cols =c("USUBJID", "FAREFID", "FAGRPID"))

wide

# check
wide |> group_by(USUBJID) |> count()
wide |> group_by(USUBJID, FAREFID) |> count()
wide |> group_by(USUBJID, FAREFID, FAGRPID) |> count()
cm



# join
dplyr::left_join(x = cm,
                 y = wide1,
                 by = join_by(USUBJID, CMREFID ==  FAREFID),
                 relationship = "one-to-one"
                 )

## add duplicate row to wide
dup = tibble(
       USUBJID = "BP40257-1001",
       FAREFID = "1192056",
       FAGRPID = "1"
       )
wide1 = bind_rows(wide, dup)
wide1
#####
   ###

data_transposed = function(
    dataset_merge,
    key_var,
    value_var
    ) {
  dataset_merge %>%
    pivot_wider(
      names_from = !!key_var,
      values_from = !!value_var,
      #id_cols = c(as.character(by_vars), as.character(id_vars))
    )
}

# the call
dataset_merge_wider = data_transposed(
  dataset_merge = facm,
#  by_vars = exprs(USUBJID, CMREFID = FAREFID),
#  id_vars = exprs(FAGRPID),
  key_var = expr(FATESTCD),
  value_var = expr(FASTRESC)
)

## result
dataset_merge_wider
dataset_merge_wider |> names()

# USUBJID,
names(cm) %in% names(dataset_merge_wider)
dataset_merge_wider |> select(USUBJID, CMDECOD, starts_with("CMATC"))


## save ??
if (F) dput(dataset_merge_wider)

#' cm %>%
#'   derive_vars_transposed(
#'     facm,
#'     by_vars = exprs(USUBJID, CMREFID = FAREFID),
#'     id_vars = exprs(FAGRPID),
#'     key_var = FATESTCD,
#'     value_var = FASTRESC
#'   ) %>%
#'   select(USUBJID, CMDECOD, starts_with("CMATC"))

by = join_by(STUDYID, CMREFID == FAREFID)

left_join(x = cm,
          y = dataset_merge_wider,
          by = by
          )
J =  capture.output(mtcars)
