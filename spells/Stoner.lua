Stoner = class {}
Stoner.__name = "Stoner"
Stoner.__type = "Spell"

function Stoner:__init(x,y,velocity,image)
	self.x = x
	self.y = y
	self.image = image
	self.speed = Const.Spell.Stoner.Speed
	self.velocity = velocity
	self.spriteSize = Const.Spell.Stoner.SpriteSize
	self.animationSpeed = Const.Spell.Stoner.AnimationSpeed
	
	-- Setup Animations
	self.grid = anim8.newGrid(self.spriteSize,self.spriteSize,self.image:getWidth(),self.image:getHeight(),-5,-5,24)
	self.animation = anim8.newAnimation(self.grid(1,1,2,1,3,1,4,1),self.animationSpeed)
end

function Stoner:update(dt)
	if self.velocity.x == 1 then
		self.x = self.x + self.speed
	elseif self.velocity.x == -1 then
		self.x = self.x - self.speed
	elseif self.velocity.y == 1 then
		self.y = self.y + self.speed
	elseif self.velocity.y == -1 then
		self.y = self.y - self.speed
	end
end