module Simple.Default where

import Control.Monad.Catch
import Simple

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
