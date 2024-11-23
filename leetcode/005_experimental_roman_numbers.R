numbers = c("M" = 1000, "D" =500)
numbers
numbers[["M"]]
numbers["M"]

test = "MCM" # 1900

X=list("M", "C", "M")
Y=c("M", "C", "M")

numbers[[Y[[1]]]]
numbers[[1]]
numbers[[1]]
c(numbers[[1]])


for (i in 1:length(Y)) {
    n=Y[[i]]
    cat(i, " ", n, " ",  Y[[i]], " ", numbers[[Y[[i]]]], "\n")
    }

length(Y)
sapply(
X[[1]]
numbers[[X[[1]]]]
e=1
X[[e]]
numbers[[X[[e]]]]

sapply(1:3, function(e) X[[e]])
sapply(1:3, function(e) numbers[[X[[e]]]])

sapply(1:2, function(e) {
    letter = X[[e]]
    letter
    #numbers[[letter]]}
    }
    )


    numbers[[X[[e]]]])
numbers[X[[1]]]
lapply(X, function(e) e) 
Y=sapply(X, function(e) e) 
Y=unname(sapply(X, function(e) e) )
Y

sapply(1:3, function(e) numbers[Y[[e]]])
Y[[1]]
numbers[[Y[[1]]]]


sapply(Y, \(e) e)
lapply(Y, \(e) e)

sapply(Y, function(e) numbers[[e]])

lapply(X, function(e) numbers[[as.character(e)]])


X=strsplit(test, split="")
X
Y=convert(unlist(X))
Y


convert  <- function(numbers){
     sapply(numbers, function(x) x)}
convert(test)
