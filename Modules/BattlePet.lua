local _, AlomawaniUI = ...
local BattlePet = AlomawaniUI:NewModule('BattlePet', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		battlepetname = 0,
        battleground = false,
        arena = false,
        stealth = false,
	}
}

function BattlePet:SummonBattlePet()
    local instanceType = select(2, IsInInstance())
    if InCombatLockdown('player') or (self.config.stealth and IsStealthed()) or (self.config.battleground and instanceType == 'pvp') or (self.config.arena and instanceType == 'arena') then
		return
	end

    local _, petGUID = C_PetJournal.FindPetIDByName(self.config.battlepetname)
    if petGUID and C_PetJournal.GetSummonedPetGUID() ~= petGUID then
        C_PetJournal.SummonPetByGUID(petGUID)
    end
end

function BattlePet:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('BattlePet', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function BattlePet:OnEnable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'SummonBattlePet')
    self:RegisterEvent('COMPANION_UPDATE', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_INDOORS', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'SummonBattlePet')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function BattlePet:ApplyConfig(config)
	if config then
		self.config = config
	end
end