import xgui/[nn, defaults], std/[tables]


const xmlAliases* = {"l": "Label"}.toTable
  
macro loadGui*(filename: static[string], aliases: static[Table[string, string]]): untyped = 
  ## Loads an xml gui, returns the top ui object, so make sure to catch or discard it
  
  result = handleXml(filename).buildBlock(aliases)
template loadGui*(filename: static[string]): untyped = loadGui(fileName, xmlAliases)
  ## Template becuase of compile-time defaults bug


export defaults