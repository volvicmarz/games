local love = require("love")
local anim8 = require("libraries/anim8")

function love.load()
	player = love.graphics.newImage("assets/Player/StyleBird1/AllBird1.png")
	player:setFilter("nearest", "nearest")
	playerx = 50
	playery = 300
	xvel = 150
	yvel = 30
	jump = -300
	gravity = 900
	local grid = anim8.newGrid(16, 16, player:getWidth(), player:getHeight())
	animation = anim8.newAnimation(grid("1-4", 1), 0.1)
	background = love.graphics.newImage("assets/Background/Background1.png")
	background:setFilter("nearest", "nearest")
	local bgwidth = background:getWidth()
	local bgheight = background:getHeight()

	bgscaleX = 800 / bgwidth
	bgscaleY = 600 / bgheight
end

function love.update(dt)
	animation:update(dt)

	playerx = playerx + xvel * dt
	yvel = yvel + gravity * dt
	playery = playery + yvel * dt
end
function love.keypressed(key)
	if key == "space" then
		yvel = jump
	end
end
function love.draw()
	love.graphics.draw(background, 0, 0, 0, bgscaleX, bgscaleY)
	animation:draw(player, playerx, playery, 0, 3, 3)
end
