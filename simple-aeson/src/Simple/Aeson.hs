module Simple.Aeson where

import Data.Aeson hiding (Error)
import Simple
import qualified Simple.Default as S

fromHeader :: (HasApi m, FromJSON a) => Key -> m a
fromHeader = S.fromHeader decode

fromParam :: (HasApi m, FromJSON a) => Key -> m a
fromParam = S.fromParam decode

fromBody :: (HasApi m, FromJSON a) => m a
fromBody = S.fromBody decode

runAesonApi :: (HasApi m, ToJSON x) => m x -> m ()
runAesonApi = runApi (return . encode)
