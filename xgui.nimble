version     = "0.2.0"
author      = "thatrandomperson5"
description = "XGui is a tool for nigui that imports xml files and turns them into nim at compile-time."
license     = "MIT"

srcDir = "src"

requires "nigui >= 0.2.6"
requires "nim >= 2.0.0"
requires "regex >= 0.20.1"
when defined(xguiTrace):
  requires "terminaltables >= 0.1.0"