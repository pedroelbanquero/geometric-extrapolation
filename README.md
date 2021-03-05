# probabilistic-extrapolation

Author - Vicent Nos Ripolles

probabilistic extrapolation on incremental series algorithm. A ciclic probabilitiy prediction based on difference layers on a data set

Applications 

- time series forecasting

- uncertain prediction

- data modeling

- risk modeling

## Fraction patterns

Any dataset can be translated to a difference patter

[1,2,3,4,5,6,7] -> [2-1, 3-2, 4-3, 5-4,6-5 ,7-6] = [1,1,1,1,1,1]

Any dataset can be translated toa a probability difference pattern

[1,2,3,4,5,6,7] -> [1*100/2,2*100/3,3*100/4,4*100/5,5*100/6,6*100/7] -> [50.0,66.66666666666667,75.0,80.0,83.33333333333333,85.71428571428571]

## Serie pattern layers

Any fraction pattern can be generate n⁻1+n-2 .. n probabilistic patterns

[50.0,66.66666666666667,75.0,80.0,83.33333333333333,85.71428571428571]

[75.0,88.8888888888889,93.75,96.0,97.22222222222221]

[84.37499999999999,94.81481481481484,97.65625,98.74285714285715]

[88.98925781249996,97.0903703703704,98.89955873842592]

[91.65611118078226,98.1706810514286]

[93.36403720451572]


## Prediction 

Las probability * last data value in the serie predict the next

7*100/85.71428571428571 = round 8.16 = 8

## Error Prediction

The difference between the prediction and the reality originate a error pattern, a serie who describes how increase or decreas the error in his expansion.

On the serie [1,2,3,4,5,6,7]

Whe can predict the next error computing the difference of the 7 element in the serie with [1,2,3,4,5,6] and maque the sum with 7

6*100/83.33333333333333  == 7.2

7 - 7.2 = - 0.2 = error estimation

## Error Pattern layers


5*100/80 = 6.25

6*100/83.33333333333333  == 7.2

percents 0.25 0.2 = 86.80555555555556

-0.2*100/86.80555..6 = - 0.16

## Prediction with error correction

Just sum prediction and the error prediction 8.16 + (-0.16) = 8 is the next result  

## Probabilistic base recovery from dataset

## Cyclic patterns 

- Cicle pattern


- Probability Extrapolation Cycle

````haskell

probability_periods [1,2,3,4,5,1,2,3,4,1,2,3]

[4,1,3,1,2]


````
The funcion split the serie in up patterns and down patters, how many of each one, 5 up , 1 down, 3 up, 1 down, 2 up


## Error Cycles

Sometimes the errors announces cylic behaviour

[0,0,1,0,0,1,0,0,1]

In the OEIS serie A000X the algorithm will fail each 2 numbers

Applying the error cycle pattern we solve the error in many serie with this kind of behaviour.


## Drawing models

````haskell

drawpo [1,2,3,4,5,6] [1,2,3,4,5,6,7,8,9]

````





## Limits of probabilistic extrapolation for 100 % precision

- The data set is incremental

- No contain a pattern generated with prime numbers

- Is not a curve

- Frequency not more than .....

- Amplitude change no more than  ...


## OEIS series with probabilistic extrapolation solution

Solves Around 20 % osis series with a unique function

![Video Test Probnet](https://github.com/pedroelbanquero/probabilistic-extrapolation/video_2021-03-05_02-19-18.mp4)

| Serie | Function | Probability extrapolation cordenates |
| ----- | -------- |  ----------------------------------- |


## Generate series

- Command

````haskell
probnet [1,2,3,4,5,6] 10

-- Result 

[1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0]

````
