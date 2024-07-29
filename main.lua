require("objects.bird")
require("score")
require("utils")

local loser = false
local firstRound = true

function love.load()
	local mainFont = love.graphics.newFont(20, "mono")
	love.graphics.setFont(mainFont)

	Bird:load()

	Object = require("classic")
	require("objects.pipe")
	pipesSpawns = { Pipe(false), Pipe(true) }

	pause = false
	Score:load()
end

function love.update(dt)
	if not firstRound then
		Bird:update(dt)
		pipesSpawns[1]:update(dt)
		pipesSpawns[2]:update(dt)
		checkCollision()
		checkScore()
	end
end

function love.draw()
	if firstRound then
		Bird:draw()
		love.graphics.print(
			"Press space to start playing.",
			love.graphics.getWidth() / 7,
			love.graphics.getHeight() / 5 * 2
		)
	elseif pause then
		love.graphics.print("Game Paused", love.graphics.getWidth() / 5, love.graphics.getHeight() / 5 * 2)
	elseif loser then
		Score:updateBestScore()
		love.graphics.print(
			"Game Over\nPress r to restart game.",
			love.graphics.getWidth() / 5,
			love.graphics.getHeight() / 5 * 2
		)
	else
		Bird:draw()
		pipesSpawns[1]:draw()
		pipesSpawns[2]:draw()
	end
	love.graphics.print("Score: " .. Score.current, love.graphics.getWidth() / 5 * 2, 10)
	love.graphics.print("Best Score: " .. Score.best, 10, 10)
end

function love.keypressed(key)
	if key == "escape" or key == "q" then
		love.event.quit()
	elseif key == "r" then
		resetGame()
	elseif key == "p" then
		pause = not pause
	elseif firstRound and key == "space" then
		firstRound = not firstRound
	end
end

function checkCollision()
	for i, _ in ipairs(pipesSpawns) do
		if checkPipeCollision(Bird, pipesSpawns[i]) then
			loser = true
			break
		end
	end
end

function checkScore()
	for i, _ in ipairs(pipesSpawns) do
		Score:shouldScore(crossedPipe(Bird, pipesSpawns[i]) and pipesSpawns[i].wasCrossed and not loser)
	end
end

function resetGame()
	firstRound = true
	loser = false
	love:load()
end
