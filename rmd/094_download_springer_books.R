
devtools::install_github()
devtools::install_github("renanxcortes/springerQuarantineBooksR", 
force= TRUE)

#  save packages!
ip  <- installed.packages()
ip  #358
ip[0,]
head(ip[,1])

saveRDS(ip, file="R_installed_packages")
