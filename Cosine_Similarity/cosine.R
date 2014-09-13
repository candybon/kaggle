library(data.table)

train <- fread("./train_3_reduced.csv");
test <- fread("./test_3_reduced.csv");

y_train <- train[,target];

X_train <- subset(train, select=-c(id,target));
train <- 0;
X_train <- as.matrix(X_train);

X_test <- subset(test, select=-c(id));
test <- 0;
X_test <- as.matrix(X_test);

dotmul <- X_train %*% t(X_test);

norm_train <- sqrt(rowSums(X_train ^ 2));
norm_test <- sqrt(rowSums(X_test ^ 2));

##No need X_train and X_test to save space
X_train <- 0;
X_test <- 0;
##

distance <- norm_train %*% t(norm_test);
cosinee <- dotmul/distance;

#No need for dotmul, norm_train, norm_test, distance
dotmul <- 0;
distance <- 0;
norm_train <- 0;
norm_test <- 0;
###########

pos <- max.col(t(cosinee));

pred <- y_train[pos];

sfile <- fread("./sampleSubmission.csv");
submit <- gzfile("./submit.csv.gz", "wt");
write.table(data.frame(id=sfile$id, target=pred), submit, sep=",", row.names=F, quote=F)
close(submit)