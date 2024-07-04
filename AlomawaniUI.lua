local _G = _G
local type= type

local AceAddon, AceAddonMinor = _G.LibStub('AceAddon-3.0')

local addonName, AlomawaniUI = ...
AlomawaniUI = AceAddon:NewAddon(AlomawaniUI, 'AlomawaniUI', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
_G[addonName] = AlomawaniUI

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
	SetCVar('cameraDistanceMaxZoomFactor ', 2.6)
end

function AlomawaniUI:Refresh()
	for k,v in self:IterateModules() do
		v:ToggleModule()
		if v:IsEnabled() and type(v.Refresh) == 'function' then
			v:Refresh()
		end
	end
end

AlomawaniUI.modulePrototype = {}
function AlomawaniUI.modulePrototype:ToggleModule(info, value)
	if value ~= nil then
		self.db.profile.enabled = value
	else
		value = self.db.profile.enabled
	end
	if value and not self:IsEnabled() then
		self:Enable()
	elseif not value and self:IsEnabled() then
		self:Disable()
	end
end

function AlomawaniUI.modulePrototype:ToggleOptions()
	if self.options then
		self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
	end
end

function AlomawaniUI.modulePrototype:OnDisable()
    self:ToggleOptions()
end

AlomawaniUI:SetDefaultModulePrototype(AlomawaniUI.modulePrototype)
