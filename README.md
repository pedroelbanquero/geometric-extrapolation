# Geometric Extrapolation of Integer Sequences

Author - Vicent Nos Ripolles


## The problem

In many situations, we have finite sequences of integer values, and we would like to predict which would be the next one, or the next several ones, without the knowledge of the mathematical definition of the sequence. 

A solution based just on the available data has applications on the following areas, among others:

- time series forecasting
- uncertain prediction
- data modeling
- risk modeling


## Simple base solution

We start with a simple geometric solution, that is to calculate the ratio (quotient) of the last value relative to the previous one, and apply it to the last value to calculate the next one. 

For example, if we have some values of the Fibonacci sequence: 

    fibo = [1,2,3,5,8,13]

we get the ratios of each element relative to its previous one: 

    percents fibo
    [2.0,1.5,1.6666666666666667,1.6,1.625]

Then, we predict the next element as the product of the last element by the last ratio: 

    13 * 1.625 = 21.125


## Improving the result with the prediction of the error

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


## Sequences with quasi-cyclic pattern

When a sequence is not monothonic, we assume that it has a repetitive pattern, so that the ratio used for prediction will be the one of the element whose value is closest to the last element. 

For example, in the next sequence, the value closest to the last one is the first `3`, and the ratio of that position is `4/3`, so the predicted value will be `3*(4/3)`:

    percents [1,2,3,4,5,1,2,3,4,1,2,3]
    [2.0,1.5,1.3333333333333333,1.25,0.2,2.0,1.5,1.3333333333333333,0.25,2.0,1.5]

    predict1 [1,2,3,4,5,1,2,3,4,1,2,3]
    4.0


## Recursive layers of predictions

Once we have predicted the next value of a sequence, we can append it to the original sequence and predict another element. We can do this as many times as we want. We call "layers" to the number of recursions. Then, if we apply 3 layers to our fibonacci secuence `fib = [1,2,3,5,8,13]`, we get 3 more values: 

    probnet 3 fib
    [1,2,3,5,8,13,21,34,55]


## Testing

The file `test-probnet.hs` contains a function `testoeis` to bulk testing the function `probnet` against a range of OEIS sequences, giving the numbers after the 'A' on the OEIS sequence ID. 

    testoeis 1 20
    [("A3",[1,1,1,1,2,2,1,2,2,2,3,2,2,4,2,2,4,2,3,4,4,2,3,4,2,6,3,2,6,4,3,4,4,4,6,4,2,6,4,4,8,4,3,6,4,4,5,4,4,6,6,4,6,6,4,8,4,2,9,4,6,8,4,4,8,8,3,8,8,4,7,4,4,10,6,6,8,4,5,8,6,4,9,8,4,10,6,4,12,8,6,6,4,8,8,8,4,8,6,4]),("A12",[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])]





