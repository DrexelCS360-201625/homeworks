module NfaToDot (
    nfaToDot
  ) where

import Data.List (intersperse)

import Nfa
import Set

nfaToDot :: Ord q => Nfa q -> String
nfaToDot = toDot . numberNfaFrom 0

toDot :: Nfa Int -> String
toDot (Nfa qs moves q0 fin) =
    stack $
    ["digraph fsm {"
    ,"rankdir=\"LR\";"
    ,"start [shape=\"plaintext\",label=\"start\"];"
    ,startEdge q0]
    ++
    map stateToDot (toList qs)
    ++
    map moveToDot (toList moves)
    ++
    ["}"]
  where
    startEdge :: Int -> String
    startEdge q = "start->" ++ show q ++ ";"

    -- Given a state, return a line of dot syntax that will create a node for
    -- the state.
    stateToDot :: Int -> String
    stateToDot = error "unimplemented: stateToDot"

    -- Given a move between states, return a line of dot syntax that will create
    -- an edge for the transition.
    moveToDot :: Move Int -> String
    moveToDot = error "unimplemented: moveToDot"

epsilon :: String
epsilon = "ε"

-- Separate a list of strings by newlines
stack :: [String] -> String
stack = concat . intersperse "\n"
