library(syntheticadam)
library(digest)

# copy config_workflow file in the root folder
file.copy("inst/config_workflow.yml", "./")

ignore_checksum <- c("ad_adlb_param_tab.R") # templates where we do not compare checksums

# read folder from config_workflow.yml file and create folders
current_script_directory <- getwd()

config <- yaml::read_yaml("./config_workflow.yml")
esub_path <- config[["paths"]][["adam"]][["esub"]]

adam_path <- config[["paths"]][["adam"]][["data"]]
adam_path_parquet_expected <- gsub("adams", "adams_expected", config[["paths"]][["adam"]][["data"]])
adam_path_parquet_actual <- config[["paths"]][["adam"]][["data"]]
templates_dir <- file.path("inst", "templates")

dir.create(esub_path, showWarnings = FALSE, recursive = TRUE)
dir.create(adam_path, showWarnings = FALSE, recursive = TRUE)
dir.create(adam_path_parquet_actual, showWarnings = FALSE, recursive = TRUE)
dir.create(adam_path_parquet_expected, showWarnings = FALSE, recursive = TRUE)

###################################################
# 1. Retrieve syntheticadam data (expected data)
###################################################

# read all data from syntheticadam package and store them as parquet files on expected data dir
datasets <- data(package = "syntheticadam")
dataset_names <- datasets$results[, "Item"]
for (dataset_name in dataset_names) {
  data_obj <- get(dataset_name, pos = "package:syntheticadam")
  parquet_file <- file.path(adam_path_parquet_expected, paste0(dataset_name, ".parquet"))
  arrow::write_parquet(data_obj, parquet_file)
}

########################################################
# 2. Run snakemake workflow, and retrieve failed rules
########################################################

# clean previous snakemake logs
logs_dir <- "inst/templates/logs/"
unlink(".snakemake", recursive = TRUE)
dir.create(logs_dir, recursive = TRUE)

output <- system2(c("snakemake", "-F", "-j8", "--snakefile", "./inst/Snakefile", "all"), stdout = TRUE, stderr = TRUE)
cat(paste(output, collapse = "\n"))

# Loop over logs files in logs dir - check erors cases
log_files <- list.files(logs_dir, pattern = ".*\\.log$", full.names = TRUE)

# Find the Snakemake log file in .snakemake/log directory
failed_logs_paths <- c()
warnings_logs_paths <- c()
for (log_file in log_files) {
  # retrieve failed rules
  snakemake_log <- readLines(log_file)
  snakemake_log <- paste(snakemake_log, collapse = "\n")
  if (grepl("Execution halted", snakemake_log)) {
    failed_logs_paths <- c(failed_logs_paths, log_file)
  }
  if (grepl("Warning message:", snakemake_log)) {
    warnings_logs_paths <- c(warnings_logs_paths, log_file)
  }
}


if (length(failed_logs_paths) > 0) {
  # exit code 1 will end up with error in the gitlab-ci pipelines
  print("Some templates failed")
  for (log_path in failed_logs_paths) {
    cat(sprintf("\nTemplate %s failed\n", gsub(".log", "", basename(log_path))))
    failed_rule_log <- readLines(log_path)
    cat(paste(failed_rule_log, collapse = "\n"))
  }
  q(status = 1)
}

# check also other potential errors in the snakemake cmd
if (!is.null(attr(output, "status"))) {
  print("Snakemake cmd failed")
  cat(paste(output, collapse = "\n"))
  q(status = 1)
}

#############################################################
# 3. Compare syntheticadam data with actual templates data
#############################################################

# list produced datasets and compare them to syntheticadam data
actual_paths <- list.files(adam_path_parquet_actual, pattern = "*.parquet")
diff_templates <- c()
for (parquet_path in actual_paths) {
  data_actual <- arrow::read_parquet(file.path(adam_path_parquet_actual, parquet_path))
  data_expected <- arrow::read_parquet(file.path(adam_path_parquet_expected, parquet_path))
  output_diff <- diffdf::diffdf(compare = data_actual, base = data_expected)
  if (diffdf::diffdf_has_issues(output_diff)) {
    # display differences in case differences found by diffdf()
    diff_templates <- c(diff_templates, list(list(parquet_path = parquet_path, diff = output_diff)))
  }
}


# exit code 125 will end up with warnings in the gitlab-ci pipelines
if (length(diff_templates) > 0) {
  print("Some templates have differences with syntheticadam package :")
  for (d in diff_templates) {
    print(sprintf("Differences detected for data %s", d$parquet_path))
    print(d$diff)
  }
}

if (length(warnings_logs_paths) > 0) {
  # exit code 1 will end up with error in the gitlab-ci pipelines
  print("Some templates ends-up with warnings")
  for (log_path in warnings_logs_paths) {
    cat(sprintf("\nWarning detected on Template log %s\n", gsub(".log", "", basename(log_path))))
    # warn_rule_log <- readLines(log_path)
    # cat(paste(warn_rule_log, collapse='\n'))
  }
}
