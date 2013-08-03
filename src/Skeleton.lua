Skeleton = Enemy:extends {}

function Skeleton:__init(x,y,image)
	self.spriteWidth = 32
	self.spriteHeight = 48
	self.skeletonAnimationSpeed = 0.4
	self.scale = 1.3

	Skeleton.super.__init(self,x,y,image)

	--Setup Animations
	self.grid = anim8.newGrid(self.spriteWidth,self.spriteHeight,self.image:getWidth(),self.image:getHeight(),0,16)

	self.animation.down = anim8.newAnimation(self.grid(4,1,5,1,6,1,5,1),self.skeletonAnimationSpeed)
	self.animation.left = anim8.newAnimation(self.grid(4,2,5,2,6,2,5,2),self.skeletonAnimationSpeed)
	self.animation.right = anim8.newAnimation(self.grid(4,3,5,3,6,3,5,3),self.skeletonAnimationSpeed)
	self.animation.up = anim8.newAnimation(self.grid(4,4,5,4,6,4,5,4),self.skeletonAnimationSpeed)

	self.currentAnimation = self.animation.down
end