  
"""
This python file contains the utility functions used in the assignment
"""

# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>


from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import numpy as np

# pick 80% data randomly as training set and rest as test set
def split_data(data):
    X_train, X_test, Y_train, Y_test = train_test_split(data.iloc[: , :41], data[41], train_size=0.8,)
    print('Size of X_train = {}\nSize of X_test = {}\nSize of Y_train = {}\nSize of Y_test = {}'.format(
        X_train.shape, 
        X_test.shape, 
        Y_train.shape, 
        Y_test.shape
    ))
    return X_train, X_test, Y_train, Y_test


def print_ker_acc(train_acc_C, test_acc_C, kernel_name_switcher):
    '''
    This function prints the result of various kernels and 
    corresponding C-values present in given dictionaries in a tabular form
    Parameters:
    -----------
    train_acc_C: a dictionary with (C-value, training accuracy) as key-value pairs for each kernel
    test_acc_C: a dictionary with (C-value, testing accuracy) as key-value pairs for each kernel
    '''

    print('C \t     Train accuracy   Test accuracy')
    print('---------------------------------------------------')
    for ker in list(train_acc_C.keys()):
        print('\n' + kernel_name_switcher[ker] + ':\n')
        for c in list(train_acc_C[ker].keys()):
            print(str(c) + '\t\t' + '{:0.3f}'.format(train_acc_C[ker][c]) + '\t\t' + '{:0.3f}'.format(test_acc_C[ker][c]))
    print('---------------------------------------------------')

def best_ker_acc(train_acc_C, test_acc_C, kernel_name_switcher):
    '''
    This function prints the best C value for each kernel from input train_acc and test_acc dictionaries
    Parameters:
    -----------
    train_acc_C: a dictionary with (C-value, training accuracy) as key-value pairs for each kernel
    test_acc_C: a dictionary with (C-value, testing accuracy) as key-value pairs for each kernel
    '''

    print('Best Accuracies:')
    print('----------------')
    for ker in list(train_acc_C.keys()):
        print('\n' + kernel_name_switcher[ker] + ':\n')
        maxc = max(test_acc_C[ker], key=test_acc_C[ker].get)
        print('Maximum Test Accuracy occurs with C = {}'.format(maxc))
        print('Corresponding Train Accuracy: {:0.3f}'.format(train_acc_C[ker][maxc]))
        print('Corresponding Test Accuracy: {:0.3f}'.format(test_acc_C[ker][maxc]))


def plot_scores(scores, mapper, ax):
    '''
    function to plot the scores of learning
    rate versus accuracy for each model

    Parameter
    ---------
    scores: dictionary of the accuracies
    mapper: mapper for te model to integer
    ax: axis for plotting the data
    '''
    for idx, key in enumerate(scores.keys()):
        lr = [0.1, 0.01, 0.001, 0.0001, 0.00001]
        ax[0, idx].plot(lr, list(scores[key].values()))
        ax[0, idx].set_title(mapper[str(key)])
        ax[0, idx].set_xlabel('learning rate')
        ax[0, idx].set_xscale('log')
        ax[0, idx].set_ylabel('accuracy')

def plot_scores_3(scores, mapper_3, ax):
    '''
    function to plot the scores of
    accuracy versus model for each
    learning rate

    Parameter
    ---------
    scores: dictionary of the accuracies
    mapper: mapper for te model to integer
    ax: axis for plotting the data
    '''
    for idx, key in enumerate(list(scores.keys())):
        xaxis = [mapper_3[str(i)] for i in list(scores[key].keys())]
        yaxis = list(scores[key].values())
        ax[1, idx].set_title('learning rate = {:0.5f}'.format(key))
        ax[1, idx].plot(np.linspace(1,5,5), yaxis)
        ax[1, idx].set_xticks(np.linspace(1,5,5))
        ax[1, idx].set_xticklabels(xaxis, rotation = 90)
        ax[1, idx].set_xlabel(' (Hidden Layers, units) | units in a tuple')
        ax[1, idx].set_ylabel('accuracy')