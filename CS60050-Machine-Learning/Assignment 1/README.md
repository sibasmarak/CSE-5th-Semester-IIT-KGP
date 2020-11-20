# Brief Description:  
This directory contains the following files:  
- `Assignment_1B.pdf`: Description of problem statement  
- `PercentageIncreaseCOVIDWorldwide.csv`: Contains the data used for training the Decision Tree Regressor    
- `model.py`: Contains all the necessary functions and implementation of ID3 Algorithm for Regression problems   
- `problems.py`: Contains the solution to problems provided in the `assignment.pdf`  
- `requirements.txt`: Contains all the necessary dependencies and their versions  
- `utility.py`: Contains all the helper functions used by the above files (if any)  

# Directions to use the code  
1. Download this directory into your local machine

2. Copy the  PercentageIncreaseCOVIDWorldwide.csv file in the Source Code Directory

3. Ensure all the necessary dependencies with required version and latest version of Python3 are available (verify with `requirements.txt`)  <br>
 `pip3 install -r requirements.txt`

4. Run specific functions with the aid of `problem.py` <br>
 `python3 problem.py`

5. The image of the final decision tree will be created in the same directory as the Source Code

# For giving the input height for the Question 1
- Using the default full height <br>
`python3 problems.py`

- Giving input height (say 5) -- height should be a positive integer or -1 <br>
`python3 problems.py --height 5`

- For more help regarding the arguments <br>
`python3 problems.py --help`

# For Windows Users
1. Make sure Graphviz is installed
- `Install chocolatey`
- `choco install graphviz`
2. Make sure Graphviz is added in the PATH

# For Linux Users
1. Make sure Graphviz is installed
- `sudo apt-get install graphviz`
