local _, AlomawaniUI = ...
local ChangePortrait = AlomawaniUI:NewModule('ChangePortrait', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ChangePortrait:UpdatePortrait()
    local currentSpec = GetSpecialization()
	if currentSpec then
		local roleToken = GetSpecializationRole(currentSpec)
		if roleToken and roleToken == 'HEALER' then
            RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'hide;hide')
        else
			RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
		end
	end
end

function ChangePortrait:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangePortrait', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD', 'UpdatePortrait')
    self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED', 'UpdatePortrait')
end

function ChangePortrait:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ChangePortrait:ApplyConfig(config)
	if config then
		self.config = config
	end
end