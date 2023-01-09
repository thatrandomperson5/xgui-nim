# xgui-nim
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
Just run `nimble xgui installDebug` and compile with `-d:xguiTrace`, the expanded code will be dumped along with a trace table. (Expanded code is not easy on the eyes)
# Future
Add more exmaples
