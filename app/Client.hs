{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Monad
import           Control.Monad.IO.Class
import qualified Data.ByteString.Char8  as BS
import           System.Posix.Types
import qualified System.ZMQ4.Monadic    as Z

main :: IO ()
main = Z.runZMQ $ do
    _ <- Z.async $ do
        s <- Z.socket Z.Sub
        Z.subscribe s ""
        Z.connect s "tcp://127.0.0.1:4001"
        forever $
            Z.receive s >>= liftIO . BS.putStrLn

    p <- Z.socket Z.Pub
    Z.connect p "tcp://127.0.0.1:4000"

    forever $
        liftIO BS.getLine >>= Z.send p []
