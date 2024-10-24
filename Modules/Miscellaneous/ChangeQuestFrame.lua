local _, AlomawaniUI = ...
local ChangeQuestFrame = AlomawaniUI:NewModule('ChangeQuestFrame', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		scale = 0.85,
	}
}

function ChangeQuestFrame:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangeQuestFrame', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	ObjectiveTrackerFrame:SetScale(self.db.profile.scale)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeQuestFrame:PLAYER_ENTERING_WORLD()

	-- CompactRaidFrameManager:UnregisterAllEvents()
	-- CompactRaidFrameManager:HookScript("OnShow", function(s) s:Hide() end)
	-- CompactRaidFrameManager:Hide()

	MicroButtonAndBagsBar:UnregisterAllEvents()
	MicroButtonAndBagsBar:HookScript("OnShow", function(s) s:Hide() end)
	MicroButtonAndBagsBar:Hide()

	BagsBar:UnregisterAllEvents()
	BagsBar:HookScript("OnShow", function(s) s:Hide() end)
	BagsBar:Hide()

	local instanceType = select(2, IsInInstance())
	if not instanceType then return end

	if instanceType == 'pvp' or instanceType == 'arena' then
		ObjectiveTrackerFrame:Hide()
	elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
		ObjectiveTrackerFrame:Show()
		-- ObjectiveTrackerFrame:ToggleCollapsed()
		ObjectiveTrackerFrame:SetCollapsed(true)
	else
		ObjectiveTrackerFrame:Show()
		ObjectiveTrackerFrame:SetCollapsed(false)
	end




end

function ChangeQuestFrame:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeQuestFrame:ApplyConfig(config)
	if config then
		self.config = config
	end
end