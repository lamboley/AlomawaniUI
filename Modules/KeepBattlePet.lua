local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local KeepBattlePet = AlomawaniUI:NewModule('KeepBattlePet', 'AceEvent-3.0')

local db
local defaults = {
	profile = {
		accuracy = 1,
	}
}

function KeepBattlePet:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('KeepBattlePet', defaults)
	db = self.db.profile

	self:SetEnabledState(true)

	self:SetupOptions()
end

function KeepBattlePet:OnEnable()
	self:Refresh()
end

function KeepBattlePet:Refresh()
	db = self.db.profile
end