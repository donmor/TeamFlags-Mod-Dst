name = "Team Flags"
version = "1.0.1.4"
description = [[
队旗(Team Flags) 1.0

※MOD制作初心者
※大量API修改, 兼容性注意
推荐使用的的五格装备MOD版本: https://steamcommunity.com/sharedfiles/filedetails/?id=1405120786
可以通过装备各色旗帜在多人服务器中辨识阵营。
主要功能(大部分可在MOD设置中更改):
·PVP开启时普通攻击不会伤到队友
·旗帜设计为可为部分MOD的技能提供敌我识别功能
·旗帜可以设定为可合成或不可合成(由管理员分发)
·旗帜可以设定为死亡不掉落或者死亡消失
·右键装备中的旗帜切换固定在身体上的位置: 手部/身体/背部/手臂/颈部/头部, 兼容五格装备栏MOD
在modmain.lua中包含了在其他MOD中的用法。
]]
author = "donmor"
forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true 
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {
	"item", "utility",
}
configuration_options =
{
	{
		name = "recipes",
		label = "玩家可制作旗帜",
		hover = "Craftable flags [○ Enabled/× Disabled]",
		options =
		{
			{description = "○ 开启", data = true, hover = "玩家自己制作旗帜"},
			{description = "× 关闭", data = false, hover = "由管理员分发旗帜"},
		},
		default = true,
	},
	
	{
		name = "friendly_fire",
		label = "队友伤害",
		hover = "Friendly fire [○ Enabled/× Disabled]",
		options =
		{
			{description = "○ 开启", data = true, hover = "玩家可以攻击队友"},
			{description = "× 关闭", data = false, hover = "玩家无法攻击队友"},
		},
		default = false,
	},
	
	{
		name = "behavior_on_death",
		label = "旗帜死亡掉落行为",
		hover = "Flags [- Behaves normally/○ Kept in inventory/× Disappear] on death",
		options =
		{
			{description = "- 无", data = "none", hover = "旗帜死亡掉落"},
			{description = "○ 死亡不掉落", data = "keep", hover = "旗帜死亡不掉落"},
			{description = "× 死亡消失", data = "disappear", hover = "旗帜死亡消失"},
		},
		default = "none",
	}
}
