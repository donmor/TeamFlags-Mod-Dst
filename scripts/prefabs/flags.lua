local assets =
{
	Asset( "IMAGE", "images/inventoryimages/red_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/red_flag.xml" ),
	Asset( "IMAGE", "images/inventoryimages/orange_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/orange_flag.xml" ),
	Asset( "IMAGE", "images/inventoryimages/yellow_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/yellow_flag.xml" ),
	Asset( "IMAGE", "images/inventoryimages/green_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/green_flag.xml" ),
	Asset( "IMAGE", "images/inventoryimages/blue_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/blue_flag.xml" ),
	Asset( "IMAGE", "images/inventoryimages/purple_flag.tex" ),
	Asset( "ATLAS", "images/inventoryimages/purple_flag.xml" ),
	Asset( "ANIM", "anim/red_flag.zip" ),
	Asset( "ANIM", "anim/orange_flag.zip" ),
	Asset( "ANIM", "anim/yellow_flag.zip" ),
	Asset( "ANIM", "anim/green_flag.zip" ),
	Asset( "ANIM", "anim/blue_flag.zip" ),
	Asset( "ANIM", "anim/purple_flag.zip" ),
}

local function onequip(inst, owner)
	local slotid = inst.components.teamflags:GetEquipSlotID()
	if slotid == 0 then
		owner.AnimState:OverrideSymbol("swap_object", inst.animname, "swap_hands")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	elseif slotid == 1 then
		owner.AnimState:OverrideSymbol("swap_body", inst.animname, "swap_body")
	elseif slotid == 2 then
		if TUNING.BACKPACK_SLOT == 1 then
			owner.AnimState:OverrideSymbol("swap_body_tall", inst.animname, "swap_back")
		else
			owner.AnimState:OverrideSymbol("swap_body", inst.animname, "swap_back")
		end
	elseif slotid == 3 then
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		if TUNING.COMPASS_SLOT == 1 and owner.replica.inventory ~= nil then
			local equipment = owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if equipment == nil then
				owner.AnimState:ClearOverrideSymbol("swap_object")
			end
			owner.AnimState:OverrideSymbol("lantern_overlay", inst.animname, "swap_waist")
			owner.AnimState:Show("LANTERN_OVERLAY")
		else
			owner.AnimState:OverrideSymbol("swap_object", inst.animname, "swap_waist")
		end
	elseif slotid == 4 then
		owner.AnimState:OverrideSymbol("swap_body", inst.animname, "swap_neck")
	elseif slotid == 5 then
		owner.AnimState:OverrideSymbol("swap_hat", inst.animname, "swap_head")
		owner.AnimState:Show("HAT")
		owner.AnimState:Hide("HAIR_HAT")
		owner.AnimState:Show("HAIR_NOHAT")
		owner.AnimState:Show("HAIR")
		if owner:HasTag("player") then
			owner.AnimState:Show("HEAD")
			owner.AnimState:Hide("HEAD_HAT")
		end
	else
		owner.AnimState:OverrideSymbol("swap_object", inst.animname, "swap_hands")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
	end
	if owner.components.teamworker then
		owner.components.teamworker:SetIdentifier("teamflags", inst.color)
	end
	-- if owner:HasTag("player") then
		-- owner.teamcolor = inst.components.teamflags:GetColor()
		-- owner:AddTag("team_"..inst.color)
	-- end
	if TUNING.TEAMFLAGS_BEHAVIOR_ON_DEATH == "keep" or TUNING.TEAMFLAGS_BEHAVIOR_ON_DEATH == "disappear" then
		inst.components.inventoryitem.keepondeath = true
	end
end

local function onunequip(inst, owner)
	local slotid = inst.components.teamflags:GetEquipSlotID()
	if slotid == 0 then
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	elseif slotid == 1 then
		owner.AnimState:ClearOverrideSymbol("swap_body")
	elseif slotid == 2 then
		if TUNING.BACKPACK_SLOT == 1 then
			owner.AnimState:ClearOverrideSymbol("swap_body_tall")
		else
			owner.AnimState:ClearOverrideSymbol("swap_body")
		end
	elseif slotid == 3 then
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
		if TUNING.COMPASS_SLOT == 1 then
			owner.AnimState:ClearOverrideSymbol("lantern_overlay")
		else
			owner.AnimState:ClearOverrideSymbol("swap_object")
		end
	elseif slotid == 4 then
		owner.AnimState:ClearOverrideSymbol("swap_body")
	elseif slotid == 5 then
		owner.AnimState:ClearOverrideSymbol("swap_hat")
		owner.AnimState:Hide("HAT")
		owner.AnimState:Hide("HAIR_HAT")
		owner.AnimState:Show("HAIR_NOHAT")
		owner.AnimState:Show("HAIR")
		if owner:HasTag("player") then
			owner.AnimState:Show("HEAD")
			owner.AnimState:Hide("HEAD_HAT")
		end
	else
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
	end
	if owner.components.teamworker then
		owner.components.teamworker:SetIdentifier("teamflags")
	end

	-- if owner:HasTag("player") then
		-- owner.teamcolor = nil
		-- owner:RemoveTag("team_"..inst.color)
	-- end
	inst.components.inventoryitem.keepondeath = false
end

local function commonfn(clr, tag)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
	inst.color = clr
	inst.animname = clr.."_flag"
	inst.AnimState:SetBank(inst.animname)
	inst.AnimState:SetBuild(inst.animname)
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("teamflags")

	if tag ~= nil then
		inst:AddTag(tag)
	end

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = inst.animname
	inst.components.inventoryitem.atlasname = "images/inventoryimages/"..inst.animname..".xml"
		
	inst:AddComponent("teamflags")
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = inst.components.teamflags:GetEquipSlot()
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	
	local function changeslot(inst)
		inst.components.teamflags:ChangeEquipSlot()
		inst.components.useableitem.inuse = false
	end
	
	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(changeslot)

	local function onentitydeath(vinst, data)
		local owner = inst.components.inventoryitem:GetGrandOwner()
		if owner and owner == data.inst then--and inst.components.equippable:IsEquipped() 
			-- if owner:HasTag("player") then
			if owner.components.teamworker then
				owner.components.teamworker:SetIdentifier("teamflags")
				-- owner.teamcolor = nil
			end
			inst:Remove()
		end
	end
	
	if TUNING.TEAMFLAGS_BEHAVIOR_ON_DEATH == "disappear" then
		inst:ListenForEvent("entity_death", onentitydeath, TheWorld)
	end
	
	return inst
end

local function red()
	local inst = commonfn("red")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.RED)

	MakeHauntableLaunch(inst)

	return inst
end
local function orange()
	local inst = commonfn("orange")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.ORANGE)

	MakeHauntableLaunch(inst)

	return inst
end
local function yellow()
	local inst = commonfn("yellow")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.YELLOW)

	MakeHauntableLaunch(inst)

	return inst
end
local function green()
	local inst = commonfn("green")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.GREEN)

	MakeHauntableLaunch(inst)

	return inst
end
local function blue()
	local inst = commonfn("blue")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.BLUE)

	MakeHauntableLaunch(inst)

	return inst
end
local function purple()
	local inst = commonfn("purple")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.components.teamflags:SetColor(TEAMCOLORS.PURPLE)

	MakeHauntableLaunch(inst)

	return inst
end

return 
	Prefab("red_flag", red, assets),
	Prefab("orange_flag", orange, assets), 
	Prefab("yellow_flag", yellow, assets), 
	Prefab("green_flag", green, assets), 
	Prefab("blue_flag", blue, assets), 
	Prefab("purple_flag", purple, assets)
