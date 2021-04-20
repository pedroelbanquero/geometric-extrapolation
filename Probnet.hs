-- | Authors : Vicent Nos Ripolles (Main Author)
-- Enrique Santos (Refactor Code)

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

-- | This is to assume that the next ratio is close to that of the element 
-- with the closest value to the last element; in case of monotonic data 
-- (always increasing or always decreasing) it is the last ratio. 
predict1 :: RealFrac a => [a] -> a
predict1 dat  = ratio * last dat
   where
   ratio = percents dat !! eleml
   Just eleml = elemIndex ned dat
   ned = nearnum (last dat) (init dat)

-- | Generates new prediction
predict :: (Integral b, RealFrac a) => Int -> [a] -> [b]
predict layers dat 
   | layers > 1   = predict (layers - 1) out -- execute next in the serie
   | otherwise    = fmap round out
   where
   --out = delete ned dat ++ 
   out = [predict1 dat] 
   ned = nearnum (last dat) (init dat)

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
