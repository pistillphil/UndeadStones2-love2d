Player = class ()

function Player:__init(x,y,image)
	self.x = x
	self.y = y
	self.image = image
	self.animation = {}

	--Setup Animations
	self.grid = anim8.newGrid(playerSpriteSize,playerSpriteSize,self.image:getWidth(),self.image:getHeight(),playerSpriteHorizontalOffset,playerSpriteVerticalOffset,playerSpriteSheetBorders)
	self.animation.up = anim8.newAnimation(self.grid(3,1,3,2,3,3,3,4),playerAnimationSpeed)
	self.animation.left = anim8.newAnimation(self.grid(2,1,2,2,2,3,2,4),playerAnimationSpeed)
	self.animation.down = anim8.newAnimation(self.grid(1,1,1,2,1,3,1,4),playerAnimationSpeed)
	self.animation.right = anim8.newAnimation(self.grid(4,1,4,2,4,3,4,4),playerAnimationSpeed)

	self.currentAnimation = self.animation.down
end

function Player:move(x,y)
	self.x = self.x + x
	self.y = self.y + y

	--Determine the Player's facing
	if y < 0 then
		self.currentAnimation = self.animation.up
	elseif y > 0 then
		self.currentAnimation = self.animation.down
	elseif x < 0 then
		self.currentAnimation = self.animation.left
	elseif x > 0 then
		self.currentAnimation = self.animation.right
	end
end
