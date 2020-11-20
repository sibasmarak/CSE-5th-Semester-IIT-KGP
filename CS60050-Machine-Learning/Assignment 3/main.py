import time
import warnings
import pandas as pd
import argparse
import matplotlib.pyplot as plt
from pprint import pprint
from sklearn.preprocessing import StandardScaler
from utils import split_data, print_ker_acc, best_ker_acc, plot_scores, plot_scores_3
from svm import svm_classifiers, find_best_C
from ann import model, tune_learning_rate, tune_model
warnings.filterwarnings("ignore")

if __name__ == '__main__':

    # there is no missing value column
    # RB: Ready Biodegradable -> assigned as True (356)
    # NRB: Not Ready Biodegradable -> assigned as False (699)
    # shape: (1055, 42)
    # last column is the target
    start = time.time()

    
    parser = argparse.ArgumentParser()
    parser.add_argument("--maxc", help="max value of C (log_10 and non - negative integer) for finding the best C (Default 4: <= 10^4)")
    args = parser.parse_args()
    
    # Default values
    max_C = 4

    # parse arguments
    if args.maxc: max_C = max(0, int(args.maxc))
    
    print("\n ============= READING DATA ============ \n")
    data = pd.read_csv('biodeg.csv', sep=';', header=None)
    data[41] = data[41] == 'RB'
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= DATA READ =============== \n\n")
    
    scaler = StandardScaler()
    data[:41] = scaler.fit_transform(data[:41])
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= DATA NORMALIZED ========= \n\n")

    print("============= SPLITTING DATASET INTO TRAIN TEST ============\n")
    X_train, X_test, Y_train, Y_test = split_data(data)
    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    print("============= TRAIN TEST SPLIT COMPLETE ============\n")

    print("===================== SOLVING Q1 ===================\n\n")
    print("\
        ######################################\n\
        #                                    #\n\
        #          SVM CLASSIFIER            #\n\
        #                                    #\n\
        ######################################\n\
        \n")
    kernel_name_switcher = {
        'rbf': 'Radial Basis Function',
        'linear': 'Linear',
        'poly': 'Quadratic'
    }

    print('\nkernel_name_switcher = {\n\
        \'rbf\': \'Radial Basis Function\',\n\
        \'linear\': \'Linear\',\n\
        \'poly\': \'Quadratic\'\n\
    }\n\n')

    print('============= IMPLEMENT BINARY SVM CLASSIFIER ===================\n')
    train_acc, test_acc = svm_classifiers(X_train, Y_train, X_test, Y_test, kernel_name_switcher, ['rbf', 'linear', 'poly'])
    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    print('\n============= FINDING BEST C VALUE FOR SVM CLASSIFIER ===========\n')
    train_acc_C, test_acc_C = find_best_C(X_train, Y_train, X_test, Y_test, ['rbf', 'linear', 'poly'], max_C)
    print_ker_acc(train_acc_C, test_acc_C, kernel_name_switcher)
    best_ker_acc(train_acc_C, test_acc_C, kernel_name_switcher)

    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    print("\n============== SOLVED Q1 ==============\n")

    print("\n============== SOLVING Q2 ==============\n")
    print("\
        ######################################\n\
        #                                    #\n\
        #          ANN CLASSIFIER            #\n\
        #                                    #\n\
        ######################################\n\
        \n")

    mapper = {
        '1': 'no hidden layers',
        '2': '1 hidden layer \nwith 2 nodes',
        '3': '1 hidden layer \nwith 6 nodes',
        '4': '2 hidden layers \nwith 2 and 3 nodes \nrespectively',
        '5': '2 hidden layers \nwith 3 and 2 nodes \nrespectively'
    }
    mapper_3 = {
        '1': '0, ()',
        '2': '1, (2)',
        '3': '1, (6)',
        '4': '2, (2,3)',
        '5': '2, (3,2)'
    }

    print('mapper = {\n\
        \'1\': \'no hidden layers\',\n\
        \'2\': \'1 hidden layer with 2 nodes\',\n\
        \'3\': \'1 hidden layer with 6 nodes\',\n\
        \'4\': \'2 hidden layers with 2 and 3 nodes respectively\',\n\
        \'5\': \'2 hidden layers with 3 and 2 nodes respectively\'\n\
    }\n')

    print('Size of input: {}'.format(X_train.shape[1]))
    print('Size of output: {}'.format(1))

    print('\nAll the following results with \nlearning rate = 0.0001 and \nsolver = sgd (stochastic gradient descent)\n')
    best_model = None
    best_score = -1

    print("\n\
        ###############################\n\
        ##   Activaton : Logistic    ##\n\
        ###############################\n\
        \n")
    
    # with 0 hidden layer
    clf = model(X_train, Y_train, )
    print('With 0 hidden layer')
    print('-------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)

    # with 1 hidden layer with 2 nodes
    clf = model(X_train, Y_train, hidden_layers=[2])
    print('With 1 hidden layer with 2 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 1 hidden layer with 6 nodes
    clf = model(X_train, Y_train, hidden_layers=[6])
    print('With 1 hidden layer with 6 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 2 and 3 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[2,3])
    print('With 2 hidden layers with 2 and 3 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 3 and 2 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[3,2])
    print('With 2 hidden layers with 3 and 2 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    print("\n\
        ###############################\n\
        ##   Activaton : RELU        ##\n\
        ###############################\n\
        \n")
    
    # with 0 hidden layer
    clf = model(X_train, Y_train,activation='relu' )
    print('With 0 hidden layer')
    print('-------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 1 hidden layer with 2 nodes
    clf = model(X_train, Y_train, hidden_layers=[2],activation='relu')
    print('With 1 hidden layer with 2 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 1 hidden layer with 6 nodes
    clf = model(X_train, Y_train, hidden_layers=[6],activation='relu')
    print('With 1 hidden layer with 6 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 2 and 3 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[2,3],activation='relu')
    print('With 2 hidden layers with 2 and 3 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 3 and 2 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[3,2],activation='relu')
    print('With 2 hidden layers with 3 and 2 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    print("\n\
        ###############################\n\
        ##   Activaton : TANH        ##\n\
        ###############################\n\
        \n")
    
    # with 0 hidden layer
    clf = model(X_train, Y_train,activation='tanh' )
    print('With 0 hidden layer')
    print('-------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 1 hidden layer with 2 nodes
    clf = model(X_train, Y_train, hidden_layers=[2],activation='tanh')
    print('With 1 hidden layer with 2 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 1 hidden layer with 6 nodes
    clf = model(X_train, Y_train, hidden_layers=[6],activation='tanh')
    print('With 1 hidden layer with 6 nodes')
    print('--------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 2 and 3 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[2,3],activation='tanh')
    print('With 2 hidden layers with 2 and 3 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    # with 2 hidden layers with 3 and 2 nodes respectively
    clf = model(X_train, Y_train, hidden_layers=[3,2],activation='tanh')
    print('With 2 hidden layers with 3 and 2 nodes respectively')
    print('----------------------------------------------------')
    print('Accuracy:\t{:0.3f}\n'.format(clf.score(X_test, Y_test)))
    print("\nTime elapsed  =  {} s\n".format(time.time()-start))
    if clf.score(X_test, Y_test) > best_score: 
        best_model = clf
        best_score = clf.score(X_test, Y_test)
    
    print('\
        ##########################################################\n\
        ##                                                      ##\n\
        ##               PLOTTING DATA                          ##\n\
        ##                                                      ##\n\
        ##      1. Learning rate vs accuracy for each model     ##\n\
        ##         ( 5 plots in top row )                       ##\n\
        ##                                                      ##\n\
        ##      2. Model vs accuracy for each learning rate     ##\n\
        ##         ( 5 plots in bottom row )                    ##\n\
        ##                                                      ##\n\
        ##########################################################\n\
        \n')
    
    activation = best_model.get_params()['activation']

    scores, best_model, best_score = tune_learning_rate(X_train, Y_train, X_test, Y_test, best_model, best_score, activation)
    scores_3, best_model, best_score = tune_model(X_train, Y_train, X_test, Y_test, best_model, best_score, activation)
    
    fig, ax = plt.subplots(2, 5, figsize=(30, 10))
    fig.tight_layout(pad=5.0)
    fig.subplots_adjust(
        left = 0.062,
        right = 0.97,
        bottom = 0.148,
        top = 0.88,
        wspace = 0.34,
        hspace = 0.383
    )


    plot_scores(scores, mapper, ax)
    plot_scores_3(scores_3, mapper_3, ax)

    print('\n\
        #########################################\n\
        ##                                     ##\n\
        ##          BEST MODEL FOUND           ##\n\
        ##       (HYPER PARAMETER TUNING)      ##\n\
        ##                                     ##\n\
        #########################################\n\
        \n')
    pprint(best_model.get_params())
    print('\nTrain Accuracy:\t{:0.3f}'.format(clf.score(X_train, Y_train)))
    print('\nTest  Accuracy:\t{:0.3f}\n\n'.format(clf.score(X_test, Y_test)))

    print("Time elapsed  =  {} s\n".format(time.time()-start))
    print("\n============== SOLVED Q2 ==============\n")
    
    plt.show()