local _, AlomawaniUI = ...
local AutoDelete = AlomawaniUI:NewModule('AutoDelete', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function AutoDelete:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('AutoDelete', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('DELETE_ITEM_CONFIRM')
end

function AutoDelete:PLAYER_ENTERING_WORLD()
    self.link = StaticPopup1:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
    self.link:SetPoint('CENTER', StaticPopup1EditBox)
    self.link:Hide()

    StaticPopup1:HookScript('OnHide', function()
        AutoDelete.link:Hide()
    end)
end

function AutoDelete:DELETE_ITEM_CONFIRM()
	if StaticPopup1EditBox:IsShown() then
        StaticPopup1EditBox:Hide()
        StaticPopup1Button1:Enable()

        local link = select(3, GetCursorInfo())
        self.link:SetText(link)
        self.link:Show()
	end
end

function AutoDelete:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function AutoDelete:ApplyConfig(config)
	if config then
		self.config = config
	end
end