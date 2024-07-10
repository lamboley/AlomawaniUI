local _, AlomawaniUI = ...
local ChangeQuestFrame = AlomawaniUI:NewModule('ChangeQuestFrame', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ChangeQuestFrame:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangeQuestFrame', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	ObjectiveTrackerFrame:SetScale(0.85)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeQuestFrame:PLAYER_ENTERING_WORLD()
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

function ChangeQuestFrame:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ChangeQuestFrame:ApplyConfig(config)
	if config then
		self.config = config
	end
end