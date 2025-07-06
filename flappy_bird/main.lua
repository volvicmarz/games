local love = require("love")
local anim8 = require("libraries/anim8")
class = require("class")
require("Pipe")
require("PipePair")

local pipePairs = {}
local timer = 0
local lastY = -pipe_height + math.random(80) + 20
function love.load()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	background = love.graphics.newImage("assets/background/background1.png")
	background_scroll = 0
	bg_speed = 30

	ground = love.graphics.newImage("assets/background/ground.png")
	groundH = ground:getHeight()
	ground_scroll = 0
	g_speed = 60

	windowW, windowH = love.graphics.getDimensions()

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
	bgwidth, bgheight = background:getDimensions()
	gwidth, gheight = ground:getDimensions()

	bgscaleX = 800 / bgwidth
	bgscaleY = 600 / bgheight
end

function love.update(dt)
	animation:update(dt)

	background_scroll = (background_scroll + bg_speed * dt)
	ground_scroll = (ground_scroll + g_speed * dt)
	playerx = playerx + xvel * dt
	yvel = yvel + gravity * dt
	playery = playery + yvel * dt

	timer = timer + dt
	if timer > 2 then
		local y = math.max(-pipe_height + 10, math.min(lastY + math.random(-20, 20), windowH - 90 - pipe_height))
		lastY = y
		table.insert(pipePairs, PipePair(y))
		timer = 0
	end
	for k, pair in pairs(pipePairs) do
		pair:update(dt)
	end

	for k, pair in pairs(pipePairs) do
		if pair.remove then
			table.remove(pipePairs, k)
		end
	end
end

function love.keypressed(key)
	if key == "space" then
		yvel = jump
	elseif key == "escape" then
		love.event.quit()
	end
end
function love.draw()
	for i = -(background_scroll % bgwidth), windowW, bgwidth do
		love.graphics.draw(background, i, 0, 0, bgscaleX, bgscaleY)
	end
	for k, pair in pairs(pipePairs) do
		pair:render()
	end
	for i = -(ground_scroll % gwidth), windowW, gwidth do
		love.graphics.draw(ground, i, windowH - groundH)
	end

	animation:draw(player, playerx, playery, 0, 3, 3)
end
