import Probnet
import Math.OEIS

testoeis :: Integer -> Integer -> [(String, [Integer])]
testoeis s t = filter condition $ fmap serie [s .. t]

serie :: Show a => a -> (String, [Integer])
serie x = (serieID, filter (> 0) oeis)
   where
   serieID = 'A' : show x
   Just oeis = getSequenceByID serieID

condition :: (String, [Integer]) -> Bool
condition (_, y) = length y > 11 && last prob == y !! 11
   where 
   prob = probnet 0 s
   s = take 10 $ fmap fromInteger y

{-
testoeis s t= pred
    where
    series = map (\x-> ("A"++(show x), map toRational $ filter (\f-> f>=1 ) $ fromJust $ getSequenceByID ("A"++(show x)))) [s..t]
    
    --pred = filter (\(x,y)-> (toRational $ last (take 11 (y))) == (last (probnet (map toRational $ take 10 (y)) 0)) ) (filter (\(x,y)-> (length y)>10) series)

    pred = filter (\(x,y)-> (toRational $ last (take 11 y) ) == (last (probnet (map toRational $ take 10 (y)) 0 )) ) (filter (\(e,r)->  (length r)>9) series)
-}