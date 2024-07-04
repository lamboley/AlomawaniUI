local _, AlomawaniUI = ...
local Miscellaneous = AlomawaniUI:NewModule('Miscellaneous', 'AceEvent-3.0')

function Miscellaneous:OnInitialize()
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