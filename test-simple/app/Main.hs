{-# LANGUAGE TemplateHaskell #-} 
{-# LANGUAGE OverloadedStrings #-} 
{-# LANGUAGE DeriveDataTypeable #-} 
{-# LANGUAGE DeriveGeneric #-} 

module Main where

import Snap
import Simple
import Simple.Snap
import Simple.String
import Control.Monad.Catch hiding (Handler)
import Control.Monad.IO.Class
import Data.Aeson
import Control.Monad.Trans.State
import Control.Lens
import GHC.Generics
import Data.Data
import qualified Data.Text as T

data Filter = Filter
  { name :: [Int]
  } deriving (Show, Read, Ord, Eq, Data, Typeable, Generic)

data App = App
  { _x :: Filter
  }

makeLenses ''App

appInit :: SnapletInit App App
appInit = makeSnaplet "app" "foo snaplet" Nothing $ do
  addRoutes [("foo", someFoo)]
  return $ App 
    { _x = Filter [] -- [] 0
    }

someFoo :: Handler App App ()
someFoo = runStringApi $ Filter <$> fromParams ' ' "foo" 

main = serveSnaplet defaultConfig appInit
