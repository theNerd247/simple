module Simple.Aeson where

import Data.Aeson hiding (Error)
import qualified Simple as S

fromHeader :: (S.HasApi m, FromJSON a) => S.Key -> m a
fromHeader = S.fromHeader decode

fromParam :: (S.HasApi m, FromJSON a) => S.Key -> m a
fromParam = S.fromParam decode

fromBody :: (S.HasApi m, FromJSON a) => m a
fromBody = S.fromBody decode

runAesonApi :: (S.HasApi m, ToJSON x) => m x -> m ()
runAesonApi = S.runApi (return . encode)
