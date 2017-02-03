{-# OPTIONS_GHC -fwarn-tabs #-}

module HW05 where

isThisWorking :: String
isThisWorking = "Yes"
-- Load this file into GHCi (say, with `ghci HW05.hs`) and type
-- `isThisWorking` at the prompt. GHCi will tell you whether it's working!

-- Put your work below.
lastDigit :: Integer -> Integer
lastDigit = error "lastDigit not yet defined"

dropLastDigit :: Integer -> Integer
dropLastDigit = error "dropLastDigit not yet defined"

toDigits :: Integer -> [Integer]
toDigits = error "toDigits not yet defined"

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther = error "doubleEveryOther not yet defined"

sumDigits :: [Integer] -> Integer
sumDigits = error "sumDigits not yet defined"

validate :: Integer -> Bool
validate = error "validate not yet defined"

type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi = error "hanoi not yet defined"
