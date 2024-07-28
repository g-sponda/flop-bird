Score = {}

local fileName = ".points"

function Score:load()
	self.current = 0
	self.best = readScore()
	self.pipeCrossed = false
end

function Score:shouldScore(pipeCrossed)
	if not self.pipeCrossed and pipeCrossed then
		self.current = self.current + 1
		self.pipeCrossed = true
	elseif not pipeCrossed then
		self.pipeCrossed = false
	end
end

function Score:updateBestScore()
	if self.best < self.current then
		self.best = self.current
		writeScore(self.best)
	end
end

function readScore()
	local f = io.open(fileName, "r")
	if f then
		local bestScore = tonumber(f:read("l"))
		f:close()
		return bestScore
	else
		return 0
	end
end

function writeScore(score)
	local f = io.open(fileName, "w")
	f:write(score)
	f:close()
end
