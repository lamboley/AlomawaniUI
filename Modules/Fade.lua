local _, AlomawaniUI = ...
local Fade = AlomawaniUI:NewModule('Fade', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
        menufade = true,
	}
}

function Fade:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('Fade', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function Fade:OnEnable()
	MicroMenu:SetAlpha(0)

	for _, frame in ipairs({MicroMenu:GetChildren()}) do
		frame:HookScript('OnEnter', function()
				MicroMenu:SetAlpha(1)
		end)

		frame:HookScript('OnLeave', function()
			if self.db.profile.menufade then
				MicroMenu:SetAlpha(0)
			end
		end)
	end

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Fade:ApplyConfig(config)
	if config then
		self.config = config
	end
end