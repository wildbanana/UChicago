# Name: Kim Ting Li
# hw3.py

##### Template for Homework 3, exercises 1 -  ######
import math #import math module
import random #import random module

# ********** Exercise 1 ********** 

# Define is_divisible function here
def is_divisible(m,n):
    if n==0:
        return 'zero denominator, test not defined'
    else:
        if m%n==0: 
            return True
        else:
            return False

# Test cases for is_divisible
## Provided for you... uncomment when you're done defining your function

#I think in Python 3, print becomes print(), and therefore I modified the code slightly
print(is_divisible(10, 5))  # This should return True
print(is_divisible(18, 7))  # This should return False
print(is_divisible(42, 0))  # What should this return?

# ********** Exercise 2 ********** 

# Define not_equal function here
def not_equal(m,n):
    if m==n:
        print(False)
    else:
        print(True)

# Test cases for not_equal
not_equal(5,6)
not_equal(7,7)
not_equal(12+2,13+6)
not_equal(4+6,5+5)
not_equal("sick","healthy")
not_equal("sick","sick")

# ********** Exercise 3 ********** 

## 1 - multadd function
def multiadd(a,b,c):
    result=a*b+c
    return result

## 2 - Equations

multiadd(3,5.5,2) #test the function works right


# Test Cases
angle_test = multiadd(math.cos(math.pi/4),1/2,math.sin(math.pi/4))
print("sin(pi/4) + cos(pi/4)/2 is:")
print(angle_test)

ceiling_test = multiadd(2,math.log(12,7),math.ceil(276/19))
print("ceiling(276/19) + 2 log_7(12) is:")
print(ceiling_test)


# ********** Exercise 4 **********

## 1 - rand_divis_3 function
def rand_divis_3():
    a=random.randint(0,100)
    print(a)
    if a%3==0:
        print(True)
    else:
        print(False)

# Test Cases
rand_divis_3()
rand_divis_3()