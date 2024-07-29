local _, AlomawaniUI = ...
local ChangeChat = AlomawaniUI:NewModule('ChangeChat', 'AceEvent-3.0', 'AceHook-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ChangeChat:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ChangeChat', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ChangeChat:PLAYER_ENTERING_WORLD()
	DEFAULT_CHATFRAME_ALPHA = 0

	local prevClamp = ChatFrame1.SetClampRectInsets
	self:SecureHook(ChatFrame1, 'SetClampRectInsets', function(frame, ...)
		prevClamp(frame, 0, 0, 0, 0)
	end)
end

function ChangeChat:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ChangeChat:ApplyConfig(config)
	if config then
		self.config = config
	end
end