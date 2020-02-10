name = "Team Flags"
version = "2.0.0.1"
description = [[
队旗(Team Flags) 2.0

※MOD制作初心者
※大量API修改, 兼容性注意
※依赖MOD: 团队合作API(Teamworker API, ), 请务必开启
推荐使用的的五格装备MOD版本: https://steamcommunity.com/sharedfiles/filedetails/?id=1405120786
可以通过装备各色旗帜在多人服务器中辨识阵营。
主要功能(部分可在MOD设置中更改):
·PVP开启时普通攻击不会伤到队友
·旗帜可以设定为可合成或不可合成(由管理员分发)
·旗帜可以设定为死亡不掉落或者死亡消失
·右键装备中的旗帜切换固定在身体上的位置: 手部/身体/背部/手臂/颈部/头部, 兼容五格装备栏MOD
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
