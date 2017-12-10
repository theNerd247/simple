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
fromParams p d k = getParam k >>= throwMaybe err . parse
  where
    parse Nothing = Just []
    parse (Just v) = asList d p v
    err = ParamError $ "Could not parse value at param key: " ++ (show k)

fromHeaders :: (HasApi m) => (ReqValue -> Maybe a) -> Char -> Key -> m [a]
fromHeaders p d k = getHeader k >>= throwMaybe err . parse
  where
    parse Nothing = Just []
    parse (Just v) = asList d p v
    err = HeaderError $ "Could not parse value at header key: " ++ (show k) 

asList :: Char -> (ReqValue -> Maybe a) -> ReqValue -> Maybe [a]
asList delim decoder = sequence . fmap decoder . B.split delim

spaced :: (ReqValue -> Maybe a) -> ReqValue -> Maybe [a]
spaced = asList ' '
