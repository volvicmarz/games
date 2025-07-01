local love = require("love")
local anim8 = require("libraries/anim8")

function love.load()
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
	for i = -(ground_scroll % gwidth), windowW, gwidth do
		love.graphics.draw(ground, i, windowH - groundH)
	end

	animation:draw(player, playerx, playery, 0, 3, 3)
end
