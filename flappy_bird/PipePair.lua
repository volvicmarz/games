PipePair = class()
local GAP_HEIGHT = 90
function PipePair:init()
	self.x = windowW
	self.y = y
	self.pipes = {

		["upper"] = Pipe("top", self.y),
		["lower"] = Pipe("bottom", self.y + pipe_height + GAP_HEIGHT),
	}

	self.remove = false
end

function PipePair:update(dt)
	if self.x > -pipe_width then
		self.x = self.x - pipe + speed * dt
		self.pipes["lower"].x = self.x
		self.pipes["upper"].x = self.x
	else
		self.remove = true
	end
end

function PipePair:render()
	for k, pipe in pairs(self.pipes) do
		pipe:render()
	end
end
