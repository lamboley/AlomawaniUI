local _, AlomawaniUI = ...
local Vendors = AlomawaniUI:NewModule('Vendors', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
        useguild = false,
	}
}

function Vendors:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('Vendors', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('MERCHANT_SHOW')
end

function Vendors:MERCHANT_SHOW()
    if CanMerchantRepair() then
        if self.db.profile.useguild and select(1, GetGuildInfo('player')) then
            RepairAllItems(true)
        end
        RepairAllItems()
    end
end

function Vendors:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Vendors:ApplyConfig(config)
	if config then
		self.config = config
	end
end