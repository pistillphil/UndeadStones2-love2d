Goblin = Enemy:extends {}
Goblin.__name = "Goblin"

function Goblin:__init(x,y,image)
	self.spriteWidth = Const.Goblin.SpriteWidth
	self.spriteHeight = Const.Goblin.SpriteHeight - Const.Goblin.VerticalSpriteCut
	self.animationSpeed = Const.Goblin.AnimationSpeed
	self.scale = Const.Goblin.Scale
	local rect = Collider:addRectangle(-200,-200,self.spriteWidth*Const.Goblin.HorizontalHitboxScale,self.spriteHeight*Const.Goblin.VerticalHitboxScale)
	
	Skeleton.super.__init(self,x,y,image,rect)
	
	-- Setup Animations
	self.grid = anim8.newGrid(self.spriteWidth,self.spriteHeight + Const.Goblin.VerticalSpriteCut,self.image:getWidth(),self.image:getHeight(),0,24)
	
	self.animation.down = anim8.newAnimation(self.grid(1,1,2,1,3,1,2,1),self.animationSpeed)
	self.animation.left = anim8.newAnimation(self.grid(1,2,2,2,3,2,2,2),self.animationSpeed)
	self.animation.right = anim8.newAnimation(self.grid(1,3,2,3,3,3,2,3),self.animationSpeed)
	self.animation.up = anim8.newAnimation(self.grid(1,4,2,4,3,4,2,4),self.animationSpeed)

	self.currentAnimation = self.animation.down

end

function Goblin:update(dt)
	self.rect:moveTo(self.x + self.spriteWidth/2*self.scale,self.y + self.spriteHeight/2*self.scale)
end