local _, AlomawaniUI = ...
AlomawaniUI = LibStub('AceAddon-3.0'):NewAddon('AlomawaniUI', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
_G.AlomawaniUI = AlomawaniUI

local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local defaults = {
	profile = {
	}
}

function AlomawaniUI.Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'AlomawaniUI:|r ', ...))
end

function AlomawaniUI:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New('AlomawaniUIDB', defaults, true)

	self.db.RegisterCallback(self, 'OnProfileChanged', 'Refresh')
	self.db.RegisterCallback(self, 'OnProfileCopied', 'Refresh')
	self.db.RegisterCallback(self, 'OnProfileReset', 'Refresh')

	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(AlomawaniUI.db, 'AlomawaniUI')
	end

	self:SetupOptions()
	self:LoadCommands()
	self:LoadMedia()
end

function AlomawaniUI:OnEnable()
end

function AlomawaniUI:Refresh()
	for k,v in self:IterateModules() do
		v:ToggleModule()
		if v:IsEnabled() and type(v.Refresh) == 'function' then
			v:Refresh()
		end
	end
end