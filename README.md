# Statistics 462

This repository contains content, quizzes, assignments, and solutions for Statistics 462, [run by Aaron Springford](http://www.mast.queensu.ca/~aaron/stat462.html). The course mostly follows the book "Data Analysis and Graphics Using R: An Example-Based Approach" ("DAAG") by John Maindonald and W. John Braun.

In many cases, solutions exist in both python and R.

## Directory Layout

Content is organized into directories by its type.

```
    - stats462
        - assignments
        - lectures
        - quizzes
        - README.md
        - requirements_python.txt
        - requirements_R.txt
```

The `requirements_*` files are menat to list the software requirements to run any code you find in this project.

## Python Setup

In order to run the python code in this project, you should have python 3.5+ and `pip`. Once these are installed, you can create a virtual environment and run your code as shown below.

```
# Create virtual env in directory called "env"
python3 -m venv env
# Enter environment
source env/bin/activate
# If first time, install make sure pip is newest and install requirements
pip3 install --upgrade pip
pip3 install -r requirements_python.txt
# run your scripts
python3 my_script.py
# exit environment
deactivate
```

## R setup

In order to run the R code in this project, you will need R (r-base on linux).

**Not sure on installing packages in R - Rory**

