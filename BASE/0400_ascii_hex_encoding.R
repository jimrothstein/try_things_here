library(data.table)

dec  <- c(32:165)
hex  <- as.raw(dec)
ascii  <- rawToChar(as.raw(dec), multiple=T)
ascii


dt  <- data.table( 
	dec,
	ascii,
	hex)
dt
									
		

head(dt, n=100L)

 charToRaw("HELLO")
# 97 = "a" (dec)
as.raw(97)  #61 in hex 


rawToChar(as.raw(97))   #a
