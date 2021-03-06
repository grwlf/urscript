module Cakefile where

import Development.Cake3
import Development.Cake3.Ext.UrWeb
import Cakefile_P

instance IsString File where fromString = file

project = do

  prebuild [cmd|urweb -print-cinclude >/dev/null|]

  u <- uwlib "lib.urp" $ do
    ffi "Script.urs"
    include "Script.h"
    csrc "Script.c"

  t <- uwapp "-dbms sqlite" "Test1.urp" $ do
    allow url "http://code.jquery.com/ui/1.10.3/jquery-ui.js"
    allow mime "text/javascript"
    library u
    debug
    module_ (single "Test1.ur")

  {-
  t2 <- uwapp "-dbms sqlite" "Test2.urp" $ do
    allow url "http://code.jquery.com/ui/1.10.3/jquery-ui.js"
    allow mime "text/javascript"
    library u
    debug
    module_ (single "Test2.ur")
  -}

  rule $ do
    phony "run"
    shell [cmd|$t|]

  rule $ do
    phony "clean"
    unsafeShell [cmd|rm -rf .cake3 $(tempfiles u) $(tempfiles t)|]

  rule $ do
    phony "all"
    depend u
    depend t

  return ()

main = do
  writeMake (file "Makefile") (project)
  writeMake (file "Makefile.devel") (selfUpdate >> project)

