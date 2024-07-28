require("utils")

Bird = {}
local MAX_VELOCITY = 25

function Bird:load()
	self.img = love.graphics.newImage("assets/bird.png")
	self.scale = 1.5
	self.width = self.img:getWidth() * self.scale
	self.height = self.img:getHeight() * self.scale

	self.x = love.graphics.getWidth() / 2 - self.width / 2
	self.y = love.graphics.getHeight() / 2 - self.height / 2

	self.vel = 0
	self.gravity = 15

	self.wasJumpPressed = false
end

function Bird:update(dt)
	Bird:up(dt)
	Bird:down(dt)
	Bird:checkBoundaries()
end

function Bird:draw()
	love.graphics.draw(self.img, self.x, self.y, 0, self.scale, self.scale)
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
		self.vel = -4
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
