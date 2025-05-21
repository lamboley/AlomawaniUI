local _, AlomawaniUI = ...
local Mouselook = AlomawaniUI:NewModule('Mouselook', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

local lastRightClick = 0

local function DisableRightClick()
    local time = GetTime()
    if lastRightClick + 0.2 < time then
        lastRightClick = time
        MouselookStop()
    end
end

function Mouselook:PLAYER_ENTERING_WORLD()
    WorldFrame:HookScript('OnMouseUp', function(_, button)
        if button == "RightButton" and not IsMouseButtonDown('RightButton') then
            if InCombatLockdown() then
                DisableRightClick()
            end
        end
    end)
end

function Mouselook:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('Mouselook', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Mouselook:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Mouselook:ApplyConfig(config)
	if config then
		self.config = config
	end
end