CPSC 540 Term Project
=====================

Summary
-------

An online job listing web site has extensive data that is primarily unstructured text descriptions of the posted jobs. Many listings provide a salary, but many do not. For listings that do not provide a salary, it is useful to predict a salary based on the description of that job.

This problem is an active Kaggle [competition](http://www.kaggle.com/c/job-salary-prediction).

Data representation
-------------------

We will model the descriptions of the jobs using a bag-of-words model.

Feature extraction
------------------

We expect that the data will have an underlying structure that will explain most of the salary variation. For example, a job posting me be summarized as "a senior programming job in London". We will extract this underlying structure using a neural-network autoencoder. This autoencoder will be used to reduce the dimensionality of the data and extract useful features.

Prediction
----------

Using the features extracted by the autoencoder, we will use a random forest to predict the salary.

Optimization
------------

We will use Gaussian process optimization to optimize the parameters of the models.
