# Probnet 

## Usage 

````haskell

ghci Probnet.hs

````

````haskell

> probnet 1 [1,2,3,5,8]

[1,2,3,5,8,13]

````

## Geometric Extrapolation of Integer Sequences with error prediction


## The problem


In many situations, we have finite sequences of integer values, and we would like to predict which would be the next one, or the next several ones, without the knowledge of the mathematical definition of the sequence. 

A solution based just on the available data has applications on the following areas, among others:

- time series forecasting
- uncertain prediction
- data modeling
- risk modeling
- data encoder decoder

## A geometric way of prediction 


### Simple base solution

We start with a simple geometric solution, that is to calculate the ratio (quotient) of the last value relative to the previous one, and apply it to the last value to calculate the next one. 

For example, if we have some values of the Fibonacci sequence: 

    fibo = [1,2,3,5,8,13]

we get the ratios of each element relative to its previous one: 

    percents fibo
    [2.0,1.5,1.6666666666666667,1.6,1.625]

Then, we predict the next element as the product of the last element by the last ratio: 

    13 * 1.625 = 21.125


### Improving the result with the prediction of the error

We can get the predicted value for each subsequence of initial values of the original sequence. 

    drop 2 (inits fibo)
    [[1,2],[1,2,3],[1,2,3,5],[1,2,3,5,8],[1,2,3,5,8,13]]

    fmap predict1 it
    [4.0,4.5,8.333333333333334,12.8,21.125]

Then, we can calculate the difference between the predicted value and the real value. This way, we get a sequence of the errors, and we can calculate the predicted value of the next error, wich we will add to the simple prediction, notably improving the result. 

    err = zipWith subtract it (drop 2 fibo)
    [-1.0,0.5,-0.3333333333333339,0.1999999999999993]

    predict1 it
    -0.1333333333333331

    21.125 - 0.1333333333333331 = 20.991666666666667

We round the result to get the integer predicted value. 


### Sequences with quasi-cyclic pattern

When a sequence is not monothonic, we assume that it has a repetitive pattern, so that the ratio used for prediction will be the one of the element whose value is closest to the last element. 

For example, in the next sequence, the value closest to the last one is the first `3`, and the ratio of that position is `4/3`, so the predicted value will be `3*(4/3)`:

    percents [1,2,3,4,5,1,2,3,4,1,2,3]
    [2.0,1.5,1.3333333333333333,1.25,0.2,2.0,1.5,1.3333333333333333,0.25,2.0,1.5]

    predict1 [1,2,3,4,5,1,2,3,4,1,2,3]
    4.0


### Recursive layers of predictions

Once we have predicted the next value of a sequence, we can append it to the original sequence and predict another element. We can do this as many times as we want. We call "layers" to the number of recursions. Then, if we apply 3 layers to our fibonacci secuence `fib = [1,2,3,5,8,13]`, we get 3 more values: 

    probnet 3 fibo
    [1,2,3,5,8,13,21,34,55]


## Problems and limitations

The geometric way, that is, a way based on ratios of values, can only be valid for non-zero values, and is not suitable for sequences with negative and positive values. In that case it should be more appropiate the use of a usual diferential method, which can be very simmilar to the one presented here, but using diferences of elements instead of quotients of elements. 

The case of zero values is not solved here. The function will just return an error if any element is 0. 


## Tecnical details

### Data types

The type signature of the function is such that any `RealFrac` data type can be used for the values of the elements in the input sequence. The internal calculations will be done in that data type, preserving the precicion of it. 

For example, if the type is a 32 bit `Float`, the calculus would be made with about 21 decimal digits of precision, but if the input elements are `Rational`, the intermediate calculus would preserve infinite precision, until the rounding for the Ìnteger` output. That is the reason for importing `Data.Ratio`. 

    fibo = [1,2,3,5,8,13 :: Float]
    predic1 fibo
    21.125

    fibo = [1,2,3,5,8,13 :: Rational]
    predict1 fibo
    169 % 8

It also implies that the input sequence can not be of any `Integral` type, it must be previously converted to a `RealFrac` type by using, for example, `fromInteger` conversion function. It is done this way on the testing file `test-probnet.hs`. 

### Arithmetic equivalent method

It can be noticed that an arithmetic, instead of geometric, method for the extrapolation can be coded by just changing the `quotient` `sub-function in the `percents` function by the standard `subtract`, and the product (*) in the `predict1` function by addition (+).

Such method would not require that every element in the sequence be different than 0, and the method would be suitable for sequences with negative and positive values. 


## Testing

The file `test-probnet.hs` contains a function `testoeis` to bulk testing the function `probnet` against a range of OEIS sequences, giving the numbers after the 'A' on the OEIS sequence ID. 

    testoeis 1 20
    [("A3",[1,1,1,1,2,2,1,2,2,2,3,2,2,4,2,2,4,2,3,4,4,2,3,4,2,6,3,2,6,4,3,4,4,4,6,4,2,6,4,4,8,4,3,6,4,4,5,4,4,6,6,4,6,6,4,8,4,2,9,4,6,8,4,4,8,8,3,8,8,4,7,4,4,10,6,6,8,4,5,8,6,4,9,8,4,10,6,4,12,8,6,6,4,8,8,8,4,8,6,4]),("A12",[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])]

The testing is made using just the first 10 values for predicting the 11 one, and comparing it with the real 11th element, counting it as valid when both, predicted and real, are equal. 


## TO DO Experimental. Applications for encode and decode sequence data when follows a math pattern extrapolable with the method. Functional encoding 

### Encode data sequence

Convert data sequence to f = (index,frac1,frac2,frac3,longitude)

Convert data secuence to a function / symbol dictionary and replace sequence patterns for the symbol

example parse 1,2,3,4,5,8,16.... / output -> (.,30,1,1,1),(,,10,2,4,8) .....,,

The idea is convert different values in the same symbol, always the data value is in the sequence, in decode moment, replace the function symbol by the element in the index of the data sequence.

	- add split patterns function to the dictionary
	- rewrite sequence to new function symbols
	- rewrite base for encoding
	- output dictionary + rewrited symbols sequence
	- Compare bit size to ensure encoding improvement, otherwise return the same data

To find the proper functions just to calculate the entropy of the data by frequency. Match more popular factors in the data set and elaborate functions/symbol for each one following the steps, always use less bits symbols to replace the most popular functions in the data set.

The content data of 20 elements of the sequence fibonacci can be stored in (20,1,1,2) something less than :

[1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025]


Compresed in lzma :

4 -rw-r--r-- 1 user user 103 Apr 25 11:55 testen2.lzma

Probnet Storage (20,1,1,2):

4 -rw-r--r-- 1 user user 9 Apr 25 11:57 testfunction.txt

103 bytes vs 9 , and less with better encoding for decimal data for this case, because just are 3 symbols x 2 bit for each one , 6 bits


### Decode data sequence

Convert encoded probnet function parameters to data sequence

Convert encoded data sequence to real data converting each symbol by his element in the dictionary function data secuence .

        - get dictionary function
	- replace funcion data secuence by function elements to generate the real data sequence
	- output results
	- return no function dictionary was found , or no functionon decoding for this sequence, if input data is not in the correct data type.


Allways when data source can be grouped in data sequences in order of symbols of function method are less than original input, the data can be encoded reducing the symbols in a expresion with probnet method.

Actual data encoding/compression is based in the number of repetitios of a symbol in a dataset. The functional encoding is based in the conversion of data in functions.

Author - Vicent Nos Ripolles

Dev Pedro S

Dev Enrique S

All rights are reserved for commercial purposes of any derivatives of this document and source code. 
