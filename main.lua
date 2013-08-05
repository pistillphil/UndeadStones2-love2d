class = require 'libs.30log'
anim8 = require 'libs.anim8'
HC = require 'libs.HardonCollider'

require 'Constants'
require 'Player'
require 'Enemy'
require 'Skeleton'


function love.load()
	shotHitboxes = false
	Collider = HC(100,onCollide,collisionStop)
	playerImage = love.graphics.newImage("img/betty_0.png")
	skeletonImage = love.graphics.newImage("img/zombie_n_skeleton2.adjusted.png")

	player = Player:new(100,100,playerImage)
	enemies = {}
	
	-- test stuff
	table.insert(enemies,Skeleton:new(300,300,skeletonImage))
	table.insert(enemies,Skeleton:new(400,300,skeletonImage))
	table.insert(enemies,Skeleton:new(500,300,skeletonImage))
	table.insert(enemies,Skeleton:new(600,300,skeletonImage))
	
	enemies[2].currentAnimation = enemies[2].animation.left
	enemies[3].currentAnimation = enemies[3].animation.up
	enemies[4].currentAnimation = enemies[4].animation.right
	
	-- test end
end

function love.update(dt)
	-- Movement
	local anyKeyPressed = false
	if up and player.y > 0 then
		player:move(0,-Const.Player.Speed*dt)
		anyKeyPressed = true
	end
	if left and player.x > 0 then
		player:move(-Const.Player.Speed*dt,0)
		anyKeyPressed = true
	end
	if down and player.y < love.graphics.getHeight() - Const.Player.SpriteSize then
		player:move(0,Const.Player.Speed*dt)
		anyKeyPressed = true
	end
	if right and player.x < love.graphics.getWidth() - Const.Player.SpriteSize then
		player:move(Const.Player.Speed*dt,0)
		anyKeyPressed = true
	end
	
	-- Update Entities
	player:update(dt)
	
	for key,value in ipairs(enemies) do
		value:update(dt)
	end
	
	
	-- Collision detection
	Collider:update(dt)
	
	-- Player walkanimation
	if anyKeyPressed then
		player.currentAnimation:update(dt)
	end
	
	-- enemy walkanimation 
	for key,value in ipairs(enemies) do
		value.currentAnimation:update(dt)
	end
	
	-- Determine draw order
	drawUnderPlayer = {}
	drawOverPlayer = {}
	
	for key,value in ipairs(enemies) do
		local width,height = value:getRealSize()
		if player.y + Const.Player.SpriteSize > (value.y + height) then
			table.insert(drawUnderPlayer,value)
		else
			table.insert(drawOverPlayer,value)
		end
	end

end

function love.draw()

	if showHitboxes then
		player.rect:draw('fill')
		for key, enemy in ipairs(enemies)do
			enemy.rect:draw('fill')
			
		end
	end
	
	for key,value in ipairs(drawUnderPlayer) do
		value.currentAnimation:draw(value.image,value.x,value.y,0,value.scale,value.scale)
	end

	player.currentAnimation:draw(player.image,player.x,player.y)
	
	for key,value in ipairs(drawOverPlayer) do
		value.currentAnimation:draw(value.image,value.x,value.y,0,value.scale,value.scale)
	end
	
	drawUnderPlayer = nil
	drawOverPlayer = nil
	
end

function love.keypressed(key,unicode)

	--player movement
	if key == "w" then
		up = true
	end
	if key == "a" then
		left = true
	end
	if key == "s" then
		down = true
	end
	if key == "d" then
		right = true
	end
	
	--misc
	if key == "escape" then
		love.event.push("quit")
	elseif key == "f3" then
		love.graphics.toggleFullscreen()
	elseif key =="f2" then
		showHitboxes = not showHitboxes
	end
end

function love.keyreleased(key,unicode)
	if key == "w" then
		up = false
	end
	if key == "a" then
		left = false
	end
	if key == "s" then
		down = false
	end
	if key == "d" then
		right = false
	end
end

function onCollide(dt,shapeA,shapeB)

end

function collisionStop(dt,shapeA,shapeB)

end