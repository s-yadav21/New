# Introduction to the Script ----
# This script will be used to compute two class comparision between set of cell lines. 
# This two class comparision is using discrete test and linear asociation 



## Step 1: Install the required packages ----

#Required packages
install.packages("readxl") # to read the excel file containing the feature set
install.packages("gt") # to convert the test output in a formatted table
install.packages("DT") # to create interactive tables
library(readxl)
library(gt)
library(DT)


# Step 2: Upload the a dummy feature set to create feature matrix and response matrix ----
# This feature set contains gene effect scores for 66 genes across 10 cell lines

feature <- read_excel("C:/Users/groot/Documents/R/Dataset/dummy.xlsx")

# Create feature dataframe from the dummy feature set file
A <- feature[ 2:66, c(2:4)]

# Create response dataframe from the dummy feature set file
y <- feature[ 2:66, c(5:11)]

# Convert these dataframes in matrix

Aa <- matrix(unlist(A), ncol = 7)
yy <- matrix(unlist(y), ncol = 3)


# Step 3: Compute linear association between feature matrix, Aa and response matrix, yy ----
# In order to do this, we need to install cdsr_model package from Broad Institute by their Cancer Data Science Team

install.packages("devtools")
library(devtools)
devtools::install_github("broadinstitute/cdsr_models", force = TRUE)
cdsrmodels::lin_associations(Aa, yy, W=NULL)



# Step 4: To compute discrete test ----
# In order to perform discrete test, we need a binary feature matrix and  a response vector
# Once these matrices are created and assigned rownames, we will compute the test

## Create binary matrix
r<- 10
c<- 3

r1 <- 10
c1 <- 1

rows = c("ANKIB", "AOC1", "AASS", "ALS2", "ABCA7", "ARF5", "ABCB4", "ABCB5", "AK2", "ABCC2")
cols = c("ACH-000004","ACH-000005", "ACH-000007")
cols1 =c("response")


X <- matrix(round(runif(r*c)), r, c, dimnames = list(rows,cols))
y2 <- matrix(round(runif(r1*c1)), r1, c1, dimnames = list(rows,cols1))
names(X)
names(y2)


# Discrete-Test


cdsrmodels::discrete_test(X, y2)


# Step 5: Create informative plots and visuals to showcase the output from above steps



