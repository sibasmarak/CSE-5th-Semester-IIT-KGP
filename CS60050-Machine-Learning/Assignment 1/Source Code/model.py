"""
This python file contains the class for the construction of the dcision tree 
from the input dataset and then forms regression tree out of it using the ID3 
algorithm and Variance as an measure of impurity
."""

# Authors: Debajyoti Dasgupta <debajyotidasgupta6@gmail.com>
#          Siba Smarak Panigrahi <sibasmarak.p@gmail.com>

import utility


class node:
    '''
    This is the main node class of the decision tree
    This class contains the skeleton of the structure 
    of each node in the decision tree. 
    '''

    def __init__(self, attr, val, mean, mse):
        '''
        This function is the constructor to initialize the 
        values in the node object.

        Parameters
        ----------
        attr: [String] the decision attribute that has been selected 
                for this node on the basis of which the 
                children will be decided

        val: [Float] the value of the selected attribute on the 
                basis which the splitting of the children 
                nodes will be decided for the current node

        mean: [Float] mean of the attributes ( selected in the current 
                level ) of the training data, this will help in 
                making predictions at this node if it is a leaf

        mse: [Float] mean squared error of the attributes ( selected in the 
                current level ) of the training data, this will help 
                in making decisions for pruning
        '''
        self.attr = attr
        self.split = val
        self.mse = mse
        self.mean = mean
        self.left = None
        self.right = None

    def remove_children(self):
        '''
        This function is a helper function for the pruning step
        the following function removes the children of the current node

        '''
        self.right = None
        self.left = None
        self.attr = 'Increase rate'

    def restore(self, attr, left, right):
        '''
        This function will restore the  children nodes of the current 
        node during the pruning process if you decide not to remove 
        the cchildren of the current node

        Parameters
        ----------
        attr: the attribute of the current node
        left: left child of the current node
        right: right child of the current node 
        '''
        self.attr = attr
        self.left = left
        self.right = right

    def count_node(self):
        '''
        This function is a helper funcction which is used to recursively 
        count the number of nodes in the tree rooted at the given node 

        Returns
        -------
        num_nodes: this is the number of nodes in the sub tree rooted 
                    at the current node 
        '''
        num_nodes = 1
        if self.left != None:
            num_nodes += self.left.count_node()
        if self.right != None:
            num_nodes += self.right.count_node()
        return num_nodes

    def prune(self, decision_tree_root, cur_error, X_valid):
        '''
        This function is the main pruning function. This function 
        will first recursively prune the children of the current node
        then will decide whether to prune the correct node or not 

        Parameters
        ----------
        decision_tree_root: this is the root of the actual decision tree
                            which is to be pruned and the current node 
                            resides inside the tree rooted at this node

        cur_error:  cur_error stores the current minimum error that can 
                    be achieved by the decision tree rooted at decision 
                    tree root

        X_valid: Validation set of the data that is used for the pruning 
                    achieved
        Returns
        -------
        err: this is the current minimum error that the tree has  
                till now

        '''
        if self.left == None and self.right == None:
            return 10**18
        if self.left != None:
            self.left.prune(decision_tree_root, cur_error, X_valid)
        if self.right != None:
            self.right.prune(decision_tree_root, cur_error, X_valid)

        cur_error, _ = predict(decision_tree_root, X_valid)

        # store the data of the children nodes in temporary variable
        temp_left = self.left
        temp_right = self.right
        temp_attr = self.attr
        self.remove_children()

        # calculate the error on the new decision tree
        err, _ = predict(decision_tree_root, X_valid)

        # print(err, cur_error)

        # if the error on the new decision tree increases then
        # restore the children of the current node
        if err > cur_error or decision_tree_root.count_node() <= 5:
            self.restore(temp_attr, temp_left, temp_right)



def construct_tree(samples, current_height, max_height, attr_list):
    '''
    This function is the main function the handles the construction 
    of the entire decision tree handling all the steps. This function 
    implements the ID3 algorithm with the help f the utility functions 

    Parameters
    ----------
    samples:    Contains the data samples on the basis of which the 
                regression tree is to be constructed. This contains 
                a list of dictionaries where the keys are the attributes

    current_height: this represents the current height upto which the 
                    tree has already been built

    max_height: this is the constraint, which represents the maximum 
                height upto which the tree must be built

    attr_list: it is the list of attributess from which we make the 
                selection of the data

    Returns
    -------
    head: the head of he decision tree rooted in the current root
    '''

    # if the max height is reached then return
    if current_height == max_height or len(samples) == 0:
        return None

    # if we have one data only then store it in the node and
    # consider this as the prediction alue for this node also
    if len(samples) == 1:
        return node('Increase rate', samples[0]['Increase rate'], samples[0]['Increase rate'], 0)

    # select the best attribute to be selected for this node
    # with the help of the utility functions
    attr, split, mse = utility.good_attr(samples, attr_list)
    samples1, samples2, mean = [], [], 0

    for i in samples:
        mean += i['Increase rate']
        if i[attr] <= split:
            samples1.append(i)
        else:
            samples2.append(i)

    # consider the mean as the prediction for the current node
    mean /= len(samples)

    # recursively build the left and the right children of
    # the current node and the return this node as the head
    head = node(attr, split, mean, mse)
    head.left = construct_tree(
        samples1, current_height+1, max_height, attr_list)
    head.right = construct_tree(
        samples2, current_height+1, max_height, attr_list)
    if head.left == None and head.right == None:
        head.attr = 'Increase rate'
        head.split = head.mean

    return head


def predict_one(decision_tree, data):
    '''
    This function is used for prediction of a singe sample
    In this we do a depth first search through the decision
    tree with the help of the attribute stored in the nodes 

    Parameters
    ----------
    decision_tree:  this is the root node of tje decision tree that
                    will help to make the prediction

    data:   the dictionary which contains the attribute and thier 
            corresponding valuies. The prediction will be made 
            for this data

    Returns
    -------
    the prediction value ( stored in the node attributes ) when 
    the leaf node is reached
    '''

    # if the leaf node is reached thenreturn the prediction
    # stored at this node
    if decision_tree.left == None and decision_tree.right == None:
        return decision_tree.mean

    # based on the decision either recurse to the left
    # or the right half until the leaf node is reached
    if data[decision_tree.attr] <= decision_tree.split:
        return predict_one(decision_tree.left, data)
    return predict_one(decision_tree.right, data)


def predict(decision_tree, data):
    '''
    This function is used for predistion of a multiple samples
    In this function we make use of the function predict_one 
    for each item in the data list

    Parameters
    ----------
    decision_tree:  this is the root node of tje decision tree that
                    will help to make the prediction

    data:   the list of dictionaries which contains the attribute 
            and thier corresponding valuies. The prediction will be 
            made for each datum in this list of data

    Returns
    -------
    mse: the average mean squared error for each item in the data

    preds: the predictions for the data points in data. The 
            predictions is returned as a list
    '''

    mse, preds = 0, []
    for i in data:

        # make prediction for the current data point
        val = predict_one(decision_tree, i)
        # insert the prediction in the prediction array
        preds.append(val)
        mse += (val-i['Increase rate'])**2

    # calculate the average error
    mse = mse/len(data)
    return mse, preds
