function checkPipeCollision(obj, pipe)
	if
		obj.x + obj.width > pipe.x
		and pipe.x + pipe.width > obj.x
		and not (obj.y > pipe.top.height and obj.y + obj.height < pipe.bottom.y)
	then
		return true
	else
		return false
	end
end

function crossedPipe(obj, pipe)
	if
		obj.x > pipe.x + pipe.width
		and obj.y > pipe.top.height
		and obj.y + obj.height < pipe.bottom.y
		and not pipe.wasCrossed
	then
		pipe.wasCrossed = true
		return true
	else
		return false
	end
end
