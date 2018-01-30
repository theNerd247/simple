{-# LANGUAGE OverloadedStrings #-}

module Simple.Snap where

import Simple
import Control.Monad.Catch
import Control.Monad.IO.Class
import qualified Data.CaseInsensitive as CI
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Char8 as Char8
import qualified Control.Exception.Lifted as L
import qualified Snap as Snap

getHeaderSnap :: (Snap.MonadSnap m) => Key -> m (Maybe ReqValue)
getHeaderSnap k = Snap.getsRequest $ fmap B.fromStrict . Snap.getHeader (CI.mk . Char8.pack $ k)

printVal :: (MonadIO m, Show x) => x -> m x
printVal x = (liftIO . putStrLn . show $ x) >> return x

getParamSnap :: (Snap.MonadSnap m) => Key -> m (Maybe ReqValue)
getParamSnap k = Snap.getParam (Char8.pack k) >>= return . fmap B.fromStrict

getBodySnap :: (Snap.MonadSnap m) => m ReqValue
getBodySnap = Snap.readRequestBody (1 * 1024 * 1024)

sendResponseSnap :: (Snap.MonadSnap m) => RespValue -> m ()
sendResponseSnap x = do
  Snap.modifyResponse $
      Snap.setResponseCode 200
    . Snap.setHeader "Content-Type" "application/json"
  Snap.writeLBS x

instance MonadThrow (Snap.Handler b v) where
  throwM = L.throwIO

instance MonadCatch (Snap.Handler b v) where
  catch = L.catch

instance HasApi (Snap.Handler b v) where
  getBody = getBodySnap
  getHeader = getHeaderSnap
  getParam = getParamSnap
  sendResponse = sendResponseSnap
