CPSC 540 Term Project
=====================

Summary
-------

An online job listing web site has extensive data that is primarily unstructured text descriptions of the posted jobs. Many listings provide a salary, but many do not. For listings that do not provide a salary, it is useful to predict a salary based on the description of that job.

This problem is an active Kaggle [competition](http://www.kaggle.com/c/job-salary-prediction).

Data representation
-------------------

We will model the descriptions of the jobs as a bag-of-words model.

Feature extraction
------------------

We expect that the data will have an underlying structure that will explain most of the salary variation. For example, a job posting may be summarized as "A senior programming job in London". We will attempt to extract this underlying structure using both the N most frequent unigrams in the relevant data fields and a neural-network autoencoder. This autoencoder will be used to reduce the dimensionality of the data and extract useful features.

Prediction
----------

We will use random forests to predict the salary based on both the autoencoded data and the N most frequent unigrams. It is expected that the forests built using the auto encoded data will be far more effective predictors than those built using the N most frequent unigrams. This is due to the fact that many of the most common words in the English language are unlikely to discriminate between different postings and that using simple unigrams ignores combined structures formed by multiple words.

Optimization
------------

We will use Gaussian process optimization to optimize the parameters of the models.

As the benchmark provided by the competition uses a simple, unoptimized random forest of 50 trees with feature selection determined by the 100 most frequent unigrams in three fields, we are confident that we will be able to improve upon it.
