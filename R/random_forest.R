# install packages
install.packages("RCurl")
install.packages("data.table")
install.packages("mlr")
install.packages("h2o")

# download training and test data
URL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
x <- getURL(URL)
out <- read.csv(textConnection(x))
head(out)
dim(out)
download.file(URL,destfile="/Users/kalvinhuang/Documents/adults",method="curl")

URL_test <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test"
download.file(URL_test,destfile="/Users/kalvinhuang/Documents/adults.test",method="curl")

#----- dont need to run everytime/one time setup (above) ------

# load libraries
library(RCurl)
library(data.table)
library(mlr)
library(h2o)

#set variable names
setcol <- c("age",
            "workclass",
            "fnlwgt",
            "education",
            "education-num",
            "marital-status",
            "occupation",
            "relationship",
            "race",
            "sex",
            "capital-gain",
            "capital-loss",
            "hours-per-week",
            "native-country",
            "target")

# load data
train <- read.table("Documents/machine_learning/data/adult.data",
                    header = F, sep = ",", col.names = setcol,
                    na.strings = c(" ?"),stringsAsFactors = F)

test <- read.table("Documents/machine_learning/data/adult.test",
                   header = F, sep = ",", col.names = setcol,
                   skip = 1, na.strings = c(" ?"), stringsAsFactors = F)

# set data class to data.table for faster data manipulation
setDT(train)
setDT(test)

dim(train)  # 32,561 rows and 15 columns
dim(test)   # 16,281 rows and 15 columns
# take a quick peak at the 2 datasets
str(train)
str(test)

# check missing values
table(is.na(train))
table(is.na(test))

# column computation to return the percentage of missing values per column
sapply(train, function(x) sum(is.na(x))/length(x)) * 100
sapply(test, function(x) sum(is.na(x))/length(x)) * 100

library(mlr)

setDF(train)
setDF(test)
# impute the missing values using median / mode imputation
imp1 = impute(obj = train, target = "target",
              classes = list(integer = imputeMedian(), factor = imputeMode()))
imp2 <- impute(obj = test,target = "target",
               classes = list(integer = imputeMedian(), factor = imputeMode()))
train <- imp1$data
test <- imp2$data
