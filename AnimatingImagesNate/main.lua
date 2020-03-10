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

scrollSpeed1 = 1
scrollSpeed2 = 2
scrollSpeed3 = 3

Catbug.alpha = 0
Catbug.x = 200
Catbug.y = 200
local function MoveCatbug(event)
	Catbug.x = Catbug.x + scrollSpeed3
	Catbug.alpha = Catbug.alpha + 0.01 
end 
	
Runtime:addEventListener("enterFrame", MoveCatbug)



local function MoveBear(event)
	Bear.x = Bear.x - scrollSpeed2
	Bear.alpha = Bear.alpha - 0.001 
end 

Runtime:addEventListener("enterFrame", MoveBear)


local function MoveOswald(event)
	Oswald.x = Oswald.x + scrollSpeed1
	Oswald.alpha = Oswald.alpha + 0.01 
end 
	
Runtime:addEventListener("enterFrame", MoveOswald)
