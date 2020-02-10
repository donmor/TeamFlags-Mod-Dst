local function geteslotid(eslot)
	return eslot == EQUIPSLOTS.HANDS and 0 or EQUIPSLOTS.BODY and 1 or eslot == EQUIPSLOTS.BACK and 2 or 
		eslot == EQUIPSLOTS.WAIST and 3 or EQUIPSLOTS.NECK and 4 or eslot == EQUIPSLOTS.HEAD and 5
end

local function geteslotname(id)
	return id == 0 and EQUIPSLOTS.HANDS or id == 1 and EQUIPSLOTS.BODY or 
	id == 2 and (TUNING.BACKPACK_SLOT == 1 and EQUIPSLOTS.BACK or EQUIPSLOTS.BODY) or id == 3 and (TUNING.COMPASS_SLOT == 1 and EQUIPSLOTS.WAIST or EQUIPSLOTS.HANDS) or 
		id == 4 and (TUNING.AMULET_SLOT == 1 and EQUIPSLOTS.NECK or EQUIPSLOTS.HEAD) or id == 5 and EQUIPSLOTS.HEAD
end

local function oneslotid(self, eslotid)
	if self.inst and self.inst.components.equippable then
		self.inst.components.equippable.equipslot = geteslotname(eslotid)
	end
end

local function oncolor(self, color)
	local owner = self.inst and self.inst.components.inventoryitem and self.inst.components.inventoryitem:GetGrandOwner()
	if owner and owner.components.inventory and owner:HasTag("player") and self.inst.components.equippable:IsEquipped() then
		owner.teamcolor = color
	end
end

local TeamFlags = Class(function(self, inst)
	self.inst = inst
	self.color = TEAMCOLORS.RED
	self.eslotid = 0
end,
nil,
{
	eslotid = oneslotid, 
	color = oncolor
})

function TeamFlags:SetColor(color)
	self.color = color
end

function TeamFlags:GetColor()
	return self.color
end

function TeamFlags:GetEquipSlot()
	return geteslotname(self.eslotid)
end

function TeamFlags:GetEquipSlotID()
	return self.eslotid
end

function TeamFlags:OnSave()
	local data = { color = self.color, eslotid = self.eslotid }
	return data
end

function TeamFlags:OnLoad(data, newents)
	if data.color then
		self.color = data.color
	end
	if data.eslotid then
		self.eslotid = data.eslotid
	end
end

function TeamFlags:SetEquipSlot(eslot)
	if self.inst.components.inventoryitem == nil or self.inst.components.equippable == nil then
		return
	end
	local id = geteslotid(eslot)
	local owner = self.inst.components.inventoryitem:GetGrandOwner()
	if owner and owner.components.inventory and self.inst.components.equippable:IsEquipped() then
		owner.components.inventory:Unequip(geteslotname(self.eslotid))
		self.eslotid = id
		owner.components.inventory:Equip(self.inst)
		return true
	else
		self.eslotid = id
		return true
	end
end

function TeamFlags:ChangeEquipSlot()
	if self.inst.components.inventoryitem == nil or self.inst.components.equippable == nil then
		return
	end
	local owner = self.inst.components.inventoryitem:GetGrandOwner()
	owner.components.inventory:Unequip(geteslotname(self.eslotid))
	if self.eslotid >= 5 then
		self.eslotid = 0
	elseif self.eslotid == 1 and TUNING.BACKPACK_SLOT ~= 1 then
		self.eslotid = 2
	else
		self.eslotid = self.eslotid + 1
	end
	owner.components.inventory:Equip(self.inst)
	return true	
end

return TeamFlags