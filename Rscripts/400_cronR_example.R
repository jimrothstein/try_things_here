library(cronR)
cron_ls()
# f   <- system.file(package = "cronR", "extdata", "helloworld.R") f
#  f   <- system.file(package = "cronR", "extdata", "0200_simple_rscript.R")





# rescript must be an rscript or R file
cmd <- cron_rscript(
  rscript = "0200_simple_rscript.R",
  cmd = normalizePath("."),
  rscript_log = "cron_log.log",
  log_timestamp = F,
  workdir = normalizePath(".")
)
cmd
# command must be type cmd, not just string
cron_add(
  command = cmd, frequency = "minutely",
  id = "test1", description = "My process 1",
  tags = c("lab", "xyz"),
  ask = F,
  user = "jim"
)

# cron_add(command = cmd, frequency = 'daily', at='7AM', id = 'test2')

cron_njobs()
cron_ls()
cron_clear(ask = F)


cron_ls()
cmd <- cron_rscript(f, rscript_args = c("productx", "arg2", "123"))
cmd
cron_add(cmd, frequency = "minutely", id = "job1", description = "Customers")
cron_add(cmd, frequency = "hourly", id = "job2", description = "Weather")
