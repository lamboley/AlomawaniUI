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
	CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0.2

	for i = 1, #CHAT_FRAMES do
		local chatFrame = _G["ChatFrame" .. i]
		chatFrame:SetClampedToScreen(false)
		chatFrame:SetClampRectInsets(0, 0, 0, 0)
		chatFrame:SetScale(1.1)

		local chatFrameXTab = _G['ChatFrame' .. i .. 'Tab']
		chatFrameXTab:SetScale(1.1)

		local frame = _G['ChatFrame' .. i .. 'EditBox']
		frame:ClearAllPoints()
		frame:SetPoint('BOTTOMLEFT', frame.chatFrame, 'TOPLEFT', 0, 3)
		frame:SetPoint('BOTTOMRIGHT', frame.chatFrame, 'TOPRIGHT', frame.chatFrame.ScrollBar:GetWidth(), 3)
		frame:SetScale(1.1)
	end

	QuickJoinToastButton:SetScale(1.1)
end

function ChangeChat:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

	local prevClamp = ChatFrame1.SetClampRectInsets
	self:SecureHook(ChatFrame1, 'SetClampRectInsets', function(frame, ...)
		prevClamp(frame, 0, 0, 0, 0)
	end)

	self:SecureHook('FCF_DockFrame')
	self:SecureHook('FCF_UnDockFrame')
	self:SecureHook('FloatingChatFrame_UpdateBackgroundAnchors')
end

function ChangeChat:ApplyConfig(config)
	if config then
		self.config = config
	end
end

function ChangeChat:FloatingChatFrame_UpdateBackgroundAnchors(frame)
	frame:SetClampedToScreen(false)
	frame:SetClampRectInsets(0, 0, 0, 0)
end

function ChangeChat:FCF_DockFrame(frame, ...)
	frame:SetClampedToScreen(false)
	frame:SetClampRectInsets(0, 0, 0, 0)
end

function ChangeChat:FCF_UnDockFrame(frame, ...)
	frame:SetClampedToScreen(false)
	frame:SetClampRectInsets(0, 0, 0, 0)
end