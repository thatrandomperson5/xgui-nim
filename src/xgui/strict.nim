import regex

const strictNim* = re2"""((".*")|(\(.*\))|[^ ]|)*"""

proc isStrict*(s: string): bool {.compileTime.} =
  return s.match(strictNim)