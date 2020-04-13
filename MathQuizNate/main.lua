----------------------------------------------------------------------------------------------------
-- Title: MathQuizNate
-- Name: Nate 
-- Course: ICS2O
-- This is the fifth Major assignment: Math quiz 
----------------------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar) 

-- sets the background colour
display.setDefault("background", 99/255, 0/255, 77/255)

------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
------------------------------------------------------------------------------------------------

-- create local variables
local randomOperator
local questionObject
local correctObject
local incorrectObject

local numericField
local randomNumber1
local randomNumber2
local userAnswer
local tempAnswer
local correctAnswer
local correctAnswerText
local incorrectAnswer
local points = 0
local wrongs = 0

-- timer vaiables 
local TOTAL_SECONDS = 10
local secondsLeft = 10
local clockText 
local countDownTimer
-- variables for lives 
local lives = 4
local heart1
local heart2
local heart3

local stopGame = false 
------------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------------

-- This function generates a math question which the user will be asked and required to input 
-- an answer
local function AskQuestion()

    -- generate a random number between 1 and 7 which will decide what operator to do
    randomOperator = math.random(1, 7)
    
    -- if the random operator is 1, then do addition
    if (randomOperator == 1) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 20)
        randomNumber2 = math.random(1, 20)

        -- calculate the correct answer
        correctAnswer = randomNumber1 + randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
    
    -- otherwise, if the random operator is 2, do subtraction
    elseif (randomOperator == 2) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 20)
        randomNumber2 = math.random(1, 20)        

        -- to ensure we get no negative answers:
        if (randomNumber2 > randomNumber1) then
        
            -- calculate answer with numbers flipped
            correctAnswer = randomNumber2 - randomNumber1

            -- create question in text object
            questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "

        else 

	        -- calculate the correct answer
	        correctAnswer = randomNumber1 - randomNumber2

	        -- create question in text object
            questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

        end

    -- otherwise, if the random operator is 3, do multiplication
    elseif (randomOperator == 3) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 10)
        randomNumber2 = math.random(1, 10) 

        -- calculate the correct answer
        correctAnswer = randomNumber1*randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

     -- otherwise, if the random operator is 4, do division
    elseif (randomOperator == 4) then

        -- generate 2 random numbers between a max. and a min. number
	    randomNumber1 = math.random(1, 10)
        randomNumber2 = math.random(1, 10) 

        -- calculate the correct answer
        tempAnswer = randomNumber1*randomNumber2

        randomNumber1 = tempAnswer

        correctAnswer = randomNumber1/randomNumber2

        -- create question in text object
        questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "

    elseif (randomOperator == 5) then

        -- generate a random number between a max. and a min. number
        randomNumber1 = math.random(1, 6)
        
        -- intializations
        correctAnswer = 1
        counter = 1

        -- calculate the correct answer
        while (counter <= randomNumber1) do

            correctAnswer = correctAnswer * counter
            
            counter = counter + 1

        end

        -- create question in text object
        questionObject.text = randomNumber1 .. "! = "

    elseif (randomOperator == 6) then

        -- generate 2 random numbers between a max. and a min. number
        randomNumber1 = math.random(1, 6)
        randomNumber2 = math.random(1, 5)

        -- intializations
        correctAnswer = 1
        counter = 1
        
        -- calculate the correct answer
        while (counter <= randomNumber2) do

            correctAnswer = correctAnswer * randomNumber1

            counter = counter + 1

        end

        -- create question in text object
        questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = "

    elseif (randomOperator == 7) then

        -- generate a random number between a max. and a min. number
        randomNumber1 = math.random(1, 10)

        -- calculate the correct answer
        randomNumber1 = randomNumber1 * randomNumber1

        correctAnswer = math.sqrt(randomNumber1)

        -- create question in text object
        questionObject.text = "√" .. randomNumber1 .. " = "

    end

end

-- This function is used after a question was answered wrong or the time runs out, and it updates the number of lives remaining
local function LoseLives()

    -- play incorrect sound
    incorrectSoundChannel = audio.play(incorrectSound)
    
    -- subtract a life
    lives = lives - 1
    
    -- reset the number of seconds
	secondsLeft = TOTAL_SECONDS

    if (lives == 3) then
        
        -- make heart 3 invisible
        heart3.isVisible = false

    elseif (lives == 2) then
        
        -- make heart 2 invisible
        heart2.isVisible = false

    elseif (lives == 1) then
        
        -- make heart 1 invisible
        heart1.isVisible = false

        -- stop the game from doing AskQuestion()
        stopGame = true

        -- get rid of the timer
        timer.cancel(countDownTimer)
        clockText.isVisible = false

        -- make the quesion text invisible
        questionObject.isVisible = false

        -- display the game over image
        gameOverObject.isVisible = true

        -- stop the background music
        backgroundSound = audio.stop(backgroundSoundChannel)

        -- play the game over music
        gameOverSoundChannel = audio.play(gameOverSound)

        -- make the numeric field invisible
        numericField.isVisible = false

    end
    
end

-- This function hides the correct answer text 
local function HideCorrectAnswerText()

    correctAnswerText.isVisible = false
    
end

-- This function updates the time remaining
local function UpdateTime() 

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = "Time Remaining: " .. secondsLeft .. ""

    if (secondsLeft == 0) then

		-- play incorrect answer sound
        incorrectSoundChannel = audio.play(incorrectSound)

        -- show the correct answer
        correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5) - 60, nil, 50)
        correctAnswerText:setTextColor(204/255, 204/255, 0/255)
        correctAnswerText.isVisible = true

        timer.performWithDelay(2000, HideCorrectAnswerText)

        LoseLives()
        
        -- if the game has not been stopped, call AskQuestion()
        if (stopGame == false) then
        
            AskQuestion()
        
        end
        
    end
    
end

-- This function calls the timer
local function StartTimer()

	-- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
        
end

-- This function hides the "Good Job!" text
local function HideCorrect()

    correctObject.isVisible = false
    
    AskQuestion()
 
end

-- This function hides the "Sorry that's incorrect!" text
local function HideIncorrect()

    incorrectObject.isVisible = false
    
    -- if the game has not been stopped, call AskQuestion()
    if (stopGame == false) then
        
        AskQuestion()
    
    end
    
end

local function SpinYouWin()

    if (amountSpun < 1080) then

        -- make the You Win image spin
        youWinObject:rotate(5)

        amountSpun = amountSpun + 5

    end

end

-- This function controls the numeric field that a user can input answers into
local function NumericFieldListener(event)

	-- user begins editing "numericField"
	if (event.phase == "began") then

		-- clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- if the user's answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
		
			-- give a point
            points = points + 1

            -- display "Correct!"
            correctObject.isVisible = true

            -- play a correct answer sound
            correctSoundChannel = audio.play(correctSound)
            
            -- reset the number of seconds on the timer
			secondsLeft = TOTAL_SECONDS

			-- update it in the display object
			pointsText.text = "Number Correct = " .. points

			-- perform HideCorrect with a delay and clear the text field
            timer.performWithDelay(1500, HideCorrect)
            
            --clear the text field
            event.target.text = ""
            
            -- if the user reaches 5 points, they win
            if (points == 5) then

                -- stop the game from doing AskQuestion()
                stopGame = true

                -- get rid of the timer
                timer.cancel(countDownTimer)
                clockText.isVisible = false
                
                -- make the quesion text invisible 
                questionObject.isVisible = false
                
                -- display the you win image and call the function to make the image spin
                youWinObject.isVisible = true

                -- image animation for You Win
                amountSpun = 0
                SpinYouWin()
                
                -- stop the background music
                backgroundSound = audio.stop(backgroundSoundChannel)

                -- play the you win music
                youWinSoundChannel = audio.play(youWinSound)
                
                -- make the numeric field invisible
                numericField.isVisible = false

            end

		else

			-- display "Incorrect!" for 2 seconds
            incorrectObject.isVisible = true
            timer.performWithDelay(2000, HideIncorrect)

            -- tell the user the correct answer for 2 seconds
            correctAnswerText = display.newText( "The correct answer is " .. correctAnswer, display.contentWidth/2, display.contentHeight*(4/5) - 35, nil, 50)
            correctAnswerText:setTextColor(204/255, 204/255, 0/255)
            correctAnswerText.isVisible = true
            timer.performWithDelay(2000, HideCorrectAnswerText)
            
            -- clear the text field
            event.target.text = ""
            
            -- call the LoseLives() function to update the number of lives remaining
			LoseLives()

			-- play incorrect answer sound
            incorrectSoundChannel = audio.play(incorrectSound)
            
        end	
        
    end
    
end

------------------------------------------------------------------------------------------------
-- OBJECT CREATION
------------------------------------------------------------------------------------------------

-- display the amount of points as a text object
pointsText = display.newText("Points = " .. points, display.contentWidth*(8/10), display.contentHeight*(1/20), nil, 50)
pointsText:setTextColor(255/255, 255/255, 255/255)

-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/2 - 50, display.contentHeight/2, nil, 100 )
questionObject:setTextColor(155/255, 42/255, 198/255)
questionObject.isVisible = true 

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*8/10, nil, 50 )
correctObject:setTextColor(0/255, 0/255, 204/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(204/255, 0/255, 102/255)
incorrectObject.isVisible = false

-- create numeric field
numericField = native.newTextField( display.contentWidth*(9/10), display.contentHeight/2, 150, 100 )
numericField.inputType = "number"
numericField.isVisible = true 

-- add the event listeners for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-- create game over image
gameOverObject = display.newImage("Images/gameOver.png")
gameOverObject.x = display.contentWidth * 1 / 2
gameOverObject.y = display.contentWidth * 1 / 2 - 155
gameOverObject:scale(1, 1)
gameOverObject.isVisible = false

-- create hte lives to display on the screen 
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8 
heart1.y = display.contentHeight * 1 / 7 

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8 
heart2.y = display.contentHeight * 1 / 7 

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8 
heart3.y = display.contentHeight * 1 / 7 

-- create the text object for the clock 
clockText = display.newText( secondsLeft .. "", display.contentWidth*1/6, display.contentHeight*1/7, nil, 100)
clockText:setTextColor( 200/255, 194/255, 9/255)

------------------------------------------------------------------------------------------------
-- FUNCTION CALLS
------------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion() 

-- update timer 
StartTimer()

------------------------------------------------------------------------------------------------
-- SOUNDS
------------------------------------------------------------------------------------------------

-- Correct sound
local correctSound = audio.loadSound( "Sounds/correctSound.mp3" ) -- Setting a variable to a mp3 file
local correctSoundChannel

-- Wrong sound 
local incorrectSound = audio.loadSound( "Sounds/wrongSound.mp3" )
local incorrectSoundChannel

-- Background music 
local backgroundSound = audio.loadSound( "Sounds/RuneScape.mp3" )
local backgroundSoundChannel 

-- game over sound 
local gameOverSound = audio.loadSound( "Sounds/gameOver.mp3" )
local gameOverSoundChannel

-- play the background music for when the game starts 
backgroundSoundChannel = audio.play(backgroundSound)