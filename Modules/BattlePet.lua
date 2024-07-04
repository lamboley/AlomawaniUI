local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local BattlePet = AlomawaniUI:NewModule('BattlePet', 'AceEvent-3.0')

local db
local defaults = {
	profile = {
		battlepetname = 0,
	}
}

function BattlePet:SummonBattlePet()
    local instanceType = select(2, IsInInstance())
    if InCombatLockdown('player') or IsStealthed() or instanceType == 'pvp' or instanceType == 'arena' then return end

    if C_PetJournal.GetSummonedPetGUID() ~= db.battlepetname then
        C_PetJournal.SummonPetByGUID(db.battlepetname)
    end
end

function BattlePet:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('BattlePet', defaults)
	db = self.db.profile

	self:SetEnabledState(true)

	self:SetupOptions()
end

function BattlePet:OnEnable()
	self:Refresh()

    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'SummonBattlePet')
    self:RegisterEvent('COMPANION_UPDATE', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_INDOORS', 'SummonBattlePet')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'SummonBattlePet')
end

function BattlePet:Refresh()
	db = self.db.profile
end