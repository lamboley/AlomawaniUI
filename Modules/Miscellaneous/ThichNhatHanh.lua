---@diagnostic disable: undefined-field
local _, AlomawaniUI = ...
local ThichNhatHanh = AlomawaniUI:NewModule('ThichNhatHanh', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
	}
}

function ThichNhatHanh:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('ThichNhatHanh', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function ThichNhatHanh:PLAYER_ENTERING_WORLD()
	if self.db.profile.enabled then
        C_Timer.NewTicker(500, function()
            _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I know I am breathing in.|r")
            _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I know I am breathing out.|r")

            C_Timer.After(60, function()
                _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00As my in-breath grows deep,|r")
                _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00My out-breath grows slow.|r")

                C_Timer.After(60, function()
                    _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I am aware of my body.|r")
                    _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I calm my body.|r")

                    C_Timer.After(60, function()
                        _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Dwelling in the present moment,|r")
                        _G.DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00I know this is a wonderful moment.|r")
                    end)
                end)
            end)
        end)
	end
end

function ThichNhatHanh:OnEnable()
    -- self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function ThichNhatHanh:ApplyConfig(config)
	if config then
		self.config = config
	end
end