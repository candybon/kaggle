library(data.table);
train <- fread("./train_2replaced.csv");
test <- fread("./test_2replaced.csv");

traget <- train[, target];

#######be careful, check if you have id column, otherwise remove id bellow ######
train <- subset(train, select=-c(id, target));
test <- subset(test, select=-c(id));
#################################################################################

scaleZeroOne <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

devNorm <- function(x) {
  (x - mean(x)) / sd(x)
}

#######transform using mean scaling####################
train <- apply(train, 2, scaleZeroOne);
test <- apply(test, 2, scaleZeroOne);
#######################################################

#put target back to train data
train <- cbind(traget, train)

write.csv(train, file = "train_normed.csv",row.names=FALSE)
write.csv(train, file = "test_normed.csv",row.names=FALSE)
