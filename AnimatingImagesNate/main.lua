-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- set background 
local backgroundImage = display.newImageRect("Images/background.jpg", 2048, 1536)
local Catbug = display.newImage("Images/Catbug.png", 200, 200)
local Oswald = display.newImage("Images/Oswald.png", 500, 500)
local Bear = display.newImage("Images/Bear.png", 800, 200)

Catbug.x = 200
Catbug.y = 200
local function MoveCatbug(event)
	Catbug.x = Catbug.x + scrollSpeed 
	Catbug.alpha = Catbug.alpha - 0.001
end
	
Runtime:addEventListener("enterFrame", MoveCatbug)
