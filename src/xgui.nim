import xgui/[nn, defaults], std/[tables]
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
##
## Special attributes
## ===================
## Special attributes are marked in this format: `X{type}-{attr name}`
## - `XI-` forces int.
## - `XS-` forces string.
## - `XD-` forces ident.
## 
## Special Tags
## ==============
## - `link` replaces the link tah with the contents of a file linked with `ref=`
## - `script` write nim in xml, special `parent` let returns the parent of the script tag's obj
##


const xmlAliases* = {"l": "Label"}.toTable
  
macro loadGui*(filename: static[string], aliases: static[Table[string, string]]): untyped = 
  ## Loads an xml gui, returns the top ui object, so make sure to catch or discard it
  
  result = handleXml(filename).buildBlock(aliases)
template loadGui*(filename: static[string]): untyped = loadGui(fileName, xmlAliases)
  ## Template becuase of compile-time defaults bug


export defaults