-- | Probnet 0.1.0.0
-- | Usage : probnet 1 [1,2,3,5,8,13]
-- | Result : [1,2,3,5,8,13,21]

module Probnet (
   percents,
   predict1, 
   predict, 
   probnet, 
) where

import Data.List
import Data.Ratio -- for the case of inputs with Ratio or Rational list elements

-- | Element value of 'list' nearest to 'n'
nearnum :: RealFrac a => a -> [a] -> a
nearnum n = minimumBy nearer
   where
   nearer x y = compare (abs (x - n)) (abs (y - n))

-- | Ratios between consecutive elements (logarithmic differences). 
percents :: RealFrac a => [a] -> [a]
percents dat = zipWith quotient dat (tail dat)
   
   where 
   quotient y = (/ y)

-- | Get ratio element
ratio1 d f = percents d !! f

-- | This is to assume that the next ratio is close to that of the element 
-- with the closest value to the last element; in case of monotonic data 
-- (always increasing or always decreasing) it is the last ratio. 


predict1 :: RealFrac a => [a] -> a
predict1 dat  
   | l > lastper = (ratio1 (dat) (eleml+1)) * last dat 
   | otherwise = (ratio1 dat eleml) * last dat
   where
   Just eleml = elemIndex ned dat
   ned = nearnum (last dat) (init dat)
   l = last $ init dat
   lastper = last dat 


-- | Generates new prediction
predict :: (Integral b, RealFrac a) => Int -> [a] -> [b]
predict layers dat 
   | layers > 1   = predict (layers - 1) out -- execute next in the serie
   | otherwise    = fmap round out
   where
   out = [predict1 dat] 

-- | Generate new prediction with error prediction 
probnet :: (Integral b, RealFrac a) => Int -> [a] -> [b]
probnet layers dat
   | layers > 1   = probnet (layers - 1) $ map (\x-> fromIntegral (round x)) out 
   | otherwise    = fmap round out
   where
   out = dat ++ [(predict1 dat + prerr dat)]

-- | This is the next prediction for the difference between each 
-- original element and its prediction based on previous elements
prerr :: RealFrac a => [a] -> a
prerr dat 
   | last err == 0   = 0 
   | otherwise       = predict1 $ drop 2 err
   where  
   err   = zipWith subtract pred dat -- differences between elements and its predictions
   pred  = fmap predict1 $ inits dat -- 2 first inits have 0 and 1 elements, will be dropped



-- | Encode data sequence
-- convert data sequence to f = (index,frac1,frac2,frac3,longitude)
-- TODO convert data secuence to a function / symbol dictionary and replace sequence patterns for the symbol
-- example parse 1,2,3,4,5,8,16.... / output -> (.,30,1,1,1),(,,10,2,4,8) .....,,
-- the idea is convert different values in the same symbol, in decode moment replace the function symbol by the element in the index of the data sequence.
--
encode dat = (l,f2-f1,f3-f2,f4-f3)
   where
   l = length dat
   f1 = dat !! 0
   f2 = dat !! 1
   f3 = dat !! 2
   f4 = dat !! 3
   -- add split patterns function to the dictionary
   -- rewrite sequence to new function symbols
   -- rewrite base for encoding
   -- output dictionary + rewrited symbols sequence
   -- return imposible to encode if no improve in the encodening comparing bit size are detected


-- | Encode function for files + lzma
--



-- | Decode data sequence
-- convert encoded probnet function parameters to data sequence
-- TODO convert encoded data sequence to real data converting each symbol by his element in the function data secuence in the dictionary.
decode encoded = probnet (i-(length encoded-1)) [fromIntegral f1,fromIntegral f2,fromIntegral f3,fromIntegral f4]
	where
	i = encoded!!0
	f1 = encoded!!1
	f2 = encoded!!2
	f3 = encoded!!3
	f4 = encoded!!4
	-- get dictionary function
	-- replace funcion data secuence by function elements to generate the real data sequence
	-- output results
	-- return no function dictionary was found , or no functionon decoding for this sequence




-- | Decode file to a file
-- 


-- | Property of Cobalt Technologies Panamá
-- | Authors : Vicent Nos Ripolles (Main Author)
-- | Enrique Santos (Refactor Code)

