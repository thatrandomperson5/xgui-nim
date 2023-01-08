version     = "0.0.0"
author      = "Your name"
description = "Description of your library"
license     = "MIT"

srcDir = "src"

requires "nigui"
requires "nim >= 1.2.2"


task test, "Test xgui":
  exec "nimble install --depsOnly"
  exec "nim c tests/test.nim"