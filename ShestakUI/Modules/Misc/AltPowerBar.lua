local T, C, L = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Old code for alt power bar
----------------------------------------------------------------------------------------
--[[PlayerPowerBarAlt:ClearAllPoints()
PlayerPowerBarAlt:Point("TOP", UIParent, "TOP", 0, -32)
PlayerPowerBarAlt.ClearAllPoints = T.dummy
PlayerPowerBarAlt.SetPoint = T.dummy

TargetFramePowerBarAlt:ClearAllPoints()
TargetFramePowerBarAlt:Point("TOP", UIParent, "TOP", 0, -52)
TargetFramePowerBarAlt.ClearAllPoints = T.dummy
TargetFramePowerBarAlt.SetPoint = T.dummy]]

----------------------------------------------------------------------------------------
--	New code for alt power bar
----------------------------------------------------------------------------------------
-- Get rid of old Alt Power Bar
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
-- Create the new bar
local AltPowerBar = CreateFrame("Frame", "UIAltPowerBar", UIParent)
AltPowerBar:SetWidth(200)
AltPowerBar:SetHeight(30)
AltPowerBar:Point("TOP", UIParent, "TOP", 0, -32)
AltPowerBar:EnableMouse(true)
AltPowerBar:SetTemplate("Default")

-- Create Status Bar and Text
local AltPowerBarStatus = CreateFrame("StatusBar", "UIAltPowerBarStatus", AltPowerBar)
AltPowerBarStatus:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBarStatus:SetStatusBarTexture(C.media.texture)
AltPowerBarStatus:SetMinMaxValues(0, 100)
AltPowerBarStatus:Point("TOPLEFT", AltPowerBar, "TOPLEFT", 2, -2)
AltPowerBarStatus:Point("BOTTOMRIGHT", AltPowerBar, "BOTTOMRIGHT", -2, 2)
AltPowerBarStatus:SetStatusBarColor(0.3, 0.7, 0.3)

AltPowerBarStatus.bg = AltPowerBarStatus:CreateTexture(nil, "BACKGROUND")
AltPowerBarStatus.bg:SetAllPoints(AltPowerBarStatus)
AltPowerBarStatus.bg:SetTexture(C.media.texture)
AltPowerBarStatus.bg:SetVertexColor(0.3, 0.7, 0.3, 0.25)

local AltPowerText = AltPowerBarStatus:CreateFontString(nil, "OVERLAY")
AltPowerText:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
AltPowerText:Point("CENTER", AltPowerBar, "CENTER", 0, 0)

-- Event handling
AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
AltPowerBar:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if UnitAlternatePowerInfo("player") then
		self:Show()
	else
		self:Hide()
	end
end)

-- Update Functions
local TimeSinceLastUpdate = 1
AltPowerBarStatus:SetScript("OnUpdate", function(self, elapsed)
	if not AltPowerBar:IsShown() then return end
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		local power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		self:SetValue(power)
		AltPowerText:SetText(power.."/"..mpower)
		self.TimeSinceLastUpdate = 0
	end
end)