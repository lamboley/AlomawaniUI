local _, AlomawaniUI = ...
local ChangeTooltip = AlomawaniUI:NewModule('ChangeTooltip', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ChangeTooltip:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangeTooltip', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeTooltip:PLAYER_ENTERING_WORLD()
	if self.db.profile.enabled then
		hooksecurefunc(GameTooltip, 'Show', function(self)
			if UnitAffectingCombat('player') then
				self:Hide()
			end
		end)
	end
end

function ChangeTooltip:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ChangeTooltip:ApplyConfig(config)
	if config then
		self.config = config
	end
end