local _, AlomawaniUI = ...
local BattlePet = AlomawaniUI:NewModule('BattlePet', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		battlepetname = 0,
	}
}

function BattlePet:SummonBattlePet()
    local instanceType = select(2, IsInInstance())
    if InCombatLockdown('player') or IsStealthed() or instanceType == 'pvp' or instanceType == 'arena' then
		return
	end

    if C_PetJournal.GetSummonedPetGUID() ~= self.db.profile.battlepetname then
        C_PetJournal.SummonPetByGUID(self.db.profile.battlepetname)
    end
end

function BattlePet:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('BattlePet', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function BattlePet:OnEnable()
	self:Refresh()

    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'SummonBattlePet')
    self:RegisterEvent('COMPANION_UPDATE', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_INDOORS', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'SummonBattlePet')

    self:ToggleOptions()
end

function BattlePet:ToggleOptions()
	if self.options then
		self.options.args = self:IsEnabled() and self.battlepetoptions or self.disabledoptions
	end
end

function BattlePet:OnDisable()
    self:ToggleOptions()
end

function BattlePet:Refresh()
end

function BattlePet:ToggleModule(info, value)
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