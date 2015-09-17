{-# LANGUAGE OverloadedStrings #-}

module Lib where

import Text.Regex.Applicative

filterProfanity :: String -> String
filterProfanity s =
    case findFirstInfix re s of
        Nothing -> s
        Just (before, word, after) ->
            before ++ map (const '*') word ++ filterProfanity after
  where
    re :: RE Char String
    re =
            "fuck"
        <|> "shit"
        <|> "bitch"
        <|> "tits"
