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
import Math.NumberTheory.Roots

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
   -- | l1 == (eleml+1) = (ratio1 (dat) (eleml+1)) * last dat 
   | otherwise = (ratio1 dat eleml) * last dat
   where
   Just eleml = elemIndex ned dat
   ned = nearnum (last $ dat) (init dat)
   l1 = length dat
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


powRoot n s e= minimum $ intpowroot n s e

intpowroot n s e=  filter (\(_,f,g)-> f^g <= n) 
   $ concatMap (\x-> map (\y-> (n - x^y, x, y) ) [s .. e]) [2 .. 300]



getB n = filter (\(r,t,w)-> r==n) $ concat $ map (\x-> map (\y-> (x^2-y^3+x,x,y)) [1..n*5-1]) [1..n*5-1]


-- probnetable, x^2+y^3+z
--


bestroot n = minimum $ filter (\(_,e,_)-> e /= n ) 
   $ map (\x-> (n - (integerRoot x n)^x, (integerRoot x n), x) ) [2 .. 300]

powDiv n o
   | rest <= 2 = (b,e) : o
   | otherwise = powDiv rest ((b,e) : o)
   where
   (rest,b,e) = bestroot n 


encode n = (a1,b1,a2,b2,r2)	
	where
	x1 = (integerRoot 3 n)^3
	(x12,r)= (x1,n-(x1))

	x2 = (integerRoot 2 r)^2
	--r2 = (r-(x2))

	--(res1,a1,b1) = powRoot x1 1 500 
	--(res2,a2,b2) = powRoot x2 1 500
	(res,a1,b1) = bestroot n 
	(res2,a2,b2) = bestroot (res)
	r2= res2

decode (a,b,c,d,e) = res
	where
	res = (a^b+c^d+e)

--bestfunc n = (a,b,c)
--	where
--	(a,b,c)= (probnetable n )
	
-- | Property of Cobalt Technologies Panamá
-- | Authors : Vicent Nos Ripolles (Main Author)
-- | Enrique Santos (Refactor Code)

