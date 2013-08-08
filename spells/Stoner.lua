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
	self.scale = Const.Spell.Stoner.Scale
	self.animationSpeed = Const.Spell.Stoner.AnimationSpeed
	self.rect = Collider:addCircle(-100,-100,Const.Spell.Stoner.HitboxSize/2)
	self.rect.entity = self
	
	-- Setup Animations
	self.grid = anim8.newGrid(self.spriteSize,self.spriteSize,self.image:getWidth(),self.image:getHeight(),-16,-16,32)
	self.animation = anim8.newAnimation(self.grid(1,1,2,1,3,1,4,1),self.animationSpeed)
end

function Stoner:update(dt)
	if self.velocity.x == 1 then
		self.x = self.x + self.speed * dt
	elseif self.velocity.x == -1 then
		self.x = self.x - self.speed * dt
	elseif self.velocity.y == 1 then
		self.y = self.y + self.speed * dt
	elseif self.velocity.y == -1 then
		self.y = self.y - self.speed * dt
	end
	
	self.rect:moveTo(self.x + self.spriteSize/2 * self.scale ,self.y + self.spriteSize/2 * self.scale)
end