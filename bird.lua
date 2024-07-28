require("utils")

Bird = {}
local MAX_VELOCITY = 25

function Bird:load()
	self.width = 20
	self.height = 20

	self.x = love.graphics.getWidth() / 2 - self.width / 2
	self.y = love.graphics.getHeight() / 2 - self.height / 2

	self.vel = 0
	self.gravity = 15

	self.wasJumpPressed = false
end

function Bird:update(dt, pipes)
	Bird:up(dt)
	Bird:down(dt)
	Bird:checkBoundaries()
	-- Bird:checkCollision(pipes)
end

function Bird:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Bird:checkBoundaries()
	if self.y <= 0 then
		self.y = 0
	elseif self.y + self.height > love.graphics.getHeight() then
		self.y = love.graphics.getHeight() - self.height
	end
end

function Bird:down(dt)
	self.y = self.y + self.vel + (self.gravity * dt)
end

function Bird:up(dt)
	self.vel = self.vel + self.gravity * dt
	if love.keyboard.isDown("space") and not self.wasJumpPressed then
		self.vel = -5
		self.wasJumpPressed = true
	end
	if self.vel > MAX_VELOCITY then
		self.vel = MAX_VELOCITY
	end
	self.y = self.y - self.vel * dt

	function love.keyreleased(key)
		if key == "space" then
			self.wasJumpPressed = false
		end
	end
end
