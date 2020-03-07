-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- set colour of the background 
display.setDefault("background", 255/255, 255/255, 255/255)

local myRectangle = display.newRect( 250, 200, 300, 150 )
myRectangle.strokeWidth = 1
myRectangle:setFillColor( 255/255, 0/255, 0/255 )
myRectangle:setStrokeColor( 0/255, 0/255, 0/255 )

local myCircle = display.newCircle( 100, 100, 100 )
myCircle:setFillColor( 0/225, 0/255, 255/255 )
myCircle.x = 800
myCircle.y = 200

local halfW = display.contentWidth * 0.5
local halfH = display.contentHeight * 0.5

local vertices = { 0,-110, 105,-35, 65,90, -65,90, -105,-35, }

local pentagon = display.newPolygon( halfW, halfH, vertices )
pentagon.strokeWidth = 0
pentagon:setStrokeColor( 1, 0, 0 )
pentagon.x = 200
pentagon.y = 500
pentagon:setFillColor( 0, 0, 0 )

local halfW = display.contentWidth * 0.5
local halfH = display.contentHeight * 0.5

local vertices = { 0,-110, 105,-35, 65,90, -65,90, }
local octagon = display.newPolygon( halfW, halfH, vertices )
octagon.strokeWidth = 5
octagon:setStrokeColor( 0, 0, 0 )
octagon.x = 800
octagon.y = 500
octagon:setFillColor( 1, 1, 1 )
