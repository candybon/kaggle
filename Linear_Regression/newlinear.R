library(data.table);
library(MASS);
train <- fread("./train_2replaced.csv");
test <- fread("./test_2replaced.csv");

y_train <- train[, target];

train <- subset(train, select=-c(target));

train <- as.matrix(train);
test <- as.matrix(test);

X <- cbind(1, train, train^2)

r <- diag(x=ncol(X));
r[1,1] <- 0;

lamda <- 0;

theta = ginv(t(X) %*% X + lamda*r) %*% t(X) %*% y_train

X_test <- cbind(1, test, test^2);

target <- X_test %*% theta;

ids <- fread("./sampleSubmission.csv");

submit <- cbind(ids[,id], target);
write.csv(submit, file = "submit.csv",row.names=FALSE)
