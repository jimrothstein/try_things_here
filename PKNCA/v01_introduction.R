library(PKNCA)

?vignette

# list all, plus link
browseVignettes("PKNCA")

# COPIED


## Load the PK concentration data (each subject: dose, time => conc )
class(d_conc) # [1] "nfnGroupedData" "nfGroupedData"  "groupedData"    "data.frame"

d_conc <- datasets::Theoph

## Generate the dosing data
d_dose <- d_conc[d_conc$Time == 0, ]

#   (adds columns:  exclude, volume, duration)
## Create a concentration object specifying the concentration, time, and
## subject columns.  (Note that any number of grouping levels is
## supported; you are not restricted to just grouping by subject.)
conc_obj <-
  PKNCAconc(
    d_conc,
    conc ~ Time | Subject
  )
## Create a dosing object specifying the dose, time, and subject
## columns.  (Note that the grouping factors should be the same as or a
## subset of the grouping factors for concentration, and the grouping
## columns must have the same names between concentration and dose
## objects.)
dose_obj <-
  PKNCAdose(
    d_dose,
    Dose ~ Time | Subject
  )
## (list of lists:   data, formula, columns
## Combine the concentration and dosing information both to
## automatically define the intervals for NCA calculation and provide
## doses for calculations requiring dose.
data_obj <- PKNCAdata(conc_obj, dose_obj)

## (list of 3 lists result, data, columns)
## Calculate the NCA parameters
results_obj <- pk.nca(data_obj)

## cmax, tmax, half.life....
## Summarize the results
summary(results_obj)
