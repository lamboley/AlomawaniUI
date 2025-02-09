local _, AlomawaniUI = ...
local Vendors = AlomawaniUI:NewModule('Vendors', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
        useguild = false,
        blacklist = {
        },
	}
}

local function IsInside(table, element)
    for _, value in pairs(table) do
      if value == element then return true end
    end
    return false
end

  
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

    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots  = C_Container.GetContainerNumSlots(bagID)
        if numSlots then
            for slot = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slot)
                if itemID then
                    local containerInfo = C_Container.GetContainerItemInfo(bagID, slot)
                    if not containerInfo.isLocked and containerInfo.iconFileID then
                        if (containerInfo.quality and containerInfo.quality == 0) or IsInside(self.db.profile.blacklist, containerInfo.itemID) then
                            C_Container.UseContainerItem(bagID, slot)
                        end
                    end
                end
            end
        end
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