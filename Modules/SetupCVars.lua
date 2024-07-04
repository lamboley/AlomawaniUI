local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local SetupCVars = AlomawaniUI:NewModule('SetupCVars', 'AceEvent-3.0')

local SetCVar = SetCVar

local db
local defaults = {
	profile = {
		accuracy = 1,
	}
}

function SetupCVars:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('SetupCVars', defaults)
	db = self.db.profile

	self:SetEnabledState(true)

	SetCVar('cameraDistanceMaxZoomFactor ', 2.6)
end

function SetupCVars:OnEnable()
	self:Refresh()
end

function SetupCVars:Refresh()
	db = self.db.profile
end