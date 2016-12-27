# install packages
install.packages("RCurl")
install.packages("data.table")
install.packages("mlr")
install.packages("h2o")

# load libraries
library(RCurl)
library(data.table)
library(mlr)
library(h2o)

# download training and test data
URL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
x <- getURL(URL)
out <- read.csv(textConnection(x))
head(out)
dim(out)
download.file(URL,destfile="/Users/kalvinhuang/Documents/adults",method="curl")

URL_test <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test"
download.file(URL_test,destfile="/Users/kalvinhuang/Documents/adults.test",method="curl")

