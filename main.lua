class = require 'libs.30log'
anim8 = require 'libs.anim8'
HC = require 'libs.HardonCollider'

require 'Constants'
require 'Player'
require 'Enemy'
require 'Skeleton'
require 'Goblin'
require 'spells.Stoner'
require 'spells.Manager'


function love.load()
	shotHitboxes = false
	Collider = HC(100,onCollide,collisionStop)
	castPossible = true
	playerImage = love.graphics.newImage("img/betty_0.png")
	skeletonNGoblinImage = love.graphics.newImage("img/zombie_n_skeleton2.adjusted.png")
	stonerImage = love.graphics.newImage("img/plasmaball.png")

	player = Player:new(100,100,playerImage)
	enemies = {}
	spells = {}
	
	-- test stuff
	table.insert(enemies,Skeleton:new(300,300,skeletonNGoblinImage))
	table.insert(enemies,Skeleton:new(400,300,skeletonNGoblinImage))
	table.insert(enemies,Skeleton:new(500,300,skeletonNGoblinImage))
	table.insert(enemies,Skeleton:new(600,300,skeletonNGoblinImage))
	
	enemies[2].currentAnimation = enemies[2].animation.left
	enemies[3].currentAnimation = enemies[3].animation.up
	enemies[4].currentAnimation = enemies[4].animation.right
	
	table.insert(enemies,Goblin:new(300,400,skeletonNGoblinImage))
	table.insert(enemies,Goblin:new(400,400,skeletonNGoblinImage))
	table.insert(enemies,Goblin:new(500,400,skeletonNGoblinImage))
	table.insert(enemies,Goblin:new(600,400,skeletonNGoblinImage))
	
	enemies[6].currentAnimation = enemies[6].animation.left
	enemies[7].currentAnimation = enemies[7].animation.up
	enemies[8].currentAnimation = enemies[8].animation.right
	
	-- test end
end

function love.update(dt)
	-- Movement
	local anyKeyPressed = false
	if up and player.y > 0 then
		player:move(0,-Const.Player.Speed)
		anyKeyPressed = true
	end
	if left and player.x > 0 then
		player:move(-Const.Player.Speed,0)
		anyKeyPressed = true
	end
	if down and player.y < love.graphics.getHeight() - Const.Player.SpriteSize then
		player:move(0,Const.Player.Speed)
		anyKeyPressed = true
	end
	if right and player.x < love.graphics.getWidth() - Const.Player.SpriteSize then
		player:move(Const.Player.Speed,0)
		anyKeyPressed = true
	end
	
	-- cast spells
	cast()
	
	-- Update Entities
	player:update(dt)
	
	for key,value in ipairs(enemies) do
		value:update(dt)
	end
	
	for key,value in ipairs(spells) do
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
	
	-- spell animation
	for key,value in ipairs(spells) do
		value.animation:update(dt)
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
	
	SpellManager.removeUnneded(spells)
	
end

function love.draw()

	if showHitboxes then
		player.rect:draw('fill')
		for key, value in ipairs(enemies) do
			value.rect:draw('fill')	
		end
		for key,value in ipairs(spells) do
			value.rect:draw('fill')
		end
	end
	
	for key,value in ipairs(drawUnderPlayer) do
		value.currentAnimation:draw(value.image,value.x,value.y,0,value.scale,value.scale)
	end

	player.currentAnimation:draw(player.image,player.x,player.y)
	
	for key,value in ipairs(drawOverPlayer) do
		value.currentAnimation:draw(value.image,value.x,value.y,0,value.scale,value.scale)
	end
	
	for key,value in ipairs(spells) do
		value.animation:draw(value.image,value.x,value.y,0,value.scale,value.scale)
	end
	
	drawUnderPlayer = nil
	drawOverPlayer = nil
	
	-- Debug Stuff
	love.graphics.print("HP: " .. player.hp,0,0)
	love.graphics.print("FPS: " .. love.timer.getFPS(),300,0)
	love.graphics.print("Time: " .. love.timer.getTime(),400,0)
	love.graphics.print("NumberOfSpells: " .. #spells,500,36)
	love.graphics.print("NumberOfEnemies: " .. #enemies,500,24)
	if player.hitTime then
		love.graphics.print("TimeSinceHit: " .. love.timer.getTime() - player.hitTime,500,0)
	end
	if lastCast  then
		love.graphics.print("TimeSinceCast: " .. love.timer.getTime() - lastCast,500,12)
	end
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
	
	-- player spells
	if key == "up" then
		castUp = true
	elseif key == "left" then
		castLeft = true
	elseif key == "down" then
		castDown = true
	elseif key == "right" then
		castRight = true
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

-- player spells
	if key == "up" then
		castUp = false
	elseif key == "left" then
		castLeft = false
	elseif key == "down" then
		castDown = false
	elseif key == "right" then
		castRight = false
	end
end

function onCollide(dt,shapeA,shapeB)
	if shapeA.entity == player then
		player:collide(shapeB)
	elseif shapeB.entity == player then
		player:collide(shapeA)
	end
end

function collisionStop(dt,shapeA,shapeB)

end

function cast()
	if lastCast ~= nil and love.timer.getTime() - lastCast > Const.Spell.Stoner.Frequency then
		castPossible = true
		lastCast = nil
	end
	if castPossible then
		if player.currentSpell == "Stoner" then
			if castUp then
				table.insert(spells,Stoner:new(player.x,player.y,{x = 0,y = -1},stonerImage))
				lastCast = love.timer.getTime()
				castPossible = false
			elseif castLeft then
				table.insert(spells,Stoner:new(player.x,player.y,{x = -1,y = 0},stonerImage))
				lastCast = love.timer.getTime()
				castPossible = false
			elseif castDown then
				table.insert(spells,Stoner:new(player.x,player.y,{x = 0,y = 1},stonerImage))
				lastCast = love.timer.getTime()
				castPossible = false
			elseif castRight then
				table.insert(spells,Stoner:new(player.x,player.y,{x = 1,y = 0},stonerImage))
				lastCast = love.timer.getTime()
				castPossible = false
			end
		end
	end
end