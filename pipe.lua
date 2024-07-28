Pipe = Object:extend()

local PIPE_GAP_DIV_CALCULATOR = 7
local PIPE_GAP_MOST_TOP = love.graphics.getHeight() / PIPE_GAP_DIV_CALCULATOR
local PIPE_GAP_MOST_BOTTOM = PIPE_GAP_MOST_TOP * (PIPE_GAP_DIV_CALCULATOR - 2)

function Pipe:new(secondary)
	self.top = { y = 0 }
	self.bottom = {}
	local secondary = secondary or false
	self.width = 40

	self.x = love.graphics.getWidth()
	if secondary then
		self:checkSpawnSecondary()
	end

	self.speed = 200
	self.gapSize = Bird.height * 5

	self:randomizePipesGapY()
	self.wasCrossed = false
	Pipe:checkSpawnSecondary()
end

function Pipe:checkSpawnSecondary()
	self.x = love.graphics.getWidth() * 1.5
end

function Pipe:update(dt)
	if self.x >= -self.width then
		self.x = self.x - self.speed * dt
	else
		self:new(self.secondary)
	end
end

function Pipe:randomizePipesGapY()
	local rndNum = love.math.random(PIPE_GAP_MOST_TOP, PIPE_GAP_MOST_BOTTOM)

	self.top.height = rndNum

	self.bottom.y = self.top.height + self.gapSize
	self.bottom.height = love.graphics.getHeight() - self.bottom.y
end

function Pipe:draw()
	love.graphics.rectangle("fill", self.x, self.top.y, self.width, self.top.height)
	love.graphics.rectangle("fill", self.x, self.bottom.y, self.width, self.bottom.height)
end
