import std/[strutils]


type XGuiConfig* = tuple[
  useAtBangs: bool,
  usePtrParents: bool
]


proc makeSafe*(xml: string): string =
  result = xml.replace("<script>", "<script>@#")

proc isBlank(s: string): bool = 
  if s.len == 0:
    return true
  else:
    for c in s:
      if c notin {'\n', '\r', ' ', '\t'}:
        return false
    return true

proc stripEmpty(s: string): string =
  for l in s.splitLines(true):
    if not (isBlank(l) or l.startswith("@#")):
      result &= l
  result.replace("@#", "")
  
proc deepStrip*(s: string): string = 
  let l = s.stripEmpty.splitLines(true)
  var lineLen = 0
  for c in l[0]:  
    if c notin {' ', '\t'}:
      break
    lineLen += 1
  for ln in l:
      if ln.len > lineLen:
        result &= ln[lineLen..^1]