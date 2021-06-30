#100_Grolemund_env.R
# Ch 8 "Hands on R"   - dated but clear


library(tidyverse)

# next line fails
#parenvs(all = TRUE)

# need command to display hierarchy of env (lowest=Globalenv; root=emtpyenv)
parent.env(globalenv())

environment()
env0<-parent.env(globalenv( ))
env0

env1<-parent.env(env0)
env1

env2<-parent.env(env1)
env2

env3<-parent.env(env2)
env3
