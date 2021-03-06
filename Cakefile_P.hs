-- This file was autogenerated by cake3.
-- https://github.com/grwlf/cake3

{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE QuasiQuotes #-}
module Cakefile_P(file, cakefiles, selfUpdate,filterDirectoryContentsRecursive) where

import Control.Monad.Trans
import Control.Monad.State
import Development.Cake3
import Development.Cake3.Monad
import Development.Cake3.Utils.Find
import GHC.Exts (IsString(..))

pl = ProjectLocation projectroot moduleroot

file :: String -> File
file x = file' pl x

-- instance IsString File where
--   fromString = file

projectroot :: FilePath
projectroot = "/home/grwlf/proj/urscript"

moduleroot :: FilePath
moduleroot = "/home/grwlf/proj/urscript"

cakefiles :: [File]
cakefiles = 
  let rl = ProjectLocation projectroot projectroot in
  case "/home/grwlf/proj/urscript" of
    "/home/grwlf/proj/urscript" -> map (file' rl) ("./Cakefile.hs" : [])
    _ -> error "cakefiles are defined for top-level cake only"

selfUpdate :: Make [File]
selfUpdate = do
  makefile <- outputFile <$> get
  (_,cg) <- rule2 $ do
    depend cakefiles
    produce (file "Cakegen")
    shell [cmd|cake3|]
  (_,f) <- rule2 $ do
    produce makefile
    shell [cmd|$cg|]
  return f

filterDirectoryContentsRecursive :: (MonadIO m) => [String] -> m [File]
filterDirectoryContentsRecursive exts = liftM (filterExts exts) (getDirectoryContentsRecursive (file "."))

