# admiral
jim
2023-12-20

# dverse - simple example

``` r
library(dverse)
library(admiral)


# universe ----------------------------------------------------------------

universe <- c("admiral")
head(document_universe(universe), n=3)   # 186 x 7
```

    # A tibble: 3 × 7
      topic           alias                    title   concept type  keyword package
      <chr>           <chr>                    <chr>   <chr>   <chr> <chr>   <chr>  
    1 %>%             %>%                      Pipe o… reexpo… help  <NA>    admiral
    2 admiral-package admiral, admiral-package admira… intern… help  intern… admiral
    3 admiral_adlb    admiral_adlb             Lab An… datase… help  datase… admiral

``` r
# manual ------------------------------------------------------------------

manual <- "https://pharmaverse.github.io/{package}/reference/{topic}.html"
head(document_universe(universe, url_template = manual), n=3)
```

    # A tibble: 3 × 7
      topic                                alias title concept type  keyword package
      <chr>                                <chr> <chr> <chr>   <chr> <chr>   <chr>  
    1 <a href=https://pharmaverse.github.… %>%   Pipe… reexpo… help  <NA>    admiral
    2 <a href=https://pharmaverse.github.… admi… admi… intern… help  intern… admiral
    3 <a href=https://pharmaverse.github.… admi… Lab … datase… help  datase… admiral

Both manual and vignettes (see:
https://quarto.org/docs/authoring/article-layout.html )

``` r
# vignette ----------------------------------------------------------------
# Adding an explicit template for vignettes
vignettes = "https://pharmaverse.github.io/{package}/articles/{topic}.html"
docs <- document_universe(universe, url_template = c(manual, vignettes))
knitr::kable(docs)
```

| topic | alias | title | concept | type | keyword | package |
|:---|:---|:---|:---|:---|:---|:---|
| <a href=https://pharmaverse.github.io/admiral/reference/%>%.html\>%\>%</a> | %\>% | Pipe operator | reexport | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/admiral-package.html>admiral-package</a> | admiral, admiral-package | admiral: ADaM in R Asset Library | internal | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/admiral_adlb.html>admiral_adlb</a> | admiral_adlb | Lab Analysis Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/admiral_adlb.html>admiral_adlb</a> | admiral_adlb | Lab Analysis Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/admiral_adsl.html>admiral_adsl</a> | admiral_adsl | Subject Level Analysis Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/admiral_adsl.html>admiral_adsl</a> | admiral_adsl | Subject Level Analysis Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/adsl.html>adsl</a> | adsl | Creating ADSL | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/assert_parameters_argument.html>assert_parameters_argument</a> | assert_parameters_argument | Asserts ‘parameters’ Argument and Converts to List of Expressions | NA | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/atoxgr_criteria_ctcv4.html>atoxgr_criteria_ctcv4</a> | atoxgr_criteria_ctcv4 | Metadata Holding Grading Criteria for NCI-CTCAEv4 | metadata | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/atoxgr_criteria_ctcv5.html>atoxgr_criteria_ctcv5</a> | atoxgr_criteria_ctcv5 | Metadata Holding Grading Criteria for NCI-CTCAEv5 | metadata | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/atoxgr_criteria_daids.html>atoxgr_criteria_daids</a> | atoxgr_criteria_daids | Metadata Holding Grading Criteria for DAIDs | metadata | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/basket_select.html>basket_select</a> | basket_select | Create a ‘basket_select’ object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/bds_exposure.html>bds_exposure</a> | bds_exposure | Creating a BDS Exposure ADaM | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/bds_finding.html>bds_finding</a> | bds_finding | Creating a BDS Finding ADaM | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/bds_tte.html>bds_tte</a> | bds_tte | Creating a BDS Time-to-Event ADaM | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/call_derivation.html>call_derivation</a> | call_derivation | Call a Single Derivation Multiple Times | high_order_function | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/call_user_fun.html>call_user_fun</a> | call_user_fun | Calls a Function Provided by the User | utils_help | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/censor_source.html>censor_source</a> | censor_source | Create a ‘censor_source’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/chr2vars.html>chr2vars</a> | chr2vars | Turn a Character Vector into a List of Expressions | utils_quo | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_age_years.html>compute_age_years</a> | compute_age_years | Compute Age in Years | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_bmi.html>compute_bmi</a> | compute_bmi | Compute Body Mass Index (BMI) | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_bsa.html>compute_bsa</a> | compute_bsa | Compute Body Surface Area (BSA) | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_dtf.html>compute_dtf</a> | compute_dtf | Derive the Date Imputation Flag | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_duration.html>compute_duration</a> | compute_duration | Compute Duration | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_egfr.html>compute_egfr</a> | compute_egfr | Compute Estimated Glomerular Filtration Rate (eGFR) for Kidney Function | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_framingham.html>compute_framingham</a> | compute_framingham | Compute Framingham Heart Study Cardiovascular Disease 10-Year Risk Score | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_map.html>compute_map</a> | compute_map | Compute Mean Arterial Pressure (MAP) | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_qtc.html>compute_qtc</a> | compute_qtc | Compute Corrected QT | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_qual_imputation.html>compute_qual_imputation</a> | compute_qual_imputation | Function to Impute Values When Qualifier Exists in Character Result | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_qual_imputation_dec.html>compute_qual_imputation_dec</a> | compute_qual_imputation_dec | Compute Factor for Value Imputations When Character Value Contains \< or \> | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_rr.html>compute_rr</a> | compute_rr | Compute RR Interval From Heart Rate | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_scale.html>compute_scale</a> | compute_scale | Compute Scale Parameters | com_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/compute_tmf.html>compute_tmf</a> | compute_tmf | Derive the Time Imputation Flag | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/concepts_conventions.html>concepts_conventions</a> | concepts_conventions | Programming Concepts and Conventions | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/consolidate_metadata.html>consolidate_metadata</a> | consolidate_metadata | Consolidate Multiple Meta Datasets Into a Single One | create_aux | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/convert_blanks_to_na.html>convert_blanks_to_na</a> | convert_blanks_to_na | Convert Blank Strings Into NAs | utils_fmt | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/convert_date_to_dtm.html>convert_date_to_dtm</a> | convert_date_to_dtm | Convert a Date into a Datetime Object | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/convert_dtc_to_dt.html>convert_dtc_to_dt</a> | convert_dtc_to_dt | Convert a Date Character Vector into a Date Object | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/convert_dtc_to_dtm.html>convert_dtc_to_dtm</a> | convert_dtc_to_dtm | Convert a Date Character Vector into a Datetime Object | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/convert_na_to_blanks.html>convert_na_to_blanks</a> | convert_na_to_blanks | Convert NAs Into Blank Strings | utils_fmt | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/count_vals.html>count_vals</a> | count_vals | Count Number of Observations Where a Variable Equals a Value | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/country_code_lookup.html>country_code_lookup</a> | country_code_lookup | Country Code Lookup | metadata | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/create_period_dataset.html>create_period_dataset</a> | create_period_dataset | Create a Reference Dataset for Subperiods, Periods, or Phases | create_aux | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/create_query_data.html>create_query_data</a> | create_query_data | Creates a queries dataset as input dataset to the ‘dataset_queries’ argument in ‘derive_vars_query()’ | create_aux | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/create_single_dose_dataset.html>create_single_dose_dataset</a> | create_single_dose_dataset | Create dataset of single doses | create_aux | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/date_source.html>date_source</a> | date_source | Create a ‘date_source’ object | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/death_event.html>death_event</a> | death_event, lastalive_censor, ae_event, ae_ser_event, ae_gr1_event, ae_gr2_event, ae_gr3_event, ae_gr4_event, ae_gr5_event, ae_gr35_event, ae_sev_event, ae_wd_event | Pre-Defined Time-to-Event Source Objects | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/default_qtc_paramcd.html>default_qtc_paramcd</a> | default_qtc_paramcd | Get Default Parameter Code for Corrected QT | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derivation_slice.html>derivation_slice</a> | derivation_slice | Create a ‘derivation_slice’ Object | high_order_function | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_basetype_records.html>derive_basetype_records</a> | derive_basetype_records | Derive Basetype Variable | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_expected_records.html>derive_expected_records</a> | derive_expected_records | Derive Expected Records | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_extreme_event.html>derive_extreme_event</a> | derive_extreme_event | Add the Worst or Best Observation for Each By Group as New Records | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_extreme_records.html>derive_extreme_records</a> | derive_extreme_records | Add the First or Last Observation for Each By Group as New Records | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_locf_records.html>derive_locf_records</a> | derive_locf_records | Derive LOCF (Last Observation Carried Forward) Records | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_bmi.html>derive_param_bmi</a> | derive_param_bmi | Adds a Parameter for BMI | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_bsa.html>derive_param_bsa</a> | derive_param_bsa | Adds a Parameter for BSA (Body Surface Area) Using the Specified Method | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_computed.html>derive_param_computed</a> | derive_param_computed | Adds a Parameter Computed from the Analysis Value of Other Parameters | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_doseint.html>derive_param_doseint</a> | derive_param_doseint | Adds a Parameter for Dose Intensity | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_exist_flag.html>derive_param_exist_flag</a> | derive_param_exist_flag | Add an Existence Flag Parameter | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_exposure.html>derive_param_exposure</a> | derive_param_exposure | Add an Aggregated Parameter and Derive the Associated Start and End Dates | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_extreme_record.html>derive_param_extreme_record</a> | derive_param_extreme_record | Adds a Parameter Based on First or Last Record from Multiple Sources | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_framingham.html>derive_param_framingham</a> | derive_param_framingham | Adds a Parameter for Framingham Heart Study Cardiovascular Disease 10-Year Risk Score | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_map.html>derive_param_map</a> | derive_param_map | Adds a Parameter for Mean Arterial Pressure | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_qtc.html>derive_param_qtc</a> | derive_param_qtc | Adds a Parameter for Corrected QT (an ECG measurement) | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_rr.html>derive_param_rr</a> | derive_param_rr | Adds a Parameter for Derived RR (an ECG measurement) | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_tte.html>derive_param_tte</a> | derive_param_tte | Derive a Time-to-Event Parameter | der_prm_tte | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_param_wbc_abs.html>derive_param_wbc_abs</a> | derive_param_wbc_abs | Add a parameter for lab differentials converted to absolute values | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_summary_records.html>derive_summary_records</a> | derive_summary_records | Add New Records Within By Groups Using Aggregation Functions | der_prm_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_age_years.html>derive_var_age_years</a> | derive_var_age_years | Derive Age in Years | der_adsl | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_analysis_ratio.html>derive_var_analysis_ratio</a> | derive_var_analysis_ratio | Derive Ratio Variable | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_anrind.html>derive_var_anrind</a> | derive_var_anrind | Derive Reference Range Indicator | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_atoxgr.html>derive_var_atoxgr</a> | derive_var_atoxgr | Derive Lab High toxicity Grade 0 - 4 and Low Toxicity Grades 0 - (-4) | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_atoxgr_dir.html>derive_var_atoxgr_dir</a> | derive_var_atoxgr_dir | Derive Lab Toxicity Grade 0 - 4 | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_base.html>derive_var_base</a> | derive_var_base | Derive Baseline Variables | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_chg.html>derive_var_chg</a> | derive_var_chg | Derive Change from Baseline | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_dthcaus.html>derive_var_dthcaus</a> | derive_var_dthcaus | Derive Death Cause | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_extreme_dt.html>derive_var_extreme_dt</a> | derive_var_extreme_dt | Derive First or Last Date from Multiple Sources | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_extreme_dtm.html>derive_var_extreme_dtm</a> | derive_var_extreme_dtm | Derive First or Last Datetime from Multiple Sources | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_extreme_flag.html>derive_var_extreme_flag</a> | derive_var_extreme_flag | Add a Variable Flagging the First or Last Observation Within Each By Group | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_joined_exist_flag.html>derive_var_joined_exist_flag</a> | derive_var_joined_exist_flag | Derives a Flag Based on an Existing Flag | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_merged_ef_msrc.html>derive_var_merged_ef_msrc</a> | derive_var_merged_ef_msrc | Merge an Existence Flag From Multiple Sources | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_merged_exist_flag.html>derive_var_merged_exist_flag</a> | derive_var_merged_exist_flag | Merge an Existence Flag | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_merged_summary.html>derive_var_merged_summary</a> | derive_var_merged_summary | Merge Summary Variables | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_obs_number.html>derive_var_obs_number</a> | derive_var_obs_number | Adds a Variable Numbering the Observations Within Each By Group | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_ontrtfl.html>derive_var_ontrtfl</a> | derive_var_ontrtfl | Derive On-Treatment Flag Variable | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_pchg.html>derive_var_pchg</a> | derive_var_pchg | Derive Percent Change from Baseline | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_relative_flag.html>derive_var_relative_flag</a> | derive_var_relative_flag | Flag Observations Before or After a Condition is Fulfilled | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_shift.html>derive_var_shift</a> | derive_var_shift | Derive Shift | der_bds_findings | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_trtdurd.html>derive_var_trtdurd</a> | derive_var_trtdurd | Derive Total Treatment Duration (Days) | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_trtdurd.html>derive_var_trtdurd</a> | derive_var_trtdurd | Derive Total Treatment Duration (Days) | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_var_trtemfl.html>derive_var_trtemfl</a> | derive_var_trtemfl | Derive Treatment-emergent Flag | der_occds | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_aage.html>derive_vars_aage</a> | derive_vars_aage | Derive Analysis Age | der_adsl | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_atc.html>derive_vars_atc</a> | derive_vars_atc | Derive ATC Class Variables | der_occds | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_computed.html>derive_vars_computed</a> | derive_vars_computed | Adds Variable(s) Computed from the Analysis Value of one or more Parameters | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dt.html>derive_vars_dt</a> | derive_vars_dt | Derive/Impute a Date from a Date Character Vector | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dt.html>derive_vars_dt</a> | derive_vars_dt | Derive/Impute a Date from a Date Character Vector | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm.html>derive_vars_dtm</a> | derive_vars_dtm | Derive/Impute a Datetime from a Date Character Vector | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm.html>derive_vars_dtm</a> | derive_vars_dtm | Derive/Impute a Datetime from a Date Character Vector | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm_to_dt.html>derive_vars_dtm_to_dt</a> | derive_vars_dtm_to_dt | Derive Date Variables from Datetime Variables | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm_to_dt.html>derive_vars_dtm_to_dt</a> | derive_vars_dtm_to_dt | Derive Date Variables from Datetime Variables | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm_to_tm.html>derive_vars_dtm_to_tm</a> | derive_vars_dtm_to_tm | Derive Time Variables from Datetime Variables | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dtm_to_tm.html>derive_vars_dtm_to_tm</a> | derive_vars_dtm_to_tm | Derive Time Variables from Datetime Variables | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_duration.html>derive_vars_duration</a> | derive_vars_duration | Derive Duration | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_duration.html>derive_vars_duration</a> | derive_vars_duration | Derive Duration | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dy.html>derive_vars_dy</a> | derive_vars_dy | Derive Relative Day Variables | der_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_dy.html>derive_vars_dy</a> | derive_vars_dy | Derive Relative Day Variables | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_extreme_event.html>derive_vars_extreme_event</a> | derive_vars_extreme_event | Add the Worst or Best Observation for Each By Group as New Variables | der_adsl | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_joined.html>derive_vars_joined</a> | derive_vars_joined | Add Variables from an Additional Dataset Based on Conditions from Both Datasets | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_merged.html>derive_vars_merged</a> | derive_vars_merged | Add New Variable(s) to the Input Dataset Based on Variables from Another Dataset | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_merged_lookup.html>derive_vars_merged_lookup</a> | derive_vars_merged_lookup | Merge Lookup Table with Source Dataset | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_period.html>derive_vars_period</a> | derive_vars_period | Add Subperiod, Period, or Phase Variables to ADSL | der_adsl | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_query.html>derive_vars_query</a> | derive_vars_query | Derive Query Variables | der_occds | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/derive_vars_transposed.html>derive_vars_transposed</a> | derive_vars_transposed | Derive Variables by Transposing and Merging a Second Dataset | der_gen | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/desc.html>desc</a> | desc | dplyr desc | reexport | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/dose_freq_lookup.html>dose_freq_lookup</a> | dose_freq_lookup | Pre-Defined Dose Frequencies | metadata | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/dt_level.html>dt_level</a> | dt_level | Create a ‘dt_level’ object | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/dthcaus_source.html>dthcaus_source</a> | dthcaus_source | Create a ‘dthcaus_source’ Object | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/dtm_level.html>dtm_level</a> | dtm_level | Create a ‘dtm_level’ object | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/event.html>event</a> | event | Create a ‘event’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/event_joined.html>event_joined</a> | event_joined | Create a ‘event_joined’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/event_source.html>event_source</a> | event_source | Create an ‘event_source’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/ex_single.html>ex_single</a> | ex_single | Single Dose Exposure Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/ex_single.html>ex_single</a> | ex_single | Single Dose Exposure Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/example_qs.html>example_qs</a> | example_qs | Example ‘QS’ Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/example_qs.html>example_qs</a> | example_qs | Example ‘QS’ Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/exprs.html>exprs</a> | exprs | rlang exprs | reexport | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/extract_duplicate_records.html>extract_duplicate_records</a> | extract_duplicate_records | Extract Duplicate Records | internal | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/extract_unit.html>extract_unit</a> | extract_unit | Extract Unit From Parameter Description | utils_help | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/filter_exist.html>filter_exist</a> | filter_exist | Returns records that fit into existing by groups in a filtered source dataset | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/filter_extreme.html>filter_extreme</a> | filter_extreme | Filter the First or Last Observation for Each By Group | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/filter_joined.html>filter_joined</a> | filter_joined | Filter Observations Taking Other Observations into Account | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/filter_not_exist.html>filter_not_exist</a> | filter_not_exist | Returns records that don’t fit into existing by groups in a filtered source dataset | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/filter_relative.html>filter_relative</a> | filter_relative | Filter the Observations Before or After a Condition is Fulfilled | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/flag_event.html>flag_event</a> | flag_event | Create a ‘flag_event’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/format.basket_select.html>format.basket_select</a> | format | Returns a Character Representation of a ‘basket_select()’ Object | internal | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/generic.html>generic</a> | generic | Generic Derivations | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_admiral_option.html>get_admiral_option</a> | get_admiral_option | Get the Value of an Admiral Option | admiral_options | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_duplicates_dataset.html>get_duplicates_dataset</a> | get_duplicates_dataset | Get Duplicate Records that Led to a Prior Error | utils_ds_chk | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_flagged_records.html>get_flagged_records</a> | get_flagged_records | Create an Existence Flag | utils_help | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_hori_data.html>get_hori_data</a> | get_hori_data | Creating Temporary Parameters and <variable>.<parameter> Variables | NA | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_imputation_target_date.html>get_imputation_target_date</a> | get_imputation_target_date | Get Date Imputation Targets | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_imputation_target_time.html>get_imputation_target_time</a> | get_imputation_target_time | Get Time Imputation Targets | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_joined_data.html>get_joined_data</a> | get_joined_data | Join Data for “joined” functions | NA | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_many_to_one_dataset.html>get_many_to_one_dataset</a> | get_many_to_one_dataset | Get Many to One Values that Led to a Prior Error | utils_ds_chk | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_not_mapped.html>get_not_mapped</a> | get_not_mapped | Get list of records not mapped from the lookup table. | utils_help | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_one_to_many_dataset.html>get_one_to_many_dataset</a> | get_one_to_many_dataset | Get One to Many Values that Led to a Prior Error | utils_ds_chk | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_partialdatetime.html>get_partialdatetime</a> | get_partialdatetime | Parse DTC variable and Determine Components | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_summary_records.html>get_summary_records</a> | get_summary_records | Create Summary Records | superseded | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_terms_from_db.html>get_terms_from_db</a> | get_terms_from_db | Get Terms from the Queries Database | der_occds | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/get_vars_query.html>get_vars_query</a> | get_vars_query | Get Query Variables | utils_help | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/higher_order.html>higher_order</a> | higher_order | Higher Order Functions | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/hys_law.html>hys_law</a> | hys_law | Hy’s Law Implementation | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/imputation.html>imputation</a> | imputation | Date and Time Imputation | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/impute_dtc_dt.html>impute_dtc_dt</a> | impute_dtc_dt | Impute Partial Date Portion of a “–DTC” Variable | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/impute_dtc_dtm.html>impute_dtc_dtm</a> | impute_dtc_dtm | Impute Partial Date(-time) Portion of a “–DTC” Variable | com_date_time | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/lab_grading.html>lab_grading</a> | lab_grading | Lab Grading | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/list_all_templates.html>list_all_templates</a> | list_all_templates | List All Available ADaM Templates | utils_examples | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/list_tte_source_objects.html>list_tte_source_objects</a> | list_tte_source_objects | List all ‘tte_source’ Objects Available in a Package | other_advanced | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/max_cond.html>max_cond</a> | max_cond | Maximum Value on a Subset | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/min_cond.html>min_cond</a> | min_cond | Minimum Value on a Subset | utils_fil | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/negate_vars.html>negate_vars</a> | negate_vars | Negate List of Variables | utils_quo | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/occds.html>occds</a> | occds | Creating an OCCDS ADaM | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/params.html>params</a> | params | Create a Set of Parameters | other_advanced | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/pk_adnca.html>pk_adnca</a> | pk_adnca | Creating a PK NCA or Population PK ADaM | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/print.adam_templates.html>print.adam_templates</a> | print | Print ‘adam_templates’ Objects | utils_print | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/print.duplicates.html>print.duplicates</a> | print | Print ‘duplicates’ Objects | utils_print | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/print.source.html>print.source</a> | print | Print ‘source’ Objects | utils_print | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/print_named_list.html>print_named_list</a> | print_named_list | Print Named List | utils_print | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/queries.html>queries</a> | queries | Queries Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/queries.html>queries</a> | queries | Queries Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/queries_dataset.html>queries_dataset</a> | queries_dataset | Queries Dataset Documentation | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/queries_mh.html>queries_mh</a> | queries_mh | Queries MH Dataset | datasets | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/queries_mh.html>queries_mh</a> | queries_mh | Queries MH Dataset | Datasets available by data() | help | datasets | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/query.html>query</a> | query | Create an ‘query’ object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/questionnaires.html>questionnaires</a> | questionnaires | Creating Questionnaire ADaMs | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/records_source.html>records_source</a> | records_source | Create a ‘records_source’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/restrict_derivation.html>restrict_derivation</a> | restrict_derivation | Execute a Derivation on a Subset of the Input Dataset | high_order_function | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/restrict_imputed_dtc_dt.html>restrict_imputed_dtc_dt</a> | restrict_imputed_dtc_dt | Restrict Imputed DTC date to Minimum/Maximum Dates | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/restrict_imputed_dtc_dtm.html>restrict_imputed_dtc_dtm</a> | restrict_imputed_dtc_dtm | Restrict Imputed DTC date to Minimum/Maximum Dates | utils_impute | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/set_admiral_options.html>set_admiral_options</a> | set_admiral_options | Set the Value of Admiral Options | admiral_options | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/signal_duplicate_records.html>signal_duplicate_records</a> | signal_duplicate_records | Signal Duplicate Records | internal | help | internal | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/slice_derivation.html>slice_derivation</a> | slice_derivation | Execute a Derivation with Different Arguments for Subsets of the Input Dataset | high_order_function | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/tte_source.html>tte_source</a> | tte_source | Create a ‘tte_source’ Object | source_specifications | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/use_ad_template.html>use_ad_template</a> | use_ad_template | Open an ADaM Template Script | utils_examples | help | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/articles/visits_periods.html>visits_periods</a> | visits_periods | Visit and Period Variables | NA | vignette | NA | admiral |
| <a href=https://pharmaverse.github.io/admiral/reference/yn_to_numeric.html>yn_to_numeric</a> | yn_to_numeric | Map ‘“Y”’ and ‘“N”’ to Numeric Values | utils_fmt | help | NA | admiral |
