Player = class {}

function Player:__init(x,y,image)
	self.x = x
	self.y = y
	self.spriteWidth = Const.Player.SpriteSize
	self.spriteHeight = Const.Player.SpriteSize
	self.image = image
	self.animation = {}
	self.rect = Collider:addRectangle(self.x,self.y,Const.Player.SpriteSize,Const.Player.SpriteSize)

	--Setup Animations
	self.grid = anim8.newGrid(Const.Player.SpriteSize,Const.Player.SpriteSize,self.image:getWidth(),self.image:getHeight(),Const.Player.HorizontalSpriteOffset,Const.Player.VerticalSpriteOffset,Const.Player.SpriteBorders)
	self.animation.up = anim8.newAnimation(self.grid(3,1,3,2,3,3,3,4),Const.Player.AnimationSpeed)
	self.animation.left = anim8.newAnimation(self.grid(2,1,2,2,2,3,2,4),Const.Player.AnimationSpeed)
	self.animation.down = anim8.newAnimation(self.grid(1,1,1,2,1,3,1,4),Const.Player.AnimationSpeed)
	self.animation.right = anim8.newAnimation(self.grid(4,1,4,2,4,3,4,4),Const.Player.AnimationSpeed)

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

function Player:update(dt)
	self.rect:moveTo(self.x + self.spriteWidth/2,self.y + self.spriteHeight/2)
end
