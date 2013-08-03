Enemy = class {}

function Enemy.__init(instance,x,y,image,rect)
	instance.x = x
	instance.y = y
	
	instance.image = image
	instance.rect = rect
	instance.animation = {}
end

function Enemy:move(x,y)
	self.x = self.x + x
	self.y = self.y + y
end

function Enemy:getRealSize()
	local width = self.spriteWidth*self.scale
	local height = self.spriteHeight*self.scale
	return width,height
end

function Enemy:update(dt)

end