{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
-- deriving instances 
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
module Bender (
    module Bender
    )
    where

-- The bender module


-- Monad : Exception handling, ttrans etc.
-- Lifts from base monad eg IO
import Control.Monad.Base
import Control.Monad.Catch (MonadCatch(..), MonadThrow(..))
import Control.Monad.Trans.Class
import Control.Monad.Trans.Control
import Control.Monad.Trans.Except (runExceptT)
import Control.Monad.Trans.Reader (ReaderT, runReaderT)
import Control.Monad.IO.Class
import Control.Monad.Trans.Except
import Control.Monad.Error
-- For Computations which read values from a shared environment.
import Control.Monad.Reader.Class

{-|
 | A new type of monad (transform), having error handling etc. 
 | Take whatever input and return something of type BenderT e c m a
-}
newtype BenderT e c m a = BenderT { unBenderT :: ExceptT e (ReaderT c m) a } deriving (Functor, Applicative, 
                                                                                Monad, MonadIO, MonadReader c, 
                                                                                MonadError e)
-- Make this an instance of Monad Base: 
deriving instance MonadBase b m => MonadBase b (BenderT e c m)

-- Similarly, here also BenderT is type constructor
instance MonadThrow m => MonadThrow (BenderT e c m) where
  throwM = BenderT . throwM -- Again, BnederT Type constructor needs to be used.

-- Here BenderT is the type constructor
instance MonadCatch m => MonadCatch (BenderT e c m) where
  catch (BenderT m) f = BenderT $ m `catch` (unBenderT . f)

-- Need to return BenderT here too.
instance MonadTrans (BenderT e c) where
  lift = BenderT . lift . lift -- Need to lift twice, 

-- Whatever !@@
instance MonadBaseControl IO m => MonadBaseControl IO (BenderT e c m) where
  type StM (BenderT e c m) a = ComposeSt (BenderT e c) m a
  liftBaseWith = defaultLiftBaseWith
  restoreM     = defaultRestoreM

instance MonadTransControl (BenderT e c) where
  type StT (BenderT e c) a = StT (ExceptT e) (StT (ReaderT c) a)
  liftWith f = BenderT $ liftWith $ \run -> -- To returna BenderT 
                                liftWith $ \run' ->
                                            f (run' . run . unBenderT)
  restoreT = BenderT . restoreT . restoreT


runBenderT :: c -> BenderT e c m a -> m (Either e a)
runBenderT con m = runReaderT (runExceptT $ (unBenderT m)) con
