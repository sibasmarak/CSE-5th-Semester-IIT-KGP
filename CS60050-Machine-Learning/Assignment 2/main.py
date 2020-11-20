import time
import argparse
import random
import numpy as np
import matplotlib.pyplot as plt
from pprint import pprint
from sklearn.decomposition import PCA
from data_processor import prepare, normalize,  remove_outliers, sequential_backward_selection
from model import evaluate_algorithm, naive_bayes, get_test_accuracy
from utils import load_csv, train_test_split


def autolabel(rects):
    """
    Attach a text label above each bar, displaying its height.
    """
    for rect in rects:
        height = rect.get_height()
        ax.annotate('%.3f' % height,
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom')

if __name__ == '__main__':
    start = time.time()

    ######################  Q1  ########################

    parser = argparse.ArgumentParser()
    parser.add_argument("--frac", help="Fraction of the dataset to test on (Default 1: Full Data)")
    parser.add_argument("--outlier", help="Outlier Threshold for Part 3 (Default 3: Max number of outliers)")
    args = parser.parse_args()
    
    # Default values
    frac = 1.
    outlier = 3
    
    # parse arguments
    if args.frac: frac = float(args.frac)
    if args.outlier: outlier = int(args.outlier)

    filename = 'Train_B.csv'
    print("\n ============= READING DATA ============ \n")
    dataset = load_csv(filename)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= DATA READ ============ \n\n")
    cols = dataset.pop(0)
    print("\n ============= FEATURES ============ \n\n")
    pprint(cols)

    if frac < 1.:
        random.shuffle(dataset)
        dataset = dataset[:int(frac*len(dataset))]

    print('\n\n\
        /////////////////////////////////\n\
        //                             //\n\
        //         SOLVING Q1          //\n\
        //                             //\n\
        /////////////////////////////////\n\n\
        ')
    
    post_process_dataset = prepare(dataset,cols,start)
    train, test = train_test_split(dataset)
    print("============= TRAIN TEST SPLIT COMPLETE ============\n")
    print("train data size: {}, test data size = {} \n\n".format(len(train), len(test)))

    n_folds = 5
    print("NUMBER OF FOLDS (cross validation) = {}".format(n_folds))
    
    print("\n============== TRAINING STARTED ============\n")
    scores, summary = evaluate_algorithm(train, naive_bayes, n_folds)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= TRAINING FINISHED ============ \n\n")
    print('\
        ////////////////////////////////\n\
        /////////    SCORES    /////////\n\
        ////////////////////////////////\n\
    ')
    for i in range(n_folds):
        print('ITERATION {}  ===>   SCORE = {}'.format(i+1,scores[i]))

    train_acc = sum(scores) / len(scores)
    test_acc = get_test_accuracy(test, summary)

    print("\nMODEL SCORES:")
    print("Train Accuracy: {}".format(train_acc))
    print("Test  Accuracy: {}\n".format(test_acc))

    ######################  Q2  ########################

    print('\n\n\
        /////////////////////////////////\n\
        //                             //\n\
        //         SOLVING Q2          //\n\
        //                             //\n\
        /////////////////////////////////\n\n\
        ')
    
    pca = PCA(n_components=17)
    dataset = [[i[j] for j in range(len(i)-1)] for i in train]
    pca.fit(dataset)

    var = pca.explained_variance_ratio_[:] #percentage of variance explained
    labels = ['PC' + str(i+1) for i in range(len(var))]

    fig, ax = plt.subplots(figsize=(15,7))
    plot1 = ax.bar(labels, var)

    ax.plot(labels,var)
    ax.set_title('Proportion of Variance Explained VS Pricipal Component')
    ax.set_xlabel('Pricipal Component')
    ax.set_ylabel('Proportion of Variance Explained')
    autolabel(plot1)

    cumsum = [i for i in var]
    nc = -1
    for i in range(1,len(cumsum)):
        cumsum[i] += cumsum[i-1]
        if cumsum[i] >= 0.95 and nc == -1:
            nc = i+1

    fig, ax = plt.subplots(figsize=(15,7))
    plot2 = ax.bar(labels, cumsum)

    # Add some text for labels, title and custom x-axis tick labels, etc.
    ax.set_ylabel('Variance Ratio cummulative sum')
    ax.set_xlabel('number principal components')
    ax.set_title('Variance Ratio cummulative sum VS number principal components')
    ax.set_xticks(np.arange(len(labels)))
    ax.set_xticklabels(labels)

    ax.axvline('PC'+str(nc), c='red')
    ax.axhline(0.95, c='green')
    ax.text('PC5', 0.95, '0.95', fontsize=15, va='center', ha='center', backgroundcolor='w')
    autolabel(plot2)

    print('Number of Components selected:{}'.format(nc))
    print('Variance captured: {}'.format(cumsum[nc-1]))
    pca = PCA(n_components=nc)
    dataset = pca.fit_transform(dataset).tolist()
    normalize(dataset)
    for i in range(len(dataset)):
        dataset[i].append(train[i][-1])

    print("\n============== TRAINING STARTED =============\n")
    scores, summary = evaluate_algorithm(dataset, naive_bayes, n_folds)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= TRAINING FINISHED ============ \n\n")
    print('\
        ////////////////////////////////\n\
        /////////    SCORES    /////////\n\
        ////////////////////////////////\n\
    ')
    for i in range(n_folds):
        print('ITERATION {}  ===>   SCORE = {}'.format(i+1,scores[i]))

    train_acc = sum(scores) / len(scores)
    test_acc = get_test_accuracy(test, summary)

    print("\nMODEL SCORES:")
    print("Train Accuracy: {}".format(train_acc))
    print("Test  Accuracy: {}\n".format(test_acc))

    print('NOTE: Plots will be shown after Q3 is finished')


    ######################  Q3  ########################

    print('\n\n\
        /////////////////////////////////\n\
        //                             //\n\
        //         SOLVING Q3          //\n\
        //                             //\n\
        /////////////////////////////////\n\n\
        ')
    
    train_without_outliers = remove_outliers(train, outlier)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= OUTLIERS REMOVED ============ \n")
    print("train data size: {} \n\n".format(len(train)))

    scores, summary = evaluate_algorithm(train_without_outliers, naive_bayes, n_folds)
    
    train_acc = sum(scores) / len(scores)
    test_acc = get_test_accuracy(test, summary)

    print("MODEL SCORES:")
    print("Train Accuracy: {}".format(train_acc))
    print("Test  Accuracy: {}\n".format(test_acc))

    target = cols.pop(-1)
    print("\n ============= SEQUENTIAL BACKWARD SELECTION STARTED ==============")
    train, new_cols, removed, acc_new = sequential_backward_selection(train_without_outliers, cols, naive_bayes, train_acc)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= SEQUENTIAL BACKWARD SELECTION COMPLETED ============")
    print('Accuracy: {}\n'.format(acc_new))

    print('============== REMOVED FEATURES ==============')
    pprint(removed)
    print()
    print('============   SELECTED FEATURES   ===========')
    pprint(new_cols)
    print()
    print('==============   TARGET FEATURE  ==============')
    pprint(target)
    print()

    train = normalize(train)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= DATA NORMALIZED ============ \n")
    
    print("\n============== TRAINING STARTED =============\n")
    scores, summary = evaluate_algorithm(train, naive_bayes, n_folds)
    print("Time elapsed  =  {} s".format(time.time()-start))
    print("\n ============= TRAINING FINISHED ============ \n\n")
    
    print('\
        ////////////////////////////////\n\
        /////////    SCORES    /////////\n\
        ////////////////////////////////\n\
    ')
    for i in range(n_folds):
        print('ITERATION {}  ===>   SCORE = {}'.format(i+1,scores[i]))

    train_acc = sum(scores) / len(scores)
    test_acc = get_test_accuracy(test, summary)

    print("\nMODEL SCORES:")
    print("Train Accuracy: {}".format(train_acc))
    print("Test  Accuracy: {}\n".format(test_acc))

    print('========== ALL QUESTIONS SOLVED SUCCESSFULLY !! =========')
    print('TIME TAKEN = {} s'.format(time.time()-start))

    plt.show()