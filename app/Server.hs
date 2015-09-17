module Main where

import           Control.Monad
import qualified Data.ByteString.Char8 as BS
import qualified System.ZMQ4.Monadic   as Z

import Lib

main :: IO ()
main = Z.runZMQ $ do
    s <- Z.socket Z.Sub
    Z.bind s "127.0.0.1:4000"

    p <- Z.socket Z.Pub
    Z.bind p "127.0.0.1:4001"

    forever $
        Z.receive s >>= Z.send p []
                        . BS.pack
                        . filterProfanity
                        . BS.unpack
