"""
This python file reads the data from the PercentageIncreaseCOVIDWorldwide.csv
dataset and then forms regression tree out of it using the ID3 algorithm and
Variance as an measure of impurity
"""


# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>

import argparse
import time
import random
import matplotlib.pyplot as plt
from utility import train_test_split, read_data, train_valid_split, get_accuracy, print_decision_tree
from model import construct_tree, predict, node


def randomize_select_best_tree(data, max_height, X_test):

    # print(max_height, len(data), len(X_test))
    if max_height == -1:
        max_height = 300

    attributes = ["Confirmed", "Recovered", "Deaths", "Date"]

    # set the local variables
    least_mse, tree, mse_avg, acc_avg = 10**18, None, 0, 0
    train, valid = None, None

    for _ in range(10):

        X_train, X_valid = train_valid_split(data) 
        decision_tree = construct_tree(X_train, 0, max_height, attributes)

        test_mse, _ = predict(decision_tree, X_test)
        test_acc = get_accuracy(decision_tree, X_test)

        if test_mse < least_mse:
            least_mse = test_mse
            mse_avg += test_mse
            acc_avg += test_acc
            tree = decision_tree
            train = X_train
            valid = X_valid

    mse_avg /= 10
    acc_avg /= 10
    return tree, train, valid, mse_avg, acc_avg


def randomize_select_best_height_tree(train, X_test):
    mse, height, cur_mse = [], [], 10**18
    decision_tree, ht = None, -1
    for h in range(1, 50):
        print("[---- Height {} -----] ".format(h), end = '')
        decision_tree_sample, temp_train, temp_valid, _, _ = randomize_select_best_tree(train, h, test)
        mse_test = predict(decision_tree_sample, test)[0]
        if mse_test < cur_mse and h > 4: 
            decision_tree = decision_tree_sample
            cur_mse = mse_test
            X_train = temp_train
            X_valid = temp_valid
            ht = h
        
        data_print(decision_tree_sample, train, X_test, valid)
        mse.append(mse_test)
        height.append(h)

    plt.title("test-mse vs height")
    plt.ylabel("test-mse")
    plt.xlabel("height")
    plt.plot(height, mse)

    return decision_tree, X_train, X_valid, ht


def data_print(tree, train, test, valid):
    print("train acc: {}, train mse: {}".format(
        round(get_accuracy(tree, train)*100,2), round(predict(tree, train)[0],2)), end=', ')

    # print("valid acc: {}, valid mse: {}".format(
    #     round(get_accuracy(tree, valid)*100, 2), round(predict(tree, valid)[0], 2)), end=', ')

    print("test acc: {}, test mse: {}".format(
        round(get_accuracy(tree, test)*100, 2), round(predict(tree, test)[0], 2)))


if __name__ == '__main__':
	# Feel free to change the seed below or comment out the following line
    random.seed(100000)
    start = time.time()

    
    parser = argparse.ArgumentParser()
    parser.add_argument("--height", help="maximum height of decision tree for Q1", type=int)
    args = parser.parse_args()
    ht = -1
    if args.height:
        ht = args.height

    print("\n ============= READING DATA ============ \n")

    DATA_FILE = 'PercentageIncreaseCOVIDWorldwide.csv'
    df = read_data(DATA_FILE)
    print("Time elapsed  =  {} ms".format(time.time()-start))
    print("\n ============= DATA READ ============ \n\n")

    train, test = train_test_split(df)
    print("============= TRAIN TEST SPLIT COMPLETE ============\n")
    print("train data size: {}, test data size = {} \n\n".format(
        len(train), len(test)))

    print("============== SOLVING Q1 ==============\n")
    # print("select a height ({greater then 0} or {-1}): ")
    # ht = int(input())
    print("height selected: {}".format(ht if ht != -1 else "Full Tree"))
    print("\n========= TRAINING STARTED =========\n")

    X_train = train
    start = time.time()
    tree, train, valid, mse_avg, acc_avg = randomize_select_best_tree(train, ht, test)
    print("Time elapsed  =  {} ms".format(time.time()-start))
    print("\n ============= TRAINING FINISHED ============ \n")
    print("Average Test Accuracy: {}\n".format(acc_avg * 100))
    print("Average Test MSE: {}\n".format(mse_avg))

    data_print(tree, train, test, valid)
    train = X_train
    print("\n============== SOLVED Q1 ==============\n")

    print("\n============== SOLVING Q2 ==============\n")
    print("\n========= TRAINING STARTED =========\n")

    start = time.time()
    tree, train, valid, ht = randomize_select_best_height_tree(train, test)
    print("Time elapsed  =  {} ms".format(time.time()-start))
    print("\n ============= TRAINING FINISHED ============ \n")
    print("BEST TREE: height = {}".format(ht))
    data_print(tree, train, test, valid)

    print("\n============== SOLVED Q2 ==============\n")

    print("\n============== SOLVING Q3 ==============\n")
    print("[==== BEFORE PRUNING ====] Valid acc: {}, Valid mse: {}, number of nodes = {}".format(get_accuracy(tree, valid)*100, predict(tree, valid)[0], tree.count_node()))
    tree.prune(tree, predict(tree, valid)[0], valid)
    print("[==== AFTER PRUNING ====] Valid acc: {}, Valid mse: {}, number of nodes = {}\n".format(get_accuracy(tree, valid)*100, predict(tree, valid)[0], tree.count_node()))
    data_print(tree, train, test, valid)

    print("\n============== SOLVED Q3 ==============\n")

    print("\n============== SOLVING Q4 ==============\n")
    print('\n SAVING =====> \n')
    print_decision_tree( tree )
    print('The image of the graph is saved as [ decision_tree.gv.pdf ]')
    print("\n============== SOLVED Q4 ==============\n")
    
    plt.show()
