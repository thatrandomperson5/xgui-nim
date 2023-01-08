import xgui/[nn, defaults], std/[tables]


const xmlAliases* = {"l": "Label"}.toTable
  
macro loadGui*(filename: static[string], aliases: static[Table[string, string]]): untyped = 
  result = handleXml(filename).buildBlock(aliases)
template loadGui*(filename: static[string]): untyped = loadGui(fileName, xmlAliases)  


export defaults