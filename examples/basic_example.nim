# Basic example
import xgui, nigui

app.init()

let w = loadGui("xml/basic.xml")
w.width = 600.scaleToDpi
w.height = 400.scaleToDpi

w.show()

app.run()
