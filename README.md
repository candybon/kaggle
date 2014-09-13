kaggle
======
Final Scripts that used in Kaggle Competition: Liberty Mutual Group - Fire Peril Loss Cost
Link: https://www.kaggle.com/c/liberty-mutual-fire-peril

======
1. Observation
Training Data: ~ 450,000 rows; ~360 features.
Non-zero target: ~ 1,200;

After studying the original data, most of the target value are 0, only about 2.6% of the target are non zero.
Possible solution:
1. Treat the non-zero data as anormal. Use Anormal detection methodology.
2. Use Logistic regression to predict whether a data can be non-zero, then use Linear regression to further predict the value.
3. Cosine Similarity. for each test data, find the most similar entry in the training set.
4. Neuro Network (not implemented)

=======


