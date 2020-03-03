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
myRectangle.strokeWidth = 3
myRectangle:setFillColor( 255/255, 0/255, 0/255 )
myRectangle:setStrokeColor( 0/255, 0/255, 0/255 )