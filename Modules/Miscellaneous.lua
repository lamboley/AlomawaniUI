local _, AlomawaniUI = ...
local Miscellaneous = AlomawaniUI:NewModule('Miscellaneous', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function Miscellaneous:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('Miscellaneous', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	ObjectiveTrackerFrame:SetScale(0.85)
end

function Miscellaneous:OnEnable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Miscellaneous:PLAYER_ENTERING_WORLD()
	local instanceType = select(2, IsInInstance())
	if not instanceType then return end

	if instanceType == 'pvp' or instanceType == 'arena' then
		ObjectiveTrackerFrame:Hide()
	elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
		ObjectiveTrackerFrame:Show()
		ObjectiveTracker_Collapse()
	else
		ObjectiveTrackerFrame:Show()
		ObjectiveTracker_Expand()
	end
end

function Miscellaneous:OnEnable()
	self:ApplyConfig(self.db.profile)
end

function Miscellaneous:ApplyConfig(config)
	if config then
		self.config = config
	end
end