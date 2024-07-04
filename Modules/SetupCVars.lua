local _, AlomawaniUI = ...
local SetupCVars = AlomawaniUI:NewModule('SetupCVars', 'AceEvent-3.0')

local SetCVar = SetCVar

local defaults = {
	profile = {
		accuracy = 1,
	}
}

function SetupCVars:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('SetupCVars', defaults)
	self:SetEnabledState(true)

	SetCVar('cameraDistanceMaxZoomFactor ', 2.6)
end

function SetupCVars:OnEnable()
	self:Refresh()
end

function SetupCVars:Refresh()
end