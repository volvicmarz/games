local love = require("love")
local anim8 = require("libraries/anim8")
local sti = require("libraries/sti/")

function love.load()
	player = love.graphics.newImage("assets/player/StyleBird1/AllBird1.png")
	player:setFilter("nearest", "nearest")
	playerx = 50
	playery = 300
	xvel = 150
	yvel = 30
	jump = -300
	gravity = 900
	local grid = anim8.newGrid(16, 16, player:getWidth(), player:getHeight())
	animation = anim8.newAnimation(grid("1-4", 1), 0.1)
	background = love.graphics.newImage("assets/background/background1.png")
	background:setFilter("nearest", "nearest")
	local bgwidth = background:getWidth()
	local bgheight = background:getHeight()

	bgscaleX = 800 / bgwidth
	bgscaleY = 600 / bgheight

	map = sti("maps/ground.lua", { "box2d" })
	world = love.physics.newWorld(0, 0)
	map:box2d_init(world)
	-- map.layers.solid.visible = false
	pipes = {}
	pipes.topx = 100
	pipes.topy = 50
	pipes.gap = 100
	pipes.bottomx = 100
	pipes.bottomy = 150
end

function love.update(dt)
	animation:update(dt)

	map:update(dt)
	world:update(dt)
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
	map:draw(0, 0, 2, 2)

	animation:draw(player, playerx, playery, 0, 3, 3)
	map:box2d_draw()
end
