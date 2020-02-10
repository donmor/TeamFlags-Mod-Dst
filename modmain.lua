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
local TEAMCOLORS = GLOBAL.TEAMCOLORS

TUNING.TEAMFLAGS_HAS_RECIPES = GetModConfigData("recipes")
TUNING.TEAMFLAGS_BEHAVIOR_ON_DEATH = GetModConfigData("behavior_on_death")

PrefabFiles = {
	"flags",
}

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
		if item and item:HasTag("teamflags") and self.inst.components.teamworker and self.inst.components.teamworker:GetIdentifier("teamflags") ~= nil and self.inst:HasTag("player") then
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