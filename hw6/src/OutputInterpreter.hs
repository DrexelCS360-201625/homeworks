module OutputInterpreter (
    I,
    runI,
    emptyState,

    sStep
  ) where

import Prelude hiding (lookup)

import Control.Monad (liftM, ap)

import While

type Z = Integer

-- | In lecture, we represented the state as a function. Here we represent state
-- as an association list instead.
type State = [(Var,Z)]

emptyState :: State
emptyState = []

newtype I a = I { runI :: State -> (a, [Z], State) }

instance Functor I where
    fmap = liftM

instance Applicative I where
    pure  = return
    (<*>) = ap

instance Monad I where
    return x   = error "you need to define return for the I monad in OutputInterpreter.hs"
    comp >>= f = I $ \s -> let (x, o1, s1) = runI comp s
                               (y, o2, s2) = runI (f x) s1
                           in
                             (y, o1 ++ o2, s2)

getState :: I State
getState = I $ \s -> (s, [], s)

putState :: State -> I ()
putState s = I $ \_ -> ((), [], s)

lookup :: Var -> I Z
lookup v0 = do { s <- getState
               ; return (look v0 s)
               }
  where
    look :: Var -> State -> Z
    look v []                      = error $ "undefined variable " ++ show v
    look v ((v',n):vs) | v' == v   = n
                       | otherwise = look v vs

extend :: Var -> Z -> I ()
extend v n = do { vs <- getState
                ; putState $ (v,n) : filter (\(v', _) -> v' /= v) vs
                }

output :: Z -> I ()
output i = I $ \s -> ((), [i], s)

-- | The semantic function for arithmetic expressions
aSem :: Aexp -> I Z
aSem (Const x)   = return x
aSem (Var v)     = lookup v
aSem (Add a1 a2) = do { x <- aSem a1
                      ; y <- aSem a2
                      ; return $ x + y
                      }
aSem (Sub a1 a2) = do { x <- aSem a1
                      ; y <- aSem a2
                      ; return $ x - y
                      }
aSem (Mul a1 a2) = do { x <- aSem a1
                      ; y <- aSem a2
                      ; return $ x * y
                      }

-- | The semantic function for boolean expressions
bSem :: Bexp -> I Bool
bSem BTrue       = return True
bSem BFalse      = return False
bSem (Eq a1 a2)  = do { x <- aSem a1
                      ; y <- aSem a2
                      ; return $ x == y
                      }
bSem (Le a1 a2)  = do { x <- aSem a1
                      ; y <- aSem a2
                      ; return $ x <= y
                      }
bSem (Not b)     = do { x <- bSem b
                      ; return $ not x
                      }
bSem (And b1 b2) = do { x <- bSem b1
                      ; y <- bSem b2
                      ; return $ x && y
                      }

-- | The semantic function for statements
sStep :: Stm -> I ()
sStep (Out a) = do { i <- aSem a
                   ; output i
                   }
sStep _ = error "sStep: you need to fill in the missing cases in OutputInterpreter.hs"
