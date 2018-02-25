module Simple where

import Control.Monad.Catch
import Text.Read hiding (lift)
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Char8 as Char8

data Error = BodyError String | HeaderError String | ParamError String
  deriving (Eq,Ord,Show,Read)

instance Exception Error

-- | Raw request data should be converted to this type.
type ReqValue = B.ByteString

-- | The user accesses data for headers and parameters by passing a value of
-- this type.
type Key = String

-- | The response should be convertable to this type.
type RespValue = B.ByteString

throwMaybe :: (Exception e, MonadThrow m) => e -> Maybe a -> m a
throwMaybe _ (Just x) = return x
throwMaybe e Nothing = throwM e

-- | Most web apis have the same form with some slight variation in between.
-- This class unifies all of these interfaces to something...simple. When
-- writing a web api we typically focus on 1 thing: processing the inputs. In C#
-- MVC apps each endpoint is written as a function with some meta data
-- describing how we want that data to come in....this provides the same
-- mentality. Your web framework should already have support for routing, HTTP
-- method filtering etc. The only thing missing? A simple interface to write
-- your endpoints in the form of a function. To use this class do the following: 
--
-- @
--               |--- this is the monad of your web framework's handler. In Snap
--               |    this would be (Handler b v)
--               V
-- someFooAPI :: m OutputFoo
-- someFooApi = do
--   p <- fromParam "blarg" -- fetches a value from the request parameters. If an error occurs during parsing then an exception is thrown.
--   h <- fromHeader "foo"
--   b <- fromBody -- parses the entire body as a single type
--   doSomethingFooey p h b
--   where
--     doSomethingFooey :: String -> Double -> MyLargeDataType -> m OutputFoo
--     doSomethingFooey p h b ...
-- @
--
--  
class (MonadCatch m) => HasApi m where
  getBody :: m ReqValue
  getHeader :: Key -> m (Maybe ReqValue)
  getParam :: Key -> m (Maybe ReqValue)
  sendResponse :: RespValue -> m ()

  withApi :: m RespValue -> m ()
  withApi api = (api >>= sendResponse) 
  
runApi :: (HasApi m) => (x -> m RespValue) -> m x -> m ()
runApi encoder api = withApi $ api >>= encoder
