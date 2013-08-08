SpellManager = class {}

function SpellManager.removeUnneded(spells)
	local toBeRemoved = {}
	
	for key,value in ipairs(spells) do
		if value.x < -128 or value.x > love.graphics.getWidth() + 128 or value.y < -128 or value.y > love.graphics.getHeight() + 128 then
			table.insert(toBeRemoved,key)
		end
	end
	
	for index,key in ipairs(toBeRemoved) do
		table.remove(spells,key)
	end
end