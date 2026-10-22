# 131_modular_arithmetic_validation.return
# GOAL:	  Given 10^7 numbers and a criteria to generate a control digit, what is distribution of the control digit?   find a criteria that restricts possible control digit

for 7 digits (7th control) it comes like this:
all proper - 10^6
all possible - 10^7
all posible with 4 - 10^6
all posible with 4 - 10^5

library(tidyverse)

#	need 6 coef
coef  <- c(2,2,2,2,2,2)  
coef  <- c(3,3,3,3,3,3)  
coef  <- c(5,5,5,5,5,5)  

if (length(coef) != 6) cli::cli_alert_danger("number of coef must be 6, not {length(coef)}")

# ------------------
#	Original problem
# ------------------
b = expand.grid(rep(list(0:9), 7)) %>%
 tibble::as_tibble() 
 b
head(b)
 mutate(aa = (Var1 *7 + Var2 * 6 + Var3 * 5  + Var4 * 4 + Var5 *3 + Var6*2) %% 10) 
table(b$aa)


# ---------
# Modify:
# ---------
#  choose an algorithm
test  <- function(tbl, coef) tbl |> mutate(aa=(Var1*coef[1] + 
					       Var2*coef[2] + 
					       Var3*coef[3] +
					       Var4*coef[4] + 
					       Var5*coef[5] +
					       Var6*coef[6]) %% 10)

# generate 
result = test(b, coef)
result

table(result$aa)
res2  <- result |> dplyr::filter(Var7 == aa) 

# display valid numbers, if control digit = 
control = 5
res2 |> dplyr::filter(Var7 == control)
table(res2$aa)

# all possible, 10^7
b1 = expand.grid(rep(list(0:9), 7)) |> tibble::as_tibble()


criteria  <- function(tbl)  tbl |> mutate(aa = (Var1 * 4) %% 10)
b2  <- b1  |> criteria()

b2  <- b1 |> mutate(aa=(Var1 *7 + Var2 * 6 + Var3 * 5  + Var4 * 4 + Var5 *3 + Var6*2) %% 10)
table(b2$Var7)
table(b2$aa)

b2 |> dplyr::filter(Var7 == aa)



# slow
b2  <-  b1 |> tidyr::unite("IMO", 1:7, sep = "") # paste multiple columns together
head(b2)
tail(b2)
b2

 
 
# all with 4 at the end
b2 = expand.grid(rep(list(0:9), 7)) %>%
 filter(Var7 == 4)%>%
 unite("IMO", 1:7, sep = "")

# all proper with 4 at the end
b3 = b %>%
 filter(aa == 4)
