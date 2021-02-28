function Global.SetFocusArea(x, y, z, offsetX, offsetY, offsetZ)
	return _in(0xBB7454BAFF08FE25, x, y, z, offsetX, offsetY, offsetZ)
end

--- It seems to make the entity's coords mark the point from which LOD-distances are measured. In my testing, setting a vehicle as the focus entity and moving that vehicle more than 300 distance units away from the player will make the level of detail around the player go down drastically (shadows disappear, textures go extremely low res, etc). The player seems to be the default focus entity.
function Global.SetFocusEntity(entity)