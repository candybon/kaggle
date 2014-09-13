##Kaggle Competition (Predict Fire Peril Loss Cost) 
####Host by: Liberty Mutual Group
======
Link: https://www.kaggle.com/c/liberty-mutual-fire-peril <br>
###1. Observation
Training Data: ~ 450,000 rows; ~360 features. <br>
Non-zero target: ~ 1,200; <br>
After studying the original data, most of the target value are 0, only about 2.6% of the target are non zero.

###2. Solution:
<ol>
	<li>Treat the non-zero data as anormal. Use Anormal detection methodology.</li>
	<li>Use Logistic regression to predict whether a data can be non-zero, then use Linear regression to further predict the value.</li>
	<li>Cosine Similarity. for each test data, find the most similar entry in the training set.</li>
	<li>Neuro Network (not implemented)</li>
</ol>
=======


