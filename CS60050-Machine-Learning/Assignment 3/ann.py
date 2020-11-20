  
"""
This python file  contains  the functions which
will help in the creation of the ann classifier
and functions for getting the scores
"""

# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>


# import modules
import numpy as np
import pandas as pd
from sklearn.svm import SVC
import matplotlib.pyplot as plt
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split

def model(X_train, Y_train, hidden_layers=[], activation='logistic', lr=0.0001):
    '''
    This function creates the MLP classifier and
    fits the model on  the  input  training data

    Parameters
    ----------
    X_train: Training dataset
    Y_train: Target of the training dataset
    hidden_layers: tuples containing the number of neurons in each layer
    activation: the activation function used
    lr: learning rate

    Return
    ------
    clf : the mlp classifier built on the input data
    '''
    clf = MLPClassifier(
        hidden_layer_sizes=hidden_layers, 
        solver='sgd',
        activation=activation,
        verbose=False, 
        learning_rate_init=lr
    )
    clf = clf.fit(X_train, Y_train)
    return clf


def tune_learning_rate(X_train, Y_train, X_test, Y_test, best_model, best_score, activation):
    '''
    This function is used to make models for different 
    learning  rate and find  the best leaning rate for 
    the the model

    Parameters
    ----------
    X_train: training dataset
    Y_train: target values for the training data
    X_test: data for the test dataset
    Y_test: target values for the test data
    best_model: best model till now
    best_score: best scores till now
    activation: activation function for the model

    Return
    ------
    scores: Dictionary for the accuracy versus learning rate for each model
    best_model: best model found
    best_score: best score found
    '''
    lr = [0.1, 0.01, 0.001, 0.0001, 0.00001]
    hidden_layers = [[], [2], [6], [2,3], [3,2]]
    idx = 1
    scores = {}
    for hl in hidden_layers:
        scores[idx] = {}
        for learning_rate in lr:
            clf = model(X_train, Y_train, hidden_layers=hl, lr=learning_rate, activation=activation)
            score = clf.score(X_test, Y_test)
            if score > best_score:
                best_model = clf
                best_score = score
            scores[idx][learning_rate] = score
        idx += 1
    return scores, best_model, best_score

def tune_model(X_train, Y_train, X_test, Y_test, best_model, best_score, activation):
    '''
    This function is used to get model versus
    accuracy values for each learning rate

    Parameters
    ----------
    X_train: training dataset
    Y_train: target values for the training data
    X_test: data for the test dataset
    Y_test: target values for the test data
    best_model: best model till now
    best_score: best scores till now
    activation: activation function for the model

    Return
    ------
    scores: Dictionary for the accuracy versus model for each learning rate
    best_model: best model found
    best_score: best score found
    '''
    lr = [0.1, 0.01, 0.001, 0.0001, 0.00001]
    hidden_layers = [[], [2], [6], [2,3], [3,2]]
    scores = {}
    for learning_rate in lr:
        idx = 1
        scores[learning_rate] = {}
        for hl in hidden_layers:
            clf = model(X_train, Y_train, hidden_layers=hl, lr=learning_rate, activation=activation)
            score = clf.score(X_test, Y_test)
            if score > best_score:
                best_model = clf
                best_score = score
            scores[learning_rate][idx] = score
            idx += 1
    return scores, best_model, best_score
