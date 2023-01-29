# xgui-nim
[![nimble](https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png)](https://github.com/yglukhov/nimble-tag)
[![Build Status](https://nimble.directory/ci/badges/xgui/nimdevel/status.svg)](https://nimble.directory/ci/badges/jester/nimdevel/output.html)

XGui is a tool for [nigui](https://github.com/simonkrauter/NiGui) that imports xml files and turns them into nim at compile-time.

You can install it using the command below:
```
nimble install https://github.com/thatrandomperson5/xgui-nim.git
```
# Examples
These examples are all the equivalent from [nigui exmaples](https://github.com/simonkrauter/NiGui/tree/master/examples)
* [basic app (1)](https://github.com/thatrandomperson5/xgui-nim/blob/main/examples/basic_example.nim) | [xml](https://github.com/thatrandomperson5/xgui-nim/blob/main/examples/xml/basic.xml)
* [controls (2)](https://github.com/thatrandomperson5/xgui-nim/blob/main/examples/full_example.nim) | [xml](https://github.com/thatrandomperson5/xgui-nim/blob/main/examples/xml/full.xml)

# Running tests
Run the comannds below
```
git clone https://github.com/thatrandomperson5/xgui-nim.git
cd xgui-nim
nimble test
```

# Docs
The docs are here: [thatrandomperson5.github.io/xgui-nim](https://thatrandomperson5.github.io/xgui-nim)
# XGui-specific features
* Parent pointer, points to the parent of the script tag
* Tags, allow flagging and finding of elements
* Border-crossing with the link tag
# Tracing
I know becuase of compile time and remote code and other factors, the tracbacks can be really confusing, so i made a tool.
Just run `nimble install terminaltables` and compile with `-d:xguiTrace`, the expanded code will be dumped along with a trace table. (Expanded code is not easy on the eyes)

The trace table looks something like this:
```
Printing trace: 
+--------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Tag                      | Tag-Flags | Attrs                                                                                                                                                         |
+--------------------------+-----------+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
|  <Window />              |           | width: 100, title: "xgui w/ nigui"                                                                                                                            |
|    <LayoutContainer />   |           | layout: Layout_Horizontal                                                                                                                                     |
|      <l />               |           |                                                                                                                                                               |
|      <Container />       |           |                                                                                                                                                               |
|        <TextArea />      | txt       |                                                                                                                                                               |
|        <Button />        | thebutton |                                                                                                                                                               |
|    <LayoutContainer />   |           |                                                                                                                                                               |
|      <LayoutContainer /> |           | frame: newFrame("Row 1: Auto-sized"), layout: Layout_Horizontal                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|      <LayoutContainer /> |           | frame: newFrame("Row 2: Auto-sized, more padding"), layout: Layout_Horizontal, padding: 10                                                                    |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|      <LayoutContainer /> |           | frame: newFrame("Row 3: Auto-sized, more spacing"), spacing: 15, layout: Layout_Horizontal                                                                    |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|      <LayoutContainer /> |           | frame: newFrame("Row 4: Controls expanded"), layout: Layout_Horizontal                                                                                        |
|        <Button />        |           | widthMode: WidthMode_Expand                                                                                                                                   |
|        <Button />        |           | widthMode: WidthMode_Expand                                                                                                                                   |
|        <Button />        |           | widthMode: WidthMode_Expand                                                                                                                                   |
|      <LayoutContainer /> |           | frame: newFrame("Row 5: Controls centered"), widthMode: WidthMode_Expand, xAlign: XAlign_Center, layout: Layout_Horizontal, yAlign: YAlign_Center, height: 80 |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
|        <Button />        |           |                                                                                                                                                               |
---------------------------+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------
```
# Future
Add more exmaples
