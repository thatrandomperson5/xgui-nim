import nigui
  
type XGuiTree = object
  obj: ptr Control
  case isContainer: bool
  of true:
    children: seq[ref XGuiTree]
  of false:
    discard
