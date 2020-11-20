"""
This python file contains the utility functions that will help in the 
construction of the decision tree and printing the tree. Here variance 
is used as an measure of impurity
"""

# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>

import pandas as pd
import time
import datetime
import random
import model
from graphviz import Digraph

#===============#
#   READ DATA   #
#===============#


def read_data(file):
    '''
    Parameter
    ---------
    file: the name opf the file which contains the data to be read

    Returns
    -------
    df : A pandas dataframe consisting of the data
        read from the 'PercentageIncreaseCOVIDWorldwide.csv
        csv file
    '''
    df = pd.read_csv(file).drop(index=0)
    return df


def get_date(date):
    '''
    Converts the date from a string to a UNIX time-stamp format

    Parameters
    ----------
    date : A string representing the given date in the format
            MM/ DD/ YYYY

    Returns
    -------
    unix: Converted date from string to unix format that
            is accepted by time, i.e a continuous function
    '''
    unix = time.mktime(datetime.datetime.strptime(
        date, "%m/%d/%Y").timetuple())
    return unix


def build_data(df):
    '''
    Converts the data from the pandas data freame format to 
    array of ddictionary objects

    Parameters
    ----------
    df: A pandas dataframe that contains the values read from the 
        input csv file. The data frame should have four attributes
        ["Date", "Confirmed", "Recovered", "Deaths"] and the target
        attribute, that is "Incease rate", Shape of the df should 
        be (n , 5)

    Returns
    -------
    data: It is the list that consists the values from the dataframe 
            converted to dictionary objects. Each object in the list 
            will represent exactly one sample of data. Sape of the
            data will be => length=n, each object will have 4 keys
    '''

    data = []
    for i in range(1, len(df['Confirmed'])+1):
        data.append(
            {
                'Date':           get_date(df['Date'][i]),
                'Confirmed':      df['Confirmed'][i],
                'Recovered':      df['Recovered'][i],
                'Deaths':         df['Deaths'][i],
                'Increase rate':  df['Increase rate'][i]
            }
        )
    return data


def train_test_split(df):
    '''
    This function will first convert the pandas dataframe 
    into array of dictionary objects then splits the data into 
    X_train and X_test using an 80-20 split for training : test

    Parameters
    ----------
    df: A pandas dataframe that contains the values read from the 
        input csv file. The data frame should have four attributes
        ["Date", "Confirmed", "Recovered", "Deaths"] and the target
        attribute, that is "Incease rate", Shape of the df should 
        be (n , 5)

    Returns
    -------
    X_train: [List]Contais the 80% data points collected from the 
                randomly shuffled dataset which will be used 
                for training. length=0.8*n

    X_test: [List]Contais the 20% data points collected from the 
                randomly shuffled dataset which will be used 
                for testing. length=0.2*n

    '''

    data = build_data(df)
    random.shuffle(data)
    X_train, X_test = data[:int(
        0.6*len(data))], data[int(0.8*len(data)):]
    return X_train, X_test


def train_valid_split(data):
    '''
    data: This function is to split the input data in to
    training set and validation set. The following function 
    makes use of the K-fold cross validation wher the data 
    is divided into 4 parts and three parts is used for 
    training and one art for validation 

    Parameters
    ----------
    data: this contains the dataset from the initial 80% split

    Returns
    -------
    following percentages are out of the 80% data that is contained in data

    X_train: [List]Contais the 60% data points collected from the 
                randomly shuffled dataset which will be used 
                for training. length=0.8*n

    X_valid: [List]Contais the 20% data points collected from the 
                randomly shuffled dataset which will be used 
                for cross validation. length=0.2*n

    '''

    random.shuffle(data)
    X_train, X_valid = data[:int(
        0.75*len(data))], data[int(0.75*len(data)):]
    return X_train, X_valid


def variance(data):
    '''
    This function is a helper function which helps to calculate the 
    varince of the data that is given as the input    

    Parameters
    ----------
    data: array of numbers whose variance is to be calculated

    Returns
    -------
    var: This is the variance of the numbers that are  given as 
            input in data. Var = (X - mean)^2/N
    '''

    mean, var = 0, 0
    for i in data:
        mean += i

    # calculate the mean
    mean /= len(data)
    for i in data:
        var += (i-mean)**2
    # calculate the variance
    var /= len(data)
    return var


def good_attr(data, attr_list):
    '''
    This function is a helper function which helps to select 
    which attribute will be the best if selected at this level
    for splitting. the measure used in this method is variance    

    Parameters
    ----------
    data: array of dictionary, containst the data for which the 
            splitting decision is to be taken

    attr_list: list of the attributes from which we need to 
                make a selection for the best attribute

    Returns
    -------
    best_attr: best attribute decided to be selected on the 
                basis of the amount of change measured

    split: the value that should be selected for the best split
            to get the best difference in the change in variance

    mse: mean squared error of the current data when the ( split )
            value is selected as a measure for splitting the data
    '''

    best, best_attr, split, mse = -1, '', 0, 0

    # shuffle the list to get better variation
    # in selection of the attributes
    random.shuffle(attr_list)

    # for each attribute find the best change in variance
    for attr in attr_list:

        # create a list of data for the current attribute
        attr_data = [{
            'val': i[attr],
            'Increase rate': i['Increase rate']
        } for i in data]

        # define the local variables
        local_best, local_val = -1, 0

        # sort the data for easy manipulation
        data_left, data_right = [], sorted(
            [i['Increase rate'] for i in attr_data])
        data_var, data_len = variance(data_right), len(attr_data)
        left_len, right_len = 0, data_len

        # iterate through all the mid points of conecutive data points
        # to select the best split for the attribute
        for i in range(1, len(attr_data)):
            mid = (attr_data[i-1]['val'] + attr_data[i]['val']) // 2
            data_left.append(data_right.pop(0))
            left_len, right_len = left_len+1, right_len-1

        left_var = variance(data_left)
        right_var = variance(data_right)

        # calculate the current change in variance
        gain = data_var - (left_len/data_len*left_var +
                           right_len/data_len*right_var)

        # if the change is more than any change observed
        # till now then select this split as the best
        if gain > local_best:
            local_best = gain
            local_val = mid

    # check if the current attribute gives the best
    # change in the variance measure, if so then
    # select this attribute as the best measure
    if local_best > best:
        best = local_best
        best_attr = attr
        split = local_val
        mse = data_var

    return best_attr, split, mse


def is_leaf(node):
    '''
    this function checks whether the currnent node is a leaf node

    Parameter
    ---------
    node: this is the node object that is to be checked for the leaf

    Return
    -------
    is_leaf: a boolean value which is true when the current node 
                is a leaf
    '''

    is_leaf = (node.left == None and node.right == None)
    return is_leaf


def get(node):
    '''
    this function returns a formatted string which will be used 
    for printing the parameters inside the node when the graph 
    is crated using graphviz

    Parameter
    ---------
    node: this is the node object that is to be checked for the leaf

    Return
    -------
    is_leaf: a boolean value which is true when the current node 
                is a leaf
    '''
    if not is_leaf(node):
        return "{} <= {}\nmse = {}\nmean = {}".format(node.attr, node.split, node.mse, node.mean)
    return "{} == {}\nmse = {}\nmean = {}".format(node.attr, node.split, node.mse, node.mean)


def print_decision_tree(dtree):
    '''
    this function prints the ddecision tree graph so created 
    and saves the output in the a pdf file 

    Parameter
    ---------
    dtree:  root node of the decision tree for which the 
            the graph needs top be printed
    '''

    # create a new Digraph
    f = Digraph('Decision Tree', filename='decision_tree.gv')
    f.attr(rankdir='LR', size='1000,500')

    # border of the nodes is set to rectangle shape
    f.attr('node', shape='rectangle')

    # Do a breadth first search and add all the edges
    # in the output graph
    q = [dtree]  # queue for the bradth first search
    while len(q) > 0:
        node = q.pop(0)
        if node.left != None:
            f.edge(get(node), get(node.left), label='True')
        if node.right != None:
            f.edge(get(node), get(node.right), label='False')

        if node.left != None:
            q.append(node.left)
        if node.right != None:
            q.append(node.right)

    # save file name :  decision_tree.gv.pdf
    f.render('./decision_tree.gv', view=True)


def r2_score(Y, Y_hat):
    '''
    this function calculates the r2 score  of the 
    decision tree over the input dataset

    Parameter
    ---------
    Y:  Actual labels of the dataset

    Y_hat: Predicted labels of the dataset by the decision tree

    Return
    ------
    score: this contains the r2_score as computed from the 
            formula over the given dataset
    '''

    ssr, sst = 0, 0
    Y_bar = sum(Y)/len(Y)
    for i, val in enumerate(Y):
        ssr += (val-Y_hat[i])**2
        sst += (val-Y_bar)**2

    if sst==0 : sst = 10**-20
    score = 1-ssr/sst
    return score


def get_accuracy(decision_tree, X_data):
    '''
    this function returns accuracy of the decision tree over the 
    dataset as measured by the r2_score measure 

    Parameter
    ---------
    decision_tree: root node of the decision tree for which the 
                    accuracy needs to be calculated

    X_data: The data set over which the accuracy will be measured

    Return
    ------
    acc: the accuracy of the decision tree over the inputa dataset
    '''

    _, preds = model.predict(decision_tree, X_data)
    data = []
    for i in X_data:
        data.append(i['Increase rate'])
    acc = r2_score(data, preds)
    return acc
