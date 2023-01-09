import std/[xmltree, xmlparser, parsexml, macros, tables, strutils, strtabs], utils

var tags {.compileTime.} = initTable[string, NimNode]()

# ----------------------------------------------------------------------------------------
#                                    Xml Reader
# ----------------------------------------------------------------------------------------
  
proc handleXml*(filename: string): XmlNode {.compileTime.} = 
  ## Compile-time xml parsing with `allowUnquotedAttribs` and `allowEmptyAttribs`
  
  var xml = staticRead(filename)
  xml = xml.makeSafe()
  result = parseXml(xml, {allowUnquotedAttribs, allowEmptyAttribs})

# ----------------------------------------------------------------------------------------
#                                     Forwards
# ----------------------------------------------------------------------------------------

proc buildBlock*(node: XmlNode, aliases: Table[string, string]): NimNode

# ----------------------------------------------------------------------------------------
#                                    Utils
# ----------------------------------------------------------------------------------------

proc makeLink(node: XmlNode, al: Table[string, string]): NimNode =
  ## Link two xgui xml files using `link` tag with `ref` attribute

  if "ref" in node.attrs:

    result = handleXml(node.attrs["ref"]).buildBlock(al)
  else:
    raise newException(ValueError, "Link node must have ref")

proc searchAndTransform(obj: NimNode, f: NimNode, r: NimNode): NimNode =
  ## Search and transform `f` for `r` in `obj`
  if obj.len < 1:
    return obj
  result = newNimNode(obj.kind)
  for child in obj:
    if child == f:
      result.add r
    else:
      result.add searchAndTransform(child, f, r)

proc findTagCalls(obj: NimNode): NimNode =
  if obj.len < 1:
    return obj
  result = newNimNode(obj.kind)
  for child in obj:
    if child.kind == nnkCall and child[0] == newIdentNode("getTag"):
      expectKind(child[1], nnkStrLit)
      result.add tags[child[1].strVal]
    else:
      result.add findTagCalls(child)

proc getText(node: XmlNode): string = 
  for child in node:
    if child.kind in {xnText, xnVerbatimText, xnEntity}:
      result &= child.text   

proc makeScript(node: XmlNode, parent: NimNode): NimNode =
  ## Make script tag internals. Provide the `parent` pointer

  let txt = node.getText.deepStrip()
  
  var nnodes = parseStmt(txt)
  let parentNode = newIdentNode("parent")

  result = newStmtList()
  result.add newLetStmt(
    parentNode,
    newTree(nnkCommand, newIdentNode("unsafeAddr"), parent)
  )
  nnodes = nnodes.searchAndTransform(parentNode, newTree(nnkBracketExpr, parentNode))
  nnodes = nnodes.findTagCalls()
  result.add nnodes
  result = newBlockStmt(result)

proc inferValue(v: string, name: string): NimNode =
  ## Value inferation, like `"100"` will be turned into `100`
  ##
  ## Special codes:
  ## ---------------
  ## * `XI-` Force int
  ## * `XS-` Force string
  ## * `XD-` Force identifier

  if name.startsWith("X"):
    case name[1]:
    of 'I':
      return newLit(v.parseInt)
    of 'S':
      return newLit(v)
    of 'F':
      return newLit(v.parseFloat)
    of 'D':
      return newIdentNode(v)
    of 'P': # Parse
      return parseExpr(v)
    else:
      raise newException(ValueError, "Invalid inferation type.")
  else:
    try:
      return newLit(v.parseInt)
    except ValueError:
      try:
        return newLit(v.parseFloat)
      except ValueError:
        return newLit(v)

# ========================================================================================
#
#                                   Main block maker
#
# ========================================================================================


template childHandler(): untyped = 
  for child in node:
    case child.kind
    of xnText:
      txt &= child.text
      continue
    of xnElement:
      discard
    else:
      continue
    case child.tag:
    of "link":
      result.add newCall(
        newIdentNode("add"), 
        nameSym,
        makeLink(child, aliases)
      ) 
    of "script":
      result.add makeScript(child, nameSym)
    else:
      result.add newCall(
        newIdentNode("add"), 
        nameSym,
        buildBlock(child, aliases)
      )

proc buildBlock(node: XmlNode, aliases: Table[string, string]): NimNode = 
  ## Builds xml into block stmts
  result = newStmtList()
  let nameSym = genSym(ident="xguiElement")
  var procname: string = node.tag
  if procname in aliases:
    procname = aliases[procname]
  if procname == "Window":
    tags["window"] = nameSym

  result.add newLetStmt(nameSym, newCall(
    newIdentNode("new" & procname)
  ))
  if not node.attrs.isNil:
    for key, value in node.attrs:
      var realKey = key
      if realKey == "tag":
        tags[value] = nameSym
        continue
      if key.startswith("X"):
        realKey = key[3..^1]
      result.add newAssignment(
        newDotExpr(nameSym, newIdentNode(realKey)),
        inferValue(value, key)
      )
  var txt = ""
  childHandler()
  let strpText = txt.strip()
  if strpText != "":
    result.add newAssignment(
      newDotExpr(nameSym, newIdentNode("text")),
      newLit(strpText)
    )
  result.add nameSym
  result = newBlockStmt(result)