local AlomawaniUI = LibStub('AceAddon-3.0'):NewAddon('AlomawaniUI', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local defaults = {
	profile = {
		modules = {
			['*'] = true,
		},
	}
}

local db

function AlomawaniUI:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New('AlomawaniUIDB', defaults, true)

	db = self.db.profile

	self.db.RegisterCallback(self, 'OnProfileChanged', 'Refresh')
	self.db.RegisterCallback(self, 'OnProfileCopied', 'Refresh')
	self.db.RegisterCallback(self, 'OnProfileReset', 'Refresh')

	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(AlomawaniUI.db, "AlomawaniUI")
	end

	self:SetupOptions()
end

function AlomawaniUI:OnEnable()
end

function AlomawaniUI:Refresh()
	db = self.db.profile

	for k,v in self:IterateModules() do
		if type(v.Refresh) == 'function' then
			v:Refresh()
		end
	end
end