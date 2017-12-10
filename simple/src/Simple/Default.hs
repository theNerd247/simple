module Simple.Default where

import Simple
import Control.Monad.Catch
import qualified Data.ByteString.Lazy.Char8 as B

fromHeader :: (HasApi m) => (ReqValue -> Maybe a) -> Key -> m a
fromHeader p k = getHeader k >>= throwMaybe err . (>>= p)
  where
    err = HeaderError $ "Could not find value at header key: " ++ (show k) 

fromParam :: (HasApi m) => (ReqValue -> Maybe a) -> Key -> m a
fromParam p k = getParam k >>= throwMaybe err . (>>= p)
  where
    err = ParamError $ "Could not find value at param key: " ++ (show k)

fromBody :: (HasApi m) => (ReqValue -> Maybe a) -> m a
fromBody p = getBody >>= throwMaybe err . p
  where
    err = BodyError $ "Could not find value in body" 

fromParams :: (HasApi m) => (ReqValue -> Maybe a) -> Char -> Key -> m [a]
fromParams p d k = fromParam (asList d p) k

fromHeaders :: (HasApi m) => (ReqValue -> Maybe a) -> Char -> Key -> m [a]
fromHeaders p d k = fromHeader (asList d p) k

asList :: Char -> (ReqValue -> Maybe a) -> ReqValue -> Maybe [a]
asList delim decoder = sequence . fmap decoder . B.split delim

spaced :: (ReqValue -> Maybe a) -> ReqValue -> Maybe [a]
spaced = asList ' '
