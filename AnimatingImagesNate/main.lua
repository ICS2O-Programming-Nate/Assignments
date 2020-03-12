------------------------------------------------------
-- Title: Animating Images
-- Name: Nate
-- Course: ICS2O/3C
-- This program moves images in differet directions with text
------------------------------------------------------


-- hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- set local variables  
local backgroundImage = display.newImageRect("Images/background.jpg", 2048, 1536)
local WaddleDee = display.newImage("Images/WaddleDee.png", 200, 200)
local Oswald = display.newImage("Images/Oswald.png", 400, 500)
local Bear = display.newImage("Images/Bear.png", 800, 200)

--------------------------------------------------------
-- scroll speeds 
scrollSpeed1 = 1
scrollSpeed2 = 2
scrollSpeed3 = 3

-- parabolic speeds
parabolicXSpeed = 5
parabolicYSpeed = 10
--------------------------------------------------------
-- WaddleDee function
--------------------------------------------------------

WaddleDee.alpha = 0
WaddleDee.x = 200
WaddleDee.y = 350
local function MoveWaddleDee(event)
	WaddleDee.x = WaddleDee.x + parabolicXSpeed
	WaddleDee.y = WaddleDee.y - parabolicYSpeed
	WaddleDee.alpha = WaddleDee.alpha + 0.01
	--make image rotate
	WaddleDee:rotate(-0.09)
 
end 
	
Runtime:addEventListener("enterFrame", MoveWaddleDee)

--------------------------------------------------------
-- Bear function
--------------------------------------------------------


local function MoveBear(event)
	Bear.x = Bear.x - scrollSpeed2
	Bear.alpha = Bear.alpha - 0.001 
	--make image rotate
	Bear:rotate(0.1)
end 

Runtime:addEventListener("enterFrame", MoveBear)

--------------------------------------------------------
-- Oswald function
--------------------------------------------------------

-- clarity of image 
Oswald.alpha = 0.1
local function MoveOswald(event)
	Oswald.x = Oswald.x + scrollSpeed3
	Oswald.y = Oswald.y + scrollSpeed1
	Oswald.alpha = Oswald.alpha + 0.009
	--make image rotate
	Oswald:rotate(5)
end 
	
Runtime:addEventListener("enterFrame", MoveOswald)

--------------------------------------------------------
-- text operations
--------------------------------------------------------

-- set text 
textObject = display.newText( "Greetings", 500, 50, nil, 50 )
-- sets the colour of the text 
textObject:setTextColor(225/225, 50/225, 170/225)

