# Simple code examples

# ---- ifelse() ----

x <- ifelse(5 > 3, TRUE, FALSE)
print(x)

x <- ifelse("a" %in% c("a", "b"),
  TRUE, FALSE
)
y <- ifelse("c" %in% c("a", "b"),
  TRUE, FALSE
)
print(x)
print(y)


# ---- save vs saveRDS(preferred)----
#  *.rda is short for .RDATA

x <- 3
save(x, file = "temp.RDATA")

# remove from env
rm(x)
x

# check
system("ls") # dir() also works
dir()

# load object x
x <- 0
load("temp.RDATA")
print(x) # x=3 !

# clean up
system("rm temp.RDATA")
dir()

x <- 4
# best for 1 object
saveRDS(x, file = "t.RDS")

# check
dir()

x <- 0
readRDS("t.RDS")
x # x=4

# cleanup
system("rm t.RDS")
dir()


save.image() # if no name, ".RData"
system("rm .RData")

#  save object, remove from env, then load it back

X = mtcars
# save object X
save(X, file="df.rda") 
dir()

rm(X)
X


# load object X into env
load("df.rda")
X
