﻿local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	ShestakUI variables
----------------------------------------------------------------------------------------
T.dummy = function() return end
T.name = select(1, UnitName("player"))
T.class = select(2, UnitClass("player"))
T.level = UnitLevel("player")
T.client = GetLocale()
T.realm = GetRealmName()
T.color = RAID_CLASS_COLORS[T.class]
T.version = GetAddOnMetadata("ShestakUI", "Version")
T.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))

if T.name == "Черешок" or T.name == "Вершок" or T.name == "Вещмешок" or T.name == "Гребешок" or T.name == "Кулешок"
or T.name == "Лапушок" or T.name == "Обушок" or T.name == "Ремешок" or T.name == "Шестак" or T.name == "Торгашок"
or T.name == "Аазмантус" or T.name == "Дефляция" or T.name == "Shestak" then
	T.author = true
end