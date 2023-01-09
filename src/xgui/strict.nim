import regex

const strictNim* = re"""((".*")|(\(.*\))|[^ ]|)*"""

proc isStrict*(s: string): bool {.compileTime.} =
 return s.match(strictNim)