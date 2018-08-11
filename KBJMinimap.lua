Minimap:ClearAllPoints()
Minimap:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -408, 8)
Minimap:SetSize(181, 181)

Minimap:SetBackdrop({
	bgFile =  "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
	insets = {left = -0, right = -0, top = -0, bottom = -0} 
})
Minimap:SetBackdropColor(0,0,0,1)
Minimap:SetBackdropBorderColor(0,0,0,1)
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- Minimap Buttons Check
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MinimapNorthTag:SetTexture(nil)
MinimapZoneTextButton:Hide()
MiniMapWorldMapButton:Hide()
GameTimeFrame:Hide()

-- Date/Time/Clock 
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
if not TimeManagerMilitaryTimeCheck:GetChecked() then TimeManagerMilitaryTimeCheck:Click() end -- force 24h format

local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont("Interface\\Addons\\KBJMinimap\\media\\square.ttf", 12, "THINOUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("CENTER", Minimap, "BOTTOM", 0, 9)
clockTime:Show()

local dateText = TimeManagerClockButton:CreateFontString(nil, 'BACKGROUND')
dateText:SetFont("Interface\\Addons\\KBJMinimap\\media\\square.ttf", 10, "THINOUTLINE")
dateText:SetTextColor(MinimapZoneText:GetTextColor())
dateText:SetPoint("TOP", clockTime, 0, 11)
dateText:SetText(date("%b %d, %a"))

-- Tracking
MiniMapTracking:SetAlpha(0)
MiniMapTracking:SetSize(16,16)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", Minimap, -6,-6)
MiniMapTrackingBackground:SetTexture(20/255,15/255,10/255,1)
MiniMapTrackingBackground:SetAlpha(1)
MiniMapTrackingBackground:SetAllPoints(MiniMapTracking)
MiniMapTrackingButton:SetBackdropBorderColor(0, 0, 0)
MiniMapTrackingButton:SetAllPoints(MiniMapTracking)
MiniMapTrackingButtonBorder:SetTexture("Interface\\AddOns\\KBJMinimap\\media\\button_overlay")
MiniMapTrackingButtonBorder:SetPoint("TOPLEFT", MiniMapTracking, "TOPLEFT", -5, 5)
MiniMapTrackingButtonBorder:SetPoint("BOTTOMRIGHT", MiniMapTracking, "BOTTOMRIGHT", 5, -5)
MiniMapTrackingIcon:ClearAllPoints()
MiniMapTrackingIcon:SetPoint("TOPLEFT", MiniMapTracking, "TOPLEFT", 1, -1)
MiniMapTrackingIcon:SetPoint("BOTTOMRIGHT", MiniMapTracking, "BOTTOMRIGHT", -1, 1)
MiniMapTrackingIcon:SetTexCoord(0.1,0.9,0.1,0.9)
MiniMapTrackingIcon.SetPoint = function() end

MiniMapTrackingIconOverlay:SetTexture(nil)

-- Mail
MiniMapMailFrame:SetSize(16,16)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, -35, 6)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailBorder:SetTexture("Interface\\AddOns\\KBJMinimap\\media\\button_overlay")
MiniMapMailBorder:SetPoint("TOPLEFT", MiniMapMailFrame, "TOPLEFT", -5, 5)
MiniMapMailBorder:SetPoint("BOTTOMRIGHT", MiniMapMailFrame, "BOTTOMRIGHT", 5, -5)
MiniMapMailIcon:ClearAllPoints()
MiniMapMailIcon:SetPoint("TOPLEFT", MiniMapMailFrame, "TOPLEFT", 1, -1)
MiniMapMailIcon:SetPoint("BOTTOMRIGHT", MiniMapMailFrame, "BOTTOMRIGHT", -1, 1)

-- DungeonFinder LFG LFR
QueueStatusMinimapButton:SetSize(16,16)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOPLEFT", Minimap, 6, -6)
QueueStatusMinimapButtonBorder:SetTexture("Interface\\AddOns\\KBJMinimap\\media\\button_overlay")
QueueStatusMinimapButtonBorder:SetPoint("TOPLEFT", QueueStatusMinimapButton, "TOPLEFT", -5, 5)
QueueStatusMinimapButtonBorder:SetPoint("BOTTOMRIGHT", QueueStatusMinimapButton, "BOTTOMRIGHT", 5, -5)

-- Instance Difficulty
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, 7, 6)
MiniMapInstanceDifficulty:SetScale(1)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, 3, 6)
GuildInstanceDifficulty:SetScale(1)
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint("TOPRIGHT", Minimap, 2, 2)
MiniMapChallengeMode:SetScale(1)

-- Garrison
GarrisonLandingPageMinimapButton:SetSize(38, 38)
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetParent(Minimap)
GarrisonLandingPageMinimapButton:SetPoint("BOTTOMRIGHT", Minimap, 3, -3)

-- Hide Button
local function OnLeave()
    if not Minimap:IsMouseOver() then
    	MiniMapTracking:SetAlpha(0)
    end
end
 
Minimap:HookScript('OnEnter', function() 
	MiniMapTracking:SetAlpha(1) 
	GarrisonLandingPageMinimapButton:SetAlpha(1)
	end)
Minimap:HookScript('OnLeave', OnLeave)
MiniMapTrackingButton:HookScript('OnLeave', OnLeave)
QueueStatusMinimapButton:HookScript('OnLeave', OnLeave)
MiniMapMailFrame:HookScript('OnLeave', OnLeave)
TimeManagerClockButton:HookScript('OnLeave', OnLeave)

-- Mouse Event in Minimap
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)
Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == ("RightButton") then
		GameTimeFrame:Click()
	else
		Minimap_OnClick(self)
	end
end)

-- Set BattlefieldMapFrame
local kbjFuncBattleMap = CreateFrame('Frame')
kbjFuncBattleMap:SetScript('OnEvent', function()
	if not BattlefieldMapFrame then
		LoadAddOn('Blizzard_BattlefieldMap')
	end
	
	local BFMF = CreateFrame('Frame', nil, BattlefieldMapFrame)
	BFMF:SetFrameStrata('LOW')
	BFMF:SetPoint('TOPLEFT', BattlefieldMapFrame, 'TOPLEFT', -1, 3)
    BFMF:SetPoint('BOTTOMRIGHT', BattlefieldMapFrame, 'BOTTOMRIGHT', -2, 2)
    BFMF:SetBackdrop({
        bgFile =  "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
        insets = {left = 1, right = 1, top = 1, bottom = 1} 
	})
    BFMF:SetBackdropColor(0, 0, 0, 1)
    BFMF:SetBackdropBorderColor(0, 0, 0, 1)

	BattlefieldMapFrame:SetScale(0.9)
	BattlefieldMapFrame:SetPoint('TOPLEFT', Minimap, 'TOPRIGHT', 5, -3)
	BattlefieldMapFrame.BorderFrame:Hide()
	BattlefieldMapFrame:Show()
end)
kbjFuncBattleMap:RegisterEvent('PLAYER_ENTERING_WORLD')

-- Move ObjectiveTracker
local anchor = "TOPRIGHT"
local xOff = -47
local yOff = -44
local otFrame = CreateFrame("Frame")

otFrame:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
		local objectiveTracker = ObjectiveTrackerFrame
		objectiveTracker:ClearAllPoints()
		objectiveTracker:SetPoint(anchor, UIParent, xOff, yOff)
		hooksecurefunc(objectiveTracker, "SetPoint", function(self, anchorPoint, relativeTo, x, y)
			if anchorPoint ~= anchor and x ~= xOff and y ~= yOff then
				self:SetPoint(anchor, UIParent, xOff, yOff)
			end
		end)
		self:UnregisterEvent("ADDON_LOADED")
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end)
otFrame:RegisterEvent("PLAYER_LOGIN")