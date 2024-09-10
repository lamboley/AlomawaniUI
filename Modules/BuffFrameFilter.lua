local _, AlomawaniUI = ...
local BuffFrameFilter = AlomawaniUI:NewModule('BuffFrameFilter', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		defaultstate = 'COLLAPSE',
		battlegroundcollapse = true,
	}
}

function BuffFrameFilter:PLAYER_ENTERING_WORLD()
	local instanceType = select(2, IsInInstance())
	if (self.db.profile.battlegroundcollapse and instanceType == 'pvp') or self.db.profile.defaultstate == 'COLLAPSE' then
		BuffFrame.CollapseAndExpandButton:SetChecked(false)
		BuffFrame:SetBuffsExpandedState(BuffFrame.CollapseAndExpandButton:GetChecked())
		BuffFrame.CollapseAndExpandButton:UpdateOrientation()
	end
end

function BuffFrameFilter:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('BuffFrameFilter', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function BuffFrameFilter:OnEnable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function BuffFrameFilter:ApplyConfig(config)
	if config then
		self.config = config
	end
end