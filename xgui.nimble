version     = "0.1.0"
author      = "thatrandomperson5"
description = "XGui is a tool for nigui that imports xml files and turns them into nim at compile-time."
license     = "MIT"

srcDir = "src"

requires "nigui"
requires "nim >= 1.2.2"
requires "regex"


task test, "Test xgui":
  exec "nimble install --depsOnly"
  exec "nim c tests/test.nim"
task installDebug, "Install debug dependencies":
  exec "nimble install terminaltables"