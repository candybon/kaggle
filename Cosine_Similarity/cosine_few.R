library(data.table);
train <- fread("./train_2replaced.csv");
test <- fread("./test_2replaced.csv");

y_train <- train[, target];

train <- subset(train, select=-c(target));

train <- as.matrix(train);
test <- as.matrix(test);


scaleZeroOne <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

devNorm <- function(x) {
  (x - mean(x)) / sd(x)
}

train <- apply(train, 2, devNorm);
test <- apply(test, 2, devNorm);

ntrain <- sqrt(rowSums(train ^ 2));
ntest <- sqrt(rowSums(test ^ 2));

ntrain[ntrain==0] <- 100000.0;

ntrain <- as.matrix(ntrain);
ntest <- as.matrix(ntest);

pred <- c();
for (i in 1:length(ntest)) {
  mul_i <- train %*% test[i,];
  distance_i <- ntrain %*% ntest[i,];
  cosine_i <- mul_i/distance_i;
  pos_i <- max.col(t(cosine_i));
  pred[length(pred)+1] <- y_train[pos_i];
}

sfile <- fread("./sampleSubmission.csv")
submit <- gzfile("./submit.csv.gz", "wt")
write.table(data.frame(id=sfile$id, target=pred), submit, sep=",", row.names=F, quote=F)
close(submit)


#train_processed <- gzfile("./train_processed.csv.gz", "wt");
#write.table(data.frame(target=y_train, var13=train[,1], var8=train[,2], var10=train[,3], var11=train[,4], norm=ntrain), train_processed, sep=",", row.names=F, quote=F)
#close(train_processed)

#test_processed <- gzfile("./test_processed.csv.gz", "wt");
#write.table(data.frame(var13=test[,1], var8=test[,2], var10=test[,3], var11=test[,4], norm=ntest), test_processed, sep=",", row.names=F, quote=F)
#close(test_processed)
