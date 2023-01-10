import nigui
template newLayoutContainer*(): LayoutContainer = newLayoutContainer(Layout_Vertical)
  ## Argument-less layout container command

proc newBold*(): Label = 
  let l = newLabel()
  l.setFontBold(true)
  return l

proc newHeader*(): Label = 
  let l = newLabel()
  l.setFontSize(app.defaultFontSize*2)
  return l

proc newSubHeader*(): Label = 
  let l = newLabel()
  l.setFontSize(app.defaultFontSize*1.5)
  return l