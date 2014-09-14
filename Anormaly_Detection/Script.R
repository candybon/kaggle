library(data.table);
library(MASS);

####################################Get the miu and SIGMA#########################
##train <- fread("./train_replaced_all.csv");
train <- matrix(1:6, ncol=3)

miu <- apply(train, 2, mean);

n <- ncol(train)
SIGMA <- matrix(0, ncol=n, nrow=n);
for (i in 1:nrow(train)) {
  vec <- train[i,] - miu;
  sig <- vec %*% t(vec);
  SIGMA <- SIGMA + sig;
}
SIGMA <- SIGMA / length(train);


######################################For a given x, get the px###################
x <- train[1,];
diff <- x - miu;
px <- exp((t(diff) %*% ginv(SIGMA) %*% diff)/(-2)) / ((2*pi)^(n/2) * sqrt(norm(SIGMA)));

