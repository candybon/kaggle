library(data.table);
library(MASS);

scaleZeroOne <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

devNorm <- function(x) {
  (x - mean(x)) / sd(x)
}

train <- fread("./train_2replaced.csv");

y_train <- train[, target];
var8 <- train[,var8];
var10 <- scaleZeroOne(train[,var10]);
var11 <- scaleZeroOne(train[,var11]^(-1));
var13 <- scaleZeroOne(-train[, var13]);
var15 <- scaleZeroOne(train[, var15]);




X <- cbind(var8, var10, var11, var13, var15);

X <- cbind(1, X, exp(X), X^2);

r <- diag(x=ncol(X));
r[1,1] <- 0;

lamda <- 0;

theta = ginv(t(X) %*% X + lamda*r) %*% t(X) %*% y_train

################################################################
test <- fread("./test_2replaced.csv");

tvar8 <- test[,var8];
tvar10 <- scaleZeroOne(test[,var10]);
tvar11 <- scaleZeroOne(test[,var11]^(-1));
tvar13 <- scaleZeroOne(-test[, var13]);
tvar15 <- scaleZeroOne(test[, var15]);

tX <- cbind(tvar8, tvar10, tvar11, tvar13, tvar15);
tX <- cbind(1, tX, exp(tX), tX^2);

target <- tX %*% theta;

ids <- fread("./sampleSubmission.csv");
submit <- cbind(ids[,id], target);
write.csv(submit, file = "manipulated_allscaleone.csv",row.names=FALSE)
write.csv(theta, file="theta0_allscaleone.csv", row.names=FALSE)


