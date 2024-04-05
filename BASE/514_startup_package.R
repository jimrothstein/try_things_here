library(startup)
library(data.table)

?startup

current_script()
# [1] NA
#
#
-------------------------------------------
opts  <- startup::startup_session_options()
opts
# $startup.session.startdir
# [1] "/home/jim/code/try_things_here/BASE"
# 
# $startup.session.starttime
# [1] "2023-02-20 20:08:55 PST"
# 
# $startup.session.starttime_iso
# [1] "20230220-200855"
# 
# $startup.session.id
# [1] "Rtmp3BIHX1"
# 
# $startup.session.dumpto
# [1] "/home/jim/code/try_things_here/BASE/last.dump_20230220-200855_Rtmp3BIHX1"
# 
#
#

-------------------------------------------
(info  <- startup::sysinfo())

length(info)   #

info[["os"]]
# [1] "unix"

info[["release"]]
# [1] "4.16.18-galliumos"
#
#
# SAME
info[c(1,2,3)]
info[c("sysname", "release", "version")]
# $sysname
# [1] "Linux"
# 
# $release
# [1] "4.16.18-galliumos"
# 
# $version
# [1] "#1 SMP PREEMPT Sun Jun 23 04:14:45 UTC 2019"
# 


-------------------------------------------
ch  <- startup::check(fix=F)
ch

-------------------------------------------
e  <- Sys.getenv()
e  <- Sys.getenv(names=T)
e[1:3]

names(e)
str(e)
unname(e) |> str()

dt  <- data.table(name = names(e), value=unname(e))
dt$name
dt$value
dt[10:13]


dt[grep("^R_S", name) ]
dt[grep("^R_STARTUP", name) ]


-------------------------------------------
##  WORKS!
startup::restart()
