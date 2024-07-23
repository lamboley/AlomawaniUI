local _, AlomawaniUI = ...
local AutoDepositGuildBank = AlomawaniUI:NewModule('AutoDepositGuildBank', 'AceEvent-3.0')

local smatch = string.match
local ssub = string.sub
local slen = string.len

local defaults = {
	profile = {
        enabled = true,
        amounttokeep = 100,
        checkguildbank = false,
        guildname = 0,
	}
}

function AutoDepositGuildBank:PLAYER_INTERACTION_MANAGER_FRAME_SHOW(event, type)
    local amountToKeep = tonumber(self.db.profile.amounttokeep)*10000

    if amountToKeep < 0 then return end
    if self.db.profile.checkguildbank and self.db.profile.guildname ~= select(1, GetGuildInfo('player')) then
        AlomawaniUI.Print('Guild Name not matching. Transferts canceled.')
        return
    end

    if event == 'PLAYER_INTERACTION_MANAGER_FRAME_SHOW' and type == 10 then
        C_Timer.After(0.5, function()
            local money = GetMoney()
            if (money > amountToKeep) then
                money = money-amountToKeep

                GuildBankFrame.DepositButton:Click('LeftButton')

                if (StaticPopup1:IsVisible()) then
                    local length = slen(money)

                    C_Timer.After(0.5, function()
                        StaticPopup1MoneyInputFrameGold:SetText(ssub(money, 0, length-4))
                        StaticPopup1MoneyInputFrameSilver:SetText(ssub(money, length-3, length-2))
                        StaticPopup1MoneyInputFrameCopper:SetText(ssub(money, length-1, length-0))
                        StaticPopup1Button1:Click()
                    end)
                end
            elseif (money < amountToKeep) then
                money = amountToKeep-money

                GuildBankFrame.WithdrawButton:Click('LeftButton')

                if (StaticPopup1:IsVisible()) then
                    local length = slen(money)

                    C_Timer.After(0.5, function()
                        StaticPopup1MoneyInputFrameGold:SetText(ssub(money, 0, length-4))
                        StaticPopup1MoneyInputFrameSilver:SetText(ssub(money, length-3, length-2))
                        StaticPopup1MoneyInputFrameCopper:SetText(ssub(money, length-1, length-0))
                        StaticPopup1Button1:Click()
                    end)
                end
            end
        end)
    end
end

function AutoDepositGuildBank:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('AutoDepositGuildBank', defaults)

	self:SetEnabledState(self.db.profile.enabled)
end

function AutoDepositGuildBank:OnEnable()
    self:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_SHOW')

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function AutoDepositGuildBank:ApplyConfig(config)
	if config then
		self.config = config
	end
end