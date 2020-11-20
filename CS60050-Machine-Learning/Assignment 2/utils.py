"""
This python file contains the utility functions used in the assignment
"""

# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>

# import necessary modules from random import seed, randrange, shuffle
from math import sqrt, exp, pi
from csv import reader
from random import shuffle

def load_csv(filename):
	'''
	This function reads a .csv file and stores the data in a row-format (list of lists)
	Parameters:
	-----------
	filename: file path of .csv file to read
	Returns:
	--------
	dataset: data of .csv file in a list of list format
	'''
	dataset = list()
	with open(filename, 'r') as file:
		csv_reader = reader(file)
		for row in csv_reader:
			if not row:
				continue
			dataset.append(row)
	return dataset

def get_column_index(items, cols): 
	'''
	This functions fetches the index of the column name specified in items from cols
	Ex: items = ['B', 'C'] and cols = ['A', 'B', 'C', 'D']
	    the function returns [1, 2]
	Parameters:
	-----------
	items: list of column name(s) whose indices are required
	cols: entire list of column names. This row was dropped after reading the data
	Returns:
	--------
	items: list of intergers specifying the index of each of the original elements of items in cols
	'''
	for i in range(len(cols)):
		for j in range(len(items)):
			if cols[i]==items[j]:
				items[j]=i
	return items

def train_test_split(dataset, train_size=0.8):
	'''
    This function splits the data into two sets - train and test
    Parameters:
    -----------
    dataset: dataset to be split
    train_size: the ratio of training data to original data
    Returns:
    --------
    X_train: training set
    X_test: test set
    '''
	shuffle(dataset)
	X_train = dataset[:int(0.8*len(dataset))]
	X_test = dataset[int(0.8*len(dataset)):]
	return X_train, X_test

def cross_validation_split(dataset, n_folds):
	'''
    This function splits the input data and returns the indices of the validation set for each iteration of cross-validation
    Parameters:
    -----------
    dataset: input data
    n_folds: number of times cross-validation is to be done (for a 5-fold cross validation, n_folds = 5)
    Returns:
    --------
    dataset_split: a n_fold length list of list of indices
                   each entry of this list is a set of indices to be used as validation set in the n_fols cross validation 
    '''

	dataset_split = list()
	l = len(dataset) // n_folds
	for i in range(n_folds):
	  dataset_split.append(dataset[i*l:(i+1)*l])
	return dataset_split

def accuracy_metric(actual, predicted):
	'''
	This function evaluates the accuracy of predicted values with respect to the actual values
	Accuracy is defined as the number of correct predictions divided by total length of predictions
	Parameters:
	-----------
	actual: list of actual values
	predicted: list of predicted values
	Returns:
	--------
	result: accuracy in %
	'''	
	correct = 0
	for i in range(len(actual)):
		if actual[i] == predicted[i]:
			correct += 1
	result = correct / float(len(actual)) * 100.0
	return result


# Calculate the mean of a list of numbers
def mean(numbers):
	'''
    This function returns the mean of the input numbers
    Parameters:
    -----------
    numbers: list of numbers whose mean is to be found
    Returns:
    --------
    mu: mean of the input nunmbers list
    '''
	mu = sum(numbers)/max(1., float(len(numbers)))
	return mu

# Calculate the standard deviation of a list of numbers
def stdev(numbers):
	'''
    This function returns the standard deviation of the input numbers
    Parameters:
    -----------
    numbers: list of numbers whose mean is to be found
    Returns:
    --------
    sigma: standard deviation of the input nunmbers list
    '''

	avg = mean(numbers)
	if len(numbers)==1:
		return 0
	variance = sum([(x-avg)**2 for x in numbers]) / float(len(numbers)-1)
	sigma = sqrt(variance)
	return sigma

# Calculate the mean, stdev and count for each column in a dataset  
def summarize_dataset(dataset):
	'''
    This functions returns the mean, standard deviation, number of entries, threshold value for outlier for each column of the dataset (characteristic values)
    Parameters:
    -----------
    dataset: input data for which the above mentioned characteristic values are to be evaluated for each column
    Returns:
    --------
    summaries: list of list of characteristic values of columns of dataset
    '''
	summaries = [(mean(column), stdev(column), len(column), mean(column)+3*stdev(column)) for column in zip(*dataset)]
	del(summaries[-1])
	return summaries


# Calculate the Gaussian probability distribution function for x 
def calculate_probability(x, mean, stdev):
	'''
    This function returns the probability density of the data point on a Gaussian with given input mean and standard deviation
    Parameters:
    -----------
    x: data point whose probability density is to be evaluated
    mean: mean of the Gaussian
    stdev: standard deviation of the Gaussian
    Returns:
    --------
    prob: probability density of the data point x on the Gaussian with mu = mean and sigma = stdev
    '''
	if stdev == 0: return 0
	exponent = exp(-((x-mean)**2 / (2 * stdev**2 )))
	return (1 / (sqrt(2 * pi) * stdev)) * exponent
 
