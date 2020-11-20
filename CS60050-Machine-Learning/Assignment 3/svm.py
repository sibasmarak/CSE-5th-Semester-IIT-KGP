# import modules
import numpy as np
import pandas as pd
from sklearn.svm import SVC
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score as accuracy


def svm_classifiers(X_train, Y_train, X_test, Y_test, kernel_name_switcher, kernels=['rbf']):
    '''
    This function takes a list of kernels, trains a SVM classifier and returns the accuracy lists of train and test accuracies
    
    Parameters:
    -----------
    X_train: Training set data
    Y_train: Training set targets
    X_test: Testing set data
    Y_test: Testing set targets
    kernels: a list of kernels

    Returns:
    --------
    train_acc: a dictionary with (kernel, training accuracy) as key-value pairs
    test_acc: a dictionary with (kernel, testing accuracy) as key-value pairs
    '''

    train_acc, test_acc = dict(), dict()
    for kernel in kernels:
        classifier = SVC(kernel=kernel, degree=2)
        classifier.fit(X_train, Y_train)
        train_acc[kernel_name_switcher[kernel]] = classifier.score(X_train, Y_train)
        test_acc[kernel_name_switcher[kernel]] = classifier.score(X_test, Y_test)
    print('--------------------- TRAIN ACCURACY --------------------')
    print(train_acc)
    print('\n')
    print('--------------------- TEST ACCURACY --------------------')
    print(test_acc)
    return train_acc, test_acc

def find_best_C(X_train, Y_train, X_test, Y_test, kernels, max_C):
    '''
    This function returns the train and test accuracies for an input list of kernels 
    with C values of 1.e-03 to 1.e+max_C 
    Parameters:
    -----------
    X_train: Training set data
    Y_train: Training set targets
    X_test: Testing set data
    Y_test: Testing set targets
    kernels: a list of kernels
    max_C:  max value of C
    Returns:
    --------
    train_acc: a dictionary with (C-value, training accuracy) as key-value pairs for each kernel
    test_acc: a dictionary with (C-value, testing accuracy) as key-value pairs for each kernel
    '''

    train_acc, test_acc = dict(), dict()
    for kernel in kernels:
        Clist = np.logspace(-3, max_C, num=max_C+4)
        train_acc[kernel], test_acc[kernel] = dict(), dict()
        for C in Clist:
            classifier = SVC(kernel=kernel, degree=2, C=C)
            classifier.fit(X_train, Y_train)
            train_acc[kernel][C] = classifier.score(X_train, Y_train)
            test_acc[kernel][C] = classifier.score(X_test, Y_test)
    return train_acc, test_acc
