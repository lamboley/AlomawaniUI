local _, AlomawaniUI = ...
local Alerts = AlomawaniUI:NewModule('Alerts', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
        foodmage = true,
        cookie = true,
	}
}

function Alerts:COMBAT_LOG_EVENT_UNFILTERED()
	local _, subEvent, _, _, sourceName, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
	if subEvent == 'SPELL_CAST_SUCCESS' then
        if sourceName and sourceName == UnitName('Player') then
            if self.db.profile.foodmage and spellID == 190336 then
                SendChatMessage('I just created a table (' .. GetSpellLink(spellID) .. ').')
            elseif self.db.profile.cookie and spellID == 29893 then
                SendChatMessage('I just created cookie (' .. GetItemLink(5512) .. ').')
            end
        end
    end
end

function Alerts:GROUP_JOINED()
    if IsInGroup() then
        self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    else
        self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    end
end

function Alerts:GROUP_LEFT()
    if IsInGroup() then
        self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    else
        self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    end
end

function Alerts:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('Alerts', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function Alerts:OnEnable()
    self:RegisterEvent('GROUP_JOINED')
	self:RegisterEvent('GROUP_LEFT')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Alerts:ApplyConfig(config)
	if config then
		self.config = config
	end
end