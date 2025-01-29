local _, AlomawaniUI = ...
local MoutSummonEnhanced = AlomawaniUI:NewModule('MoutSummonEnhanced', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		groundmount = 482,
        flyingmount = 477,
        donotfly = {

        },
        forcegroundmountinbattleground = true,
        forcegroundmountinarena = true,
	}
}

function AlomawaniUI:Mount()
    if CanExitVehicle() then
        VehicleExit()
    elseif IsMounted() then
        Dismount()
    else
        if MoutSummonEnhanced.masterRiding then
            local instanceType = select(2, IsInInstance())
            if forcegroundmountinpvp and instanceType and instanceType == 'arena' then -- In Arena
                C_MountJournal.SummonByID(tonumber(MoutSummonEnhanced.db.profile.groundmount))
            elseif forcegroundmountinpvp and instanceType and instanceType == 'pvp' then -- In Battleground
                C_MountJournal.SummonByID(tonumber(MoutSummonEnhanced.db.profile.groundmount))
            elseif not IsFlyableArea() then -- Can't fly here
                C_MountJournal.SummonByID(tonumber(MoutSummonEnhanced.db.profile.groundmount))
            elseif MoutSummonEnhanced.db.profile.donotfly and MoutSummonEnhanced.db.profile.donotfly[tostring(self.GetZoneID())] then -- In zone blacklisted
                C_MountJournal.SummonByID(tonumber(MoutSummonEnhanced.db.profile.groundmount))
            else
                C_MountJournal.SummonByID(tonumber(MoutSummonEnhanced.db.profile.flyingmount))
            end
        else
            C_MountJournal.SummonByID(678) -- Chauffered Mechano-Hog
        end
    end
end

function MoutSummonEnhanced:UpdateMountSpell()
    self.masterRiding = IsSpellKnown(90265)
end

function MoutSummonEnhanced:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('MoutSummonEnhanced', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function MoutSummonEnhanced:OnEnable()
    self:RegisterEvent('LEARNED_SPELL_IN_TAB', 'UpdateMountSpell')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
    self:UpdateMountSpell()
end

function MoutSummonEnhanced:ApplyConfig(config)
	if config then
		self.config = config
	end
end