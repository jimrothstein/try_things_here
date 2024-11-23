
\footnotesize{this is footnotesize}



trib  <- function(n){
  if (n==0) {return(0)}
  if (n==1)  {return(1)} 
  if (n==2) {return(1)}
  trib(n-1) + trib(n-2) + trib(n-3)
}

trib(0)
trib(1)
trib(2)
trib(3)
# [1] 2
trib(4)
# [1] 4
trib(5)
# [1] 7


trib(10)


trib(20)

trib(25)
# [1] 1389537
