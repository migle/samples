-- Miguel Ramos, Sep/2014.

import System.Environment (getArgs)

import GHC
import GHC.Paths (libdir)
import DynFlags -- GHC compiler flags
import Outputable -- pretty printing

main = do
    args <- getArgs
    result <- parse $ head args
    putStrLn result

parse pathname =
    defaultErrorHandler defaultFatalMessager defaultFlushOut $ do
        runGhc (Just libdir) $ do
            flags <- getSessionDynFlags
            setSessionDynFlags flags
            target <- guessTarget pathname Nothing
            setTargets [target]
            load LoadAllTargets
            return $! showSDoc flags (ppr target)
