-- Vicent Nos Ripolles (Main Author)
-- Enrique Santos (Refactor Code)

module Core.Events (
   probnet, 
   prerr, 
   predict1, 
   predict, 
   percents,
   probability_decrease,
) where

import qualified Data.List as A
import Data.List.GroupBy (group)
import Data.Maybe
import Data.Ratio
import Math.OEIS


probnet :: Int -> [Double] -> [Double]
probnet layers dat
   | layers == 0  = a
   | otherwise    = probnet (layers - 1) a
   where
   a = dat ++ [predict1 dat + prerr dat]

prerr :: [Double] -> Double
prerr dat 
   | last r == 0  = 0 
   | otherwise    = predict1 $ drop 3 r  
   where  
   r = zipWith subtract partialPred dat
   partialPred = fmap predict1 $ A.inits dat

predict1 :: [Double] -> Double
predict1 = last . predict 1

predict :: Int -> [Double] -> [Double]
predict n dat 
   | n == 1    = out
   | otherwise = predict (n - 1) out -- execute next in the serie
   where
   out   = A.delete ned dat ++ [res] 
      where
      lastd = last dat
      ned   = nearnum lastd (init dat)
      res = fromIntegral . round $ percent (nextprob ned dat) lastd -- rounded ratio
         where

-- gen best pattern , prababilities to have the next probability
-- here a fail when element number is greater than the availiable probs, pending to solve
nextprob :: Double -> [Double] -> Double
nextprob ned dat
   | A.all (== head pd) pd = last probs -- all ratios decrease, or all increase
   | eleml > length probs  = error "Index too large, in Events.predict. "
   | otherwise             = probs !! eleml
   where
   Just eleml = A.elemIndex ned dat
   probs = percents dat
   pd = probability_decrease dat

-- | Percent ratio of 'x' relative to 'y'
percent :: Double -> Double -> Double
percent y x = (100 * x) / y

-- | Percent ratios between consecutive elements. 
percents :: [Double] -> [Double]
percents dat = zipWith percent (tail dat) dat

-- | List with 'True' when next element is smaller, 'False' otherwise
probability_decrease :: [Double] -> [Bool]
probability_decrease dat = zipWith (<) (tail dat) dat

-- | Element value of 'list' nearest to 'n'
nearnum :: Double -> [Double] -> Double
nearnum n list = A.minimumBy nearer list
   where
   nearer x y = compare (abs (x - n)) (abs (y - n))
   
testoeis s t= pred
    where
    series = map (\x-> ("A"++(show x), map toRational $ filter (\f-> f>=1 ) $ fromJust $ getSequenceByID ("A"++(show x)))) [s..t]
    
    --pred = filter (\(x,y)-> (toRational $ last (take 11 (y))) == (last (probnet (map toRational $ take 10 (y)) 0)) ) (filter (\(x,y)-> (length y)>10) series)

    pred = filter (\(x,y)-> (toRational $ last (take 11 y) ) == (last (probnet (map toRational $ take 10 (y)) 0 )) ) (filter (\(e,r)->  (length r)>9) series)
