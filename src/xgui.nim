import xgui/[nn, defaults, utils], std/[tables]
## =====
## XGui
## =====
## The xml/gui library, load nigui's from xml
##
## Basics
## ======
## - The tag name is the type, eg `Button`, `LayoutContainer`
## - The attributes are the fields on the object
## - The text is an alias for the `text` field.
## - Tags are declared with the `tag` attribute and are found using the `getTag()` call or `@!<name>` 
##
## Examples
## =========
## **Basic nim code**
##
## .. code:: nim
##
##  import xgui, nigui
## 
##  app.init() # Init the nigui app
## 
##  let w = loadGui("basic.xml") # Load the xml into nigui objects
##  w.width = 600.scaleToDpi # Set the height
##  w.height = 400.scaleToDpi # Set the width
##
##  w.show() # Show the window
## 
##  app.run() # Run the app
##
## ..
##
## **Basic xml**
## 
## .. code:: nim
##
##   <Window title="NiGui &amp; XGui Example">
##       <LayoutContainer>
##          <Button tag="btn">
##             Button 1
##          </Button>
##          <TextArea tag="txt"></TextArea>
##          <script>
##            getTag("btn").onClick = proc (event: ClickEvent) = # Get the button obj and add an event callback
##              getTag("txt").addLine("Button 1 clicked, message box opened.") # Add a line to the TextArea
##              getTag("window").alert("This is a simple message box.") # Open a alert on the top-level Window
##              getTag("txt").addLine("Message box closed.") 
##          </script>
##       </LayoutContainer>
##   </Window>
##
## ..
## 
## The basic example expands into this:
##
## .. code:: nim
## 
##  init(app)
##  let w = block:
##    let xguiElement_452984907 = newWindow("")
##    title=(xguiElement_452984907, "NiGui & XGui Example")
##    add(xguiElement_452984907, block:
##      let xguiElement_452984912 = newLayoutContainer(Layout_Vertical)
##      add(xguiElement_452984912, block:
##        let xguiElement_452984913 = newButton("")
##        text=(xguiElement_452984913, "Button 1")
##        xguiElement_452984913)
##      add(xguiElement_452984912, block:
##        let xguiElement_452984920 = newTextArea("")
##        xguiElement_452984920)
##      block:
##        let parent = unsafeAddr xguiElement_452984912
##        onClick=(xguiElement_452984913, proc (event: ClickEvent) =
##          addLine(xguiElement_452984920, "Button 1 clicked, message box opened.")
##          alert(xguiElement_452984907, "This is a simple message box.", "Message")
##          addLine(xguiElement_452984920, "Message box closed."))
##      xguiElement_452984912)
##    xguiElement_452984907
##  width=(w, scaleToDpi(600))
##  height=(w, scaleToDpi(400))
##  show(w)
##  run(app)
## 
## ..
##
##
## Special attributes
## ===================
## Special attributes are marked in this format: `X{type}-{attr name}`
## - `XI-` forces int.
## - `XS-` forces string.
## - `XD-` forces ident.
## - `XP-` parses a valid nim expression
## 
## Special Tags
## ==============
## - `link` replaces the link tah with the contents of a file linked with `ref=`
## - `script` write nim in xml, special `parent` let returns the parent of the script tag's obj
##


const defaultConfig*: XGuiConfig = (true, true)

const xmlAliases* = {"l": "Label"}.toTable
  
macro loadGui*(filename: static[string], aliases: static[Table[string, string]], config: static[XGuiConfig]): untyped = 
  ## Loads an xml gui, returns the top ui object, so make sure to catch or discard it
  
  result = handleXml(filename).buildBlock(aliases, config)

template loadGui*(filename: static[string]): untyped = loadGui(fileName, xmlAliases, defaultConfig)
  ## Template becuase of compile-time defaults bug


export defaults, XGuiConfig

