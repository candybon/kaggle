library(data.table);
library(MASS);

scaleZeroOne <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

devNorm <- function(x) {
  (x - mean(x)) / sd(x)
}

train <- fread("./train_replaced_all.csv");

y_train <- train[, target];
var8 <- train[,var8];
var10 <- scaleZeroOne(train[,var10]);
var11 <- scaleZeroOne(train[,var11]^(-1));
var13 <- scaleZeroOne(-train[, var13]);
var15 <- scaleZeroOne(train[, var15]);

w3 <- scaleZeroOne(train[,weatherVar3]);
w14 <- scaleZeroOne(train[,weatherVar14]);
w25 <- scaleZeroOne(train[,weatherVar25]);
w31 <- scaleZeroOne(train[,weatherVar31]);
w37 <- scaleZeroOne(train[,weatherVar37]);
w57 <- scaleZeroOne(train[,weatherVar57]);
w76 <- scaleZeroOne(train[,weatherVar76]);
w87 <- scaleZeroOne(train[,weatherVar87]);
w109 <- scaleZeroOne(train[,weatherVar109]);
w110 <- scaleZeroOne(train[,weatherVar110]);
w157 <- scaleZeroOne(train[,weatherVar157]);
w163 <- scaleZeroOne(train[,weatherVar163]);



X <- cbind(var8, var10, var11, var13, var15, w3, w14, w25, w31???w37, w57, w76, w87???w109, w110, w157, w163);

X <- cbind(1, X, exp(X), X^2);

r <- diag(x=ncol(X));
r[1,1] <- 0;

lamda <- 0;

theta = ginv(t(X) %*% X + lamda*r) %*% t(X) %*% y_train

################################################################
test <- fread("./test_replaced_all.csv");

tvar8 <- test[,var8];
tvar10 <- scaleZeroOne(test[,var10]);
tvar11 <- scaleZeroOne(test[,var11]^(-1));
tvar13 <- scaleZeroOne(-test[, var13]);
tvar15 <- scaleZeroOne(test[, var15]);


tw3 <- scaleZeroOne(test[,weatherVar3]);
tw14 <- scaleZeroOne(test[,weatherVar14]);
tw25 <- scaleZeroOne(test[,weatherVar25]);
tw31 <- scaleZeroOne(test[,weatherVar31]);
tw37 <- scaleZeroOne(test[,weatherVar37]);
tw57 <- scaleZeroOne(test[,weatherVar57]);
tw76 <- scaleZeroOne(test[,weatherVar76]);
tw87 <- scaleZeroOne(test[,weatherVar87]);
tw109 <- scaleZeroOne(test[,weatherVar109]);
tw110 <- scaleZeroOne(test[,weatherVar110]);
tw157 <- scaleZeroOne(test[,weatherVar157]);
tw163 <- scaleZeroOne(test[,weatherVar163]);



tX <- cbind(tvar8, tvar10, tvar11, tvar13, tvar15, tw3, tw14, tw25, tw31???tw37, tw57, tw76, tw87???tw109, tw110, tw157, tw163);
tX <- cbind(1, tX, exp(tX), tX^2);

target <- tX %*% theta;

ids <- fread("./sampleSubmission.csv");

submit <- cbind(ids[,id], target);
write.csv(submit, file = "./outpout/selected_all_scaled.csv",row.names=FALSE)
write.csv(theta, file="./output/theta_all_scaled.csv", row.names=FALSE)
