Skeleton = Enemy:extends {}
Skeleton.__name = "Skeleton"

function Skeleton:__init(x,y,image)
	self.spriteWidth = Const.Skeleton.SpriteWidth
	self.spriteHeight = Const.Skeleton.SpriteHeight
	self.animationSpeed = Const.Skeleton.AnimationSpeed
	self.scale = Const.Skeleton.Scale
	local rect = Collider:addRectangle(-200,-200,self.spriteWidth*Const.Skeleton.HorizontalHitboxScale,self.spriteHeight*Const.Skeleton.VerticalHitboxScale)

	Skeleton.super.__init(self,x,y,image,rect)

	--Setup Animations
	self.grid = anim8.newGrid(self.spriteWidth,self.spriteHeight,self.image:getWidth(),self.image:getHeight(),0,16)

	self.animation.down = anim8.newAnimation(self.grid(4,1,5,1,6,1,5,1),self.animationSpeed)
	self.animation.left = anim8.newAnimation(self.grid(4,2,5,2,6,2,5,2),self.animationSpeed)
	self.animation.right = anim8.newAnimation(self.grid(4,3,5,3,6,3,5,3),self.animationSpeed)
	self.animation.up = anim8.newAnimation(self.grid(4,4,5,4,6,4,5,4),self.animationSpeed)

	self.currentAnimation = self.animation.down
end

function Skeleton:update(dt)
	self.rect:moveTo(self.x + self.spriteWidth/2*self.scale,self.y + self.spriteHeight/2*self.scale)
end