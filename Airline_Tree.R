# ATTRIBUTES:
# Id: Id number of the passengers
# Gender: Gender of the passengers (Female, Male)
# Customer Type: The customer type (Loyal customer, disloyal customer)
# Age: The actual age of the passengers
# Type of Travel: Purpose of the flight of the passengers (Personal Travel, Business Travel)
# Class: Travel class in the plane of the passengers (Business, Eco, Eco Plus)
# Flight Distance: The flight distance of this journey
# Inflight wifi service: Satisfaction level of the inflight wifi service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Departure/Arrival time convenient: Satisfaction level of Departure/Arrival time convenient (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Ease of Online booking: Satisfaction level of online booking (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Gate location: Satisfaction level of Gate location (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Food and drink: Satisfaction level of Food and drink service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Online boarding: Satisfaction level of online boarding (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Seat comfort: Satisfaction level of Seat comfort (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Inflight entertainment: Satisfaction level of inflight entertainment (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# On-board service: Satisfaction level of On-board service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Leg room service: Satisfaction level of Leg room service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Baggage handling: Satisfaction level of baggage handling (1,2,3,4,5/ 1=Least Satisfied to 5=Most Satisfied)
# Checkin service: Satisfaction level of Check-in service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Inflight service: Satisfaction level of inflight service (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Cleanliness: Satisfaction level of Cleanliness (0,1,2,3,4,5/ 0=Not Applicable; 1=Least Satisfied to 5=Most Satisfied)
# Departure Delay in Minutes: Minutes delayed when departure
# Arrival Delay in Minutes: Minutes delayed when arrival
# Satisfaction: /output column/ Airline satisfaction level ('satisfied', 'neutral or dissatisfied')

setwd("D:/OneDrive/Documents/DM&ML/TABA/Datasets/")

##################################
##########  train data  ##########
##################################
train <- read.csv("Airline_train.csv", header=T, na.strings=c(""), stringsAsFactors = T)
print(length(train[is.na(train)])) # 310
sum(!complete.cases(train)) # 310
train<- train[complete.cases(train), ]

# ?????? ???????????? ????????????
train$satisfaction <- factor(train$satisfaction, 
                             levels = c("neutral or dissatisfied","satisfied"), 
                             labels = c("No", "Yes"))
# Age
train$Age <- cut(train$Age,
                 breaks = c(0, 10, 20, 30, 40, 50, 60, 70, max(train$Age)),
                 labels = c("0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70+"))

# Flight.Distance
train$Flight.Distance <- cut(train$Flight.Distance,
                             breaks = c(0, 400, 800, 1200, 1600, 2000, 2400, 2800, 3200, 3600, max(train$Flight.Distance)),
                             labels = c("0-400", "400-800", "800-1200", "1200-1600", "1600-2000", "2000-2400", "2400-2800", "2800-3200", "3200-3600", "4000+"))

# Arrival.Delay.in.Minutes
train$Arrival.Delay.in.Minutes <- cut(train$Arrival.Delay.in.Minutes,
                                      breaks=c(0,1, 5, 10, 20, 30, 40, 50, 60, 90, 120, max(train$Arrival.Delay.in.Minutes)), 
                                      labels=c("0", "1-5", "5-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-90", "90-120", "120+"),
                                      include.lowest=TRUE, 
                                      right=FALSE)

# Departure.Delay.in.Minutes
train$Departure.Delay.in.Minutes <- cut(train$Departure.Delay.in.Minutes,
                                        breaks=c(0,1, 5, 10, 20, 30, 40, 50, 60, 90, 120, max(train$Departure.Delay.in.Minutes)), 
                                        labels=c("0", "1-5", "5-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-90", "90-120", "120+"),
                                        include.lowest=TRUE, 
                                        right=FALSE)
str(train)
# ?????????
sample <- sample(nrow(train), 0.1*nrow(train))
train <- train[sample, ]

##################################
##########   test data  ##########
##################################
test <- read.csv("Airline_test.csv", header=T, na.strings=c(""), stringsAsFactors = T)
# ????????? ??????
print(length(test[is.na(test)])) # 83
sum(!complete.cases(test)) # 83
test<- test[complete.cases(test), ]

# ?????? ???????????? ????????????
test$satisfaction <- factor(test$satisfaction, 
                             levels = c("neutral or dissatisfied","satisfied"), 
                             labels = c("No", "Yes"))
# Age binning
test$Age <- cut(test$Age,
                breaks = c(0, 10, 20, 30, 40, 50, 60, 70, max(test$Age)),
                labels = c("0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70+"))

# Flight.Distance
test$Flight.Distance <- cut(test$Flight.Distance,
                            breaks = c(0, 400, 800, 1200, 1600, 2000, 2400, 2800, 3200, 3600, max(test$Flight.Distance)),
                            labels = c("0-400", "400-800", "800-1200", "1200-1600", "1600-2000", "2000-2400", "2400-2800", "2800-3200", "3200-3600", "4000+"))

# Arrival.Delay.in.Minutes
test$Arrival.Delay.in.Minutes <- cut(test$Arrival.Delay.in.Minutes,
                                     breaks=c(0,1, 5, 10, 20, 30, 40, 50, 60, 90, 120, max(test$Arrival.Delay.in.Minutes)), 
                                     labels=c("0", "1-5", "5-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-90", "90-120", "120+"),
                                     include.lowest=TRUE, 
                                     right=FALSE)

# Departure.Delay.in.Minutes
test$Departure.Delay.in.Minutes <- cut(test$Departure.Delay.in.Minutes,
                                       breaks=c(0,1, 5, 10, 20, 30, 40, 50, 60, 90, 120, max(test$Departure.Delay.in.Minutes)), 
                                       labels=c("0", "1-5", "5-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-90", "90-120", "120+"),
                                       include.lowest=TRUE, 
                                       right=FALSE)
str(test)

# ?????????
sample <- sample(nrow(test), 0.1*nrow(test))
test <- test[sample, ]

nrow(train)
nrow(test)

str(train)
str(test)
###################################################
# Remove 'id' and 'X' columns from training data and test data
airline.train <- train[, -1:-2] # ????????? ??? ??????
airline.test <- test[, -1:-2] # ????????? ??? ??????

## as.numeric
airline.train <- cbind(lapply(airline.train[-23], function(x) as.numeric(as.factor(x))), airline.train[23])
str(airline.train)
airline.test <- cbind(lapply(airline.test[-23], function(x) as.numeric(as.factor(x))), airline.test[23])

str(airline.train)
str(airline.test)

#######################################
#########    Decision Tree    #########
#######################################
table(train$satisfaction)
mean(train$satisfaction == "No") # 0.5657463 ?????????
mean(train$satisfaction == "Yes") # 0.4342537 ??????

table(airline.train$satisfaction)
mean(airline.train$satisfaction == "No") # 0.5657463 ?????????
mean(airline.train$satisfaction == "Yes") # 0.4342537 ??????

#######################################
# 1. Running a model
library(rpart) # decision tree??? ???????????? ????????? ??? ??????
airline.dtree <- rpart(formula = satisfaction ~ ., data = airline.train, 
                       method = "class", # method >> classification decision tree 
                                          # method = "anova" >> regression tree 
                       parms=list(split = "information")) 
# parms: list >> measuring homogeneity
# split: information >> get information type

airline.dtree
summary(airline.dtree) 
# n= 10359  
# total 13 terminal nodes created

#######################################
# Check tree graphs 
# install.packages("rpart.plot")
library(rpart.plot)
prp(airline.dtree, type=2, #type=2: ???????????? ?????? ?????? ????????? ????????????.
    extra = 104,# ??? ????????? ?????? ??? ????????? ????????? ??? ????????? ??? ??? ??????.
    fallen.leaves = TRUE, # ?????? ???????????? ??? ???????????? ?????? ?????? ????????????.
    roundint = FALSE, # ????????? ????????? ????????? ???????????? ???????????? ????????? ????????? ?????? ???????????? FALSE??? ????????? ??????.
    main="Decision Tree from Airline satisfaction Dataset")

# Simple to make a tree graph
# install.packages("rattle")
library(rattle)
fancyRpartPlot(airline.dtree, sub = NULL)

#######################################
# Prediction
airline.dtree.pred <- predict(airline.dtree, newdata = airline.test, type = "prob")
head(airline.dtree.pred) # probability of each case
airline.dtree.pred <- predict(airline.dtree, newdata = airline.test, type = "class")
head(airline.dtree.pred) # class name of each case

# Cross table
table(airline.test$satisfaction, airline.dtree.pred, dnn = c("Actual", "Predicted"))
mean(airline.test$satisfaction == airline.dtree.pred) # 90.57%


#######################################
# Check a CP table for Prunning
airline.dtree$cptable # (1)
print(airline.dtree)  # (2)
#       CP      nsplit rel error  xerror    xstd
# 1 0.51797276    0   1.0000000 1.0000000 0.011257429
# 2 0.12592096    1   0.4820272 0.4820272 0.009229821
# 3 0.03505247    2   0.3561063 0.3561063 0.008201467
# 4 0.02411253    3   0.3210538 0.3268587 0.007915959
# 5 0.02143336    4   0.2969413 0.2958250 0.007589410
# 6 0.01034457    5   0.2755079 0.2755079 0.007360953
# 7 0.01004689    9   0.2330877 0.2525117 0.007086717
# 8 0.01000000    12  0.2029471 0.2446975 0.006989420

# (Min of xerror - Max of xstd, Min of error + Max of xstd) 
0.2446975  - 0.006989420 # 0.2377081
0.2446975 + 0.006989420  # 0.2516869
# (0.2377081, 0.2516869) >> ?????? ??? xerror??? ???????????? ????????? ?????????. ??? ?????? ????????? ??????. ????????? ????????? ????????? ??????.
# 8??? ?????? ?????? (?????? ????????? 8???, ?????? ????????? 9???)
# >> ??? ?????? CP?????? { }??? ?????? >> ?????? ???????????? ????????? ?????? ????????????.(cp parameter??? ????????????.)

# plotcp(): cp(????????? ????????????)??? ?????? ?????? ?????? ??? ????????? ??? ??? ??? ??????.
# ???????????? ???????????? ?????????, xerror(?????? ?????? ?????? ??????)??? ?????? ?????? ?????? ?????? ??? ???????????? ????????????.
#{(0.206, 0.277) ??? 0.277}
# ?????? ????????? ?????? ??? ?????? ????????? ??????(3??? ??????)??? ????????? ??????.
plotcp(airline.dtree)

# Prune
# There should be no prunning for the model due to the cp table and the result,
# However, let's try 7'th CP.
## Method(1)
airline.pruned1 <- rpart(satisfaction ~ ., data = airline.train,
                              method = "class",
                              cp = 0.01004689,
                              parms = list(split="information"))
airline.pruned1.pred <- predict(airline.pruned1, newdata = airline.test, type = "class")
table(airline.test$satisfaction, airline.pruned1.pred, dnn = c("Actual", "Predicted"))
mean(airline.test$satisfaction == airline.pruned1.pred) # 0.8933951

## Method(2)
airline.pruned2 <- prune(airline.dtree, cp=0.01004689)
airline.pruned2.pred <- predict(airline.pruned2, newdata = airline.test, type = "class")
table(airline.test$satisfaction, airline.pruned2.pred, dnn = c("Actual", "Predicted"))
mean(airline.test$satisfaction == airline.pruned2.pred) # 0.8933951
#         Predicted
# Actual    No  Yes
#       No  1333  125
#       Yes  151  980


