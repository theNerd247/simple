{-# LANGUAGE DeriveDataTypeable, DeriveGeneric #-}

module Simple.String where

import Simple
import Data.Data
import Data.Monoid
import Text.Read (readMaybe)
import GHC.Generics
import qualified Data.ByteString.Lazy.Char8 as B
import qualified Simple.Default as S

-- | returns a string without parsing it. This is useful for skipping parsing
-- with strings
newtype SkipParse = SkipParse { skipParse :: String } 
  deriving (Show,Eq,Ord,Data,Typeable,Generic)

instance Monoid SkipParse where
  mempty = SkipParse mempty
  (SkipParse a) `mappend` (SkipParse b) = SkipParse (a `mappend` b) 

instance Read SkipParse where
  readsPrec _ s = [(SkipParse s, "")]

decode :: (Read a) => B.ByteString -> Maybe a
decode = readMaybe . B.unpack 

encode :: (Show a) => a -> B.ByteString
encode = B.pack . show

fromHeader :: (HasApi m, Read a) => Key -> m a
fromHeader = S.fromHeader decode

fromParam :: (HasApi m, Read a) => Key -> m a
fromParam = S.fromParam decode

fromBody :: (HasApi m, Read a) => m a
fromBody = S.fromBody decode

fromParams :: (HasApi m, Read a) => Char -> Key -> m [a]
fromParams = S.fromParams decode

fromHeaders :: (HasApi m, Read a) => Char -> Key -> m [a]
fromHeaders = S.fromHeaders decode

runStringApi :: (HasApi m, Show x) => m x -> m ()
runStringApi = runApi (return . encode)
