## TO DO Experimental. Applications for encode and decode sequence data when follows a math pattern extrapolable with the method. Functional encoding 

(TO DO Solve Frequency)

A funcional encoding is not posible for now, many datasets needs to be evaluated and functions executed to convert data to funcions. And no way is known to convert data to function expresions in a standarized way. No methods are known to represent data inside a dataset with different values who can gent the same value of data than his neighbor or other sequence group values, have the same symbol to represent it and use the order in the function to asign the value.

In each base of information representation information value is represented with a unique symbol composed by the minium expresion of information, the bit.

In a funcional encoding system the information is composed by the information who generates the information.

Any function can be defined in a logic algorithm by his functional information, the frequency, the order and the value

Most of OEIS sequences, A...,A.....,A....,A....,A..... , who can be solved by Probnet can be finded in image, video, sound.

Uncertain sequences not registered in OEIS can be solved with Probnet, or create.



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

This is of course, a perfect case, but when in case of data is not homogeneous,more than une function represents the data set, you reduce the data map to small reducced symbols, like in the example.


### Decode data sequence

Convert encoded probnet function parameters to data sequence

Convert encoded data sequence to real data converting each symbol by his element in the dictionary function data secuence .

        - get dictionary function
	- replace funcion data secuence by function elements to generate the real data sequence
	- output results
	- return no function dictionary was found , or no functionon decoding for this sequence, if input data is not in the correct data type.


Allways when data source can be grouped in data sequences in order of symbols of function method are less than original input, the data can be encoded reducing the symbols in a expresion with probnet method.

Actual data encoding/compression is based in the number of repetitios of a symbol in a dataset. The functional encoding is based in the conversion of data in functions.

This funcional method with 3 parameters is restricted to represent 

number of functions = (param1_nbits+param2_nbits+param3_nbits ...)^nparams - 1.

## Encoding Computation cost .

Each chunk of data needs to be processed discarting elements to compare if is a predictable data . The cost is related for N symbols int the size of the dataset for each chunk of data. The way to do this task in the better way is analized at this moment by the team to improve the computation cost. Basically each funcion search for the next element in the order of the funcion to replace by a symbol.

## Converting the data to predictable functions.

For hight entropy and low entropy with Probnet predictable.

	- Extract de different patterns and index to encode de funcion if is predictable

For hight entropy data:

A way to reduce the funcion elements is looking for series of divisors, we know the algorithm can solve many polinomic sequences, calculating instead of when many times a symbol appears in a data set, first, in a group of divisors, for example if many data is divisor of 6 you know withot making any kind of combination, permutation , by this way the better way to know with funcion representation is more apropiate we need to mesure the entropy of the information factors, and group the information by them.

Imagige we have a data set composed by 5 groups of different divisors some of there in different function order:

the ranges can be definedd as a difference of two elements 25-50

To split the information of a sequence we need to to convert in each kind of information in the data set:

	- Order
	
	The order is the information dataset in reference of the direction of the patern, or the subpatern of directions
	
	- Frequency
	
	The frecuency is the data set who is related with each time what appears. Is expresed in distances of the las time who appears
	
	- Value
	
	Is related by a geometric difference from the nearest element.
	

divisors of 2 ( TO DO )

	
	discard if the order probability is over the limit
	
	discard if the frequency probability is over the limit
	
	convert to divisors the values who increase, and divisors who decrease
	
	get the spaces among them them

	Now 2 datasets are made , who increase, who decrease, we have already converted the information to posible predictable patterns
	
	When the data is predictable save (range, p1, p2 , p3 ) as a function and add a symbol (range,p1,p2,p3,*), 5 parameters
	
	When the data is predictable save (symbols(*),distance_from_near), 2 parameters, for each data in the data set, to mantain the order and predict the value.
	When the data is not predictable save (value) (no encoding improvement)
	
	Whe have now a system composed by distances and geometric change factors, and all symbols are reduced to the minimal probnet function expresion.
	
	This method can be done recursivelly jumping unnedeed combinations or discartings.
	
	Each team you repeat a function dictionary just with the symbol change
	
	For final file encoding:
		
		Apply LZ
		Apply Huffman
	

divisors of 3

...

divisors of 5

...

divisors of 7


Any information can be splited in datasets of factor groups.


## (TO DO) Random entropy VS Probnet

- Test with perfect data sequences

- Test with hight entropy data secuences


## (TO DO) Atificial intelligence VS Probnet


- Test Probnet VS XGBOOST


- Math series


- Random Data
