import nigui
template newLayoutContainer*(): LayoutContainer = newLayoutContainer(Layout_Vertical)
  ## Argument-less layout container command

proc newBold*(): Label = 
  let l = newLabel()
  l.setFontBold(true)
  l.widthMode = WidthMode_Expand
  return l

proc newHeader*(): Label = 
  let l = newLabel()
  l.setFontSize(app.defaultFontSize*2)
  l.widthMode = WidthMode_Expand
  return l

proc newSubHeader*(): Label = 
  let l = newLabel()
  l.setFontSize(app.defaultFontSize*1.5)
  l.widthMode = WidthMode_Expand
  return l
