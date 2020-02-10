--================================================================
--	服务器端用法: 
--		<PLAYER>.teamcolor	----直接获取玩家的属性, 服务端限定
--	客户端用法: 
--		local TEAMCOLORS = GLOBAL.TEAMCOLORS	----local化TEAMCOLORS, 或其他在GLOBAL中加入TEAMCOLORS的方法, 如某些一键GLOBAL函数
--		
--		local function getteam(inst)	----客户端专用检测函数, 返回TEAMCOLORS常量的值
--			return inst:HasTag("team_red") and TEAMCOLORS.RED or 
--				inst:HasTag("team_orange") and TEAMCOLORS.ORANGE or 
--				inst:HasTag("team_yellow") and TEAMCOLORS.YELLOW or 
--				inst:HasTag("team_green") and TEAMCOLORS.GREEN or 
--				inst:HasTag("team_blue") and TEAMCOLORS.BLUE or 
--				inst:HasTag("team_purple") and TEAMCOLORS.PURPLE or nil
--		end
--================================================================

GLOBAL.TEAMCOLORS =
{
	RED 			= "RED",
	ORANGE 			= "ORANGE",
	YELLOW 			= "YELLOW",
	GREEN 			= "GREEN",
	BLUE 			= "BLUE",
	PURPLE 			= "PURPLE",
}
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local TheNet = GLOBAL.TheNet
local TEAMCOLORS = GLOBAL.TEAMCOLORS

TUNING.TEAMFLAGS_HAS_RECIPES = GetModConfigData("recipes")
TUNING.TEAMFLAGS_FRIENDLY_FIRE = GetModConfigData("friendly_fire")
TUNING.TEAMFLAGS_BEHAVIOR_ON_DEATH = GetModConfigData("behavior_on_death")

PrefabFiles = {
	"flags",
}
-- Assets = {
	-- Asset( "IMAGE", "images/inventoryimages/red_flag.tex" ),
	-- Asset( "ATLAS", "images/inventoryimages/red_flag.xml" ),
	
	-- Asset( "ANIM", "anim/red_flag.zip" ),
	
-- }


if TUNING.TEAMFLAGS_HAS_RECIPES then
	local red_flag = AddRecipe("red_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/red_flag.xml", "red_flag.tex")
	
	local orange_flag = AddRecipe("orange_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/orange_flag.xml", "orange_flag.tex")
	
	local yellow_flag = AddRecipe("yellow_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/yellow_flag.xml", "yellow_flag.tex")
	
	local green_flag = AddRecipe("green_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/green_flag.xml", "green_flag.tex")
	
	local blue_flag = AddRecipe("blue_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/blue_flag.xml", "blue_flag.tex")
	
	local purple_flag = AddRecipe("purple_flag",
	{Ingredient("silk", 2), Ingredient("petals", 2), Ingredient("twigs", 1)}, 
	RECIPETABS.WAR, TECH.NONE,
	nil, nil, nil, nil, nil,
	"images/inventoryimages/purple_flag.xml", "purple_flag.tex")
	
end
STRINGS.NAMES.RED_FLAG = "红色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.RED_FLAG = "热情似火的颜色。"
STRINGS.RECIPE_DESC.RED_FLAG = "将你标记为红队"

STRINGS.NAMES.ORANGE_FLAG = "橙色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ORANGE_FLAG = "温暖活泼的颜色。"
STRINGS.RECIPE_DESC.ORANGE_FLAG = "将你标记为橙队"

STRINGS.NAMES.YELLOW_FLAG = "黄色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.YELLOW_FLAG = "阳光自信的颜色。"
STRINGS.RECIPE_DESC.YELLOW_FLAG = "将你标记为黄队"

STRINGS.NAMES.GREEN_FLAG = "绿色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GREEN_FLAG = "热爱和平的颜色。"
STRINGS.RECIPE_DESC.GREEN_FLAG = "将你标记为绿队"

STRINGS.NAMES.BLUE_FLAG = "蓝色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BLUE_FLAG = "冷静沉稳的颜色。"
STRINGS.RECIPE_DESC.BLUE_FLAG = "将你标记为蓝队"

STRINGS.NAMES.PURPLE_FLAG = "紫色旗帜"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PURPLE_FLAG = "神秘优雅的颜色。"
STRINGS.RECIPE_DESC.PURPLE_FLAG = "将你标记为紫队"

AddComponentPostInit("inventory", function(self)
	local pEquip = self.Equip
	self.Equip = function(self, item, old_to_active)
		local vitem
		local owner = item and item.components.inventoryitem and item.components.inventoryitem:GetGrandOwner()
		if item and item:HasTag("teamflags") and self.inst.teamcolor ~= nil and self.inst:HasTag("player") then
			self:RemoveItem(item)
			for k, v in pairs(self.equipslots) do
				if v:HasTag("teamflags") then
					self:Unequip(k)
					if old_to_active then
						self:GiveActiveItem(v)
					else
						self.silentfull = true
						self:GiveItem(v)
						self.silentfull = false
					end
				end
			end
		end
		return pEquip(self, item, old_to_active)
	end
end)

local function getteam(inst)
	return inst:HasTag("team_red") and TEAMCOLORS.RED or 
		inst:HasTag("team_orange") and TEAMCOLORS.ORANGE or 
		inst:HasTag("team_yellow") and TEAMCOLORS.YELLOW or 
		inst:HasTag("team_green") and TEAMCOLORS.GREEN or 
		inst:HasTag("team_blue") and TEAMCOLORS.BLUE or 
		inst:HasTag("team_purple") and TEAMCOLORS.PURPLE or nil
end

local function nCombatR(self)
	self.IsValidTarget = function(self, target)
		if target == nil or
			target == self.inst or
			not (target.entity:IsValid() and target.entity:IsVisible()) then
			return false
		end
		local weapon = self:GetWeapon(self)
		return self:CanExtinguishTarget(target, weapon)
			or self:CanLightTarget(target, weapon)
			or (target.replica.combat ~= nil and
				target.replica.health ~= nil and
				not target.replica.health:IsDead() and
				not (target:HasTag("shadow") and self.inst.replica.sanity == nil) and
				not (target:HasTag("playerghost") and (self.inst.replica.sanity == nil or self.inst.replica.sanity:IsSane())) and
				-- gjans: Some specific logic so the birchnutter doesn't attack it's spawn with it's AOE
				-- This could possibly be made more generic so that "things" don't attack other things in their "group" or something
				(not self.inst:HasTag("birchnutroot") or not (target:HasTag("birchnutroot") or target:HasTag("birchnut") or target:HasTag("birchnutdrake"))) and 
				(TheNet:GetPVPEnabled() and (TUNING.TEAMFLAGS_FRIENDLY_FIRE or getteam(self.inst) == nil or getteam(target) ~= getteam(self.inst)) or not (self.inst:HasTag("player") and target:HasTag("player"))) and
				target:GetPosition().y <= self._attackrange:value())
	end
	
	self.IsAlly = function(self, guy)
		if guy == self.inst or
			(self.inst.replica.follower ~= nil and guy == self.inst.replica.follower:GetLeader()) then
			--It's me! or it's my leader
			return true
		end
		local follower = guy.replica.follower
		local leader = follower ~= nil and follower:GetLeader() or nil
		--It's my follower
		--or I'm a player and it's a companion (or following another player in non PVP)
		--unless it's attacking me
		return self.inst == leader or 
			(self.inst:HasTag("player") and ((guy:HasTag("companion") or getteam(guy) ~= nil and getteam(guy) == getteam(self.inst)) or 
			(leader ~= nil and not (TheNet:GetPVPEnabled()) and leader:HasTag("player"))) and (guy.replica.combat == nil or guy.replica.combat:GetTarget() ~= self.inst))
	end
	
	self.CanBeAttacked = function(self, attacker)
		if self.inst:HasTag("playerghost") or
			self.inst:HasTag("noattack") or
			self.inst:HasTag("flight") or
			self.inst:HasTag("invisible") then
			--Can't be attacked by anyone
			return false
		elseif attacker ~= nil then
			--Attacker checks
			if self.inst:HasTag("birchnutdrake")
				and (attacker:HasTag("birchnutdrake") or
					attacker:HasTag("birchnutroot") or
					attacker:HasTag("birchnut")) then
				--Birchnut check
				return false
			elseif attacker ~= self.inst and self.inst:HasTag("player") then
				--Player target check
				if (not TheNet:GetPVPEnabled() and attacker:HasTag("player")) or (getteam(self.inst) ~= nil and getteam(attacker) == getteam(self.inst)) then
					--PVP check
					return false
				elseif self._target:value() ~= attacker then
					local follower = attacker.replica.follower
					if follower ~= nil then
						local leader = follower:GetLeader()
						if leader ~= nil and
							leader ~= self._target:value() and
							leader:HasTag("player") then
							local combat = attacker.replica.combat
							if combat ~= nil and combat:GetTarget() ~= self.inst then
								--Follower check
								return false
							end
						end
					end
				end
			end
			local sanity = attacker.replica.sanity
			if sanity ~= nil and sanity:IsCrazy() then
				--Insane attacker can pretty much attack anything
				return true
			end
		end
		if self.inst:HasTag("shadowcreature") and
			self._target:value() == nil and
			--Allow AOE damage on stationary shadows like Unseen Hands
			(attacker ~= nil or self.inst:HasTag("locomotor")) then
			--Not insane attacker cannot attack shadow creatures
			--(unless shadow creature has a target)
			return false
		end
		--Passed all checks, can be attacked by anyone
		return true
	end
end
AddClassPostConstruct("components/combat_replica", nCombatR)