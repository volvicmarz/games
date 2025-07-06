Pipe = class()

local pipe_image = love.graphics.newImage("assets/background/pipe.png")

local pipe_scroll = -60
pipe_height = 288
pipe_width = 70

function Pipe:init(orientation, y)
	self.x = windowW
	self.y = math.random(windowH / 2, windowH - 10)

	self.width = pipe_image:getWidth()
	self.height = pipe_height
	self.orientation = orientation
end

function Pipe:update(dt)
	self.x = self.x + pipe_scroll * dt
end

function Pipe:render()
	love.graphics.draw(
		pipe_image,
		self.x,
		(self.orientation == "top" and self.y + pipe_height or self.y),
		0,
		1,
		self.orientation == "top" and -1 or 1
	)
end
