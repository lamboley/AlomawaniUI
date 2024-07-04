local AlomawaniUI = LibStub('AceAddon-3.0'):NewAddon('AlomawaniUI', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local db
local defaults = {
	profile = {
		-- modules = {
		-- 	['*'] = true,
		-- },
	}
}

function AlomawaniUI.Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'AlomawaniUI:|r ', ...))
end

function AlomawaniUI:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New('AlomawaniUIDB', defaults, true)
	db = self.db.profile

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
	db = self.db.profile

	for k,v in self:IterateModules() do
		if self:GetModuleEnabled(k) and not v:IsEnabled() then
			self:EnableModule(k)
		elseif not self:GetModuleEnabled(k) and v:IsEnabled() then
			self:DisableModule(k)
		end

		if v:IsEnabled() and type(v.Refresh) == 'function' then
			v:Refresh()
		end
	end
end