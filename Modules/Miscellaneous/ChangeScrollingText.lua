local _, AlomawaniUI = ...
local ChangeScrollingText = AlomawaniUI:NewModule('ChangeScrollingText', 'AceEvent-3.0', 'AceHook-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ChangeScrollingText:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangeScrollingText', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeScrollingText:PLAYER_ENTERING_WORLD()
	local instanceType = select(2, IsInInstance())
	if not instanceType then return end

	if instanceType == 'party' or instanceType == 'raid' then
        SetCVar('floatingCombatTextCombatHealing', 0)
        SetCVar('floatingCombatTextCombatDamage', 0)
        SetCVar('floatingCombatTextPetMeleeDamage', 0)
        SetCVar('floatingCombatTextPetSpellDamage', 0)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
    else
        SetCVar('floatingCombatTextCombatHealing', 0)
        SetCVar('floatingCombatTextCombatDamage', 1)
        SetCVar('floatingCombatTextPetMeleeDamage', 0)
        SetCVar('floatingCombatTextPetSpellDamage', 0)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
    end
end

function ChangeScrollingText:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)


end

function ChangeScrollingText:ApplyConfig(config)
	if config then
		self.config = config
	end
end