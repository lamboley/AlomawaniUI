local _, AlomawaniUI = ...
local ProfileChooser = AlomawaniUI:NewModule('ProfileChooser', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

local function setProfileBartender(profile)
	for i = 1, C_AddOns.GetNumAddOns() do
		local addonName = C_AddOns.GetAddOnInfo(i)

		if C_AddOns.IsAddOnLoaded(i) then
			if (addonName == 'Bartender4') then
				local addon = _G[addonName]
				if type(addon) == 'table' and type(addon.db) == 'table' then
					if addon.db:GetCurrentProfile() ~= profile then
						addon.db:SetProfile(profile)
					end
				end
			end
		end
	end
end

function ProfileChooser:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('ProfileChooser', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function ProfileChooser:OnEnable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ProfileChooser:ApplyConfig(config)
	if config then
		self.config = config
	end
end

function ProfileChooser:PLAYER_ENTERING_WORLD()
	local currentSpec = GetSpecialization()
	if currentSpec then
		local roleToken = GetSpecializationRole(currentSpec)
		if roleToken and ( roleToken == 'HEALER' or roleToken == 'DPS' or roleToken == 'TANK') then
			setProfileBartender(roleToken)
		end
	end
end