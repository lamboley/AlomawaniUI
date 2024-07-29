local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')

function AlomawaniUI:GetPetGUID()
    local summonedPetGUID = C_PetJournal.GetSummonedPetGUID()
    if summonedPetGUID then
        AlomawaniUI.Print(summonedPetGUID)
    end
end

function AlomawaniUI:ShowZoneID()
    local id = self.GetZoneID()
    AlomawaniUI.Print(strjoin(' - ', id, C_Map.GetMapInfo(id).name))
end

function AlomawaniUI.GetZoneID()
    return C_Map.GetBestMapForUnit('player')
end

function AlomawaniUI:GetMountID(spellID)
    if spellID == nil then return end
    local mountIDs = C_MountJournal.GetMountIDs
    for _, mountID in pairs(mountIDs) do
        local mountName, mountSpellID = C_MountJournal.GetMountInfoByID(mountID)

        if mountSpellID == tonumber(spellID) then
            self.Print(strjoin(' ', mountName, mountID))
        end
    end
end

local function msToModernBlizzard(ms)
    return string.format("%d min %02d sec", ms / 1000 / 60, (ms / 1000) % 60)
end

function AlomawaniUI:QueueTime()
    if GetBattlefieldStatus(1) == 'queued' then
        AlomawaniUI.Print('Average Wait Time: ' .. msToModernBlizzard(GetBattlefieldEstimatedWaitTime(1)))
        AlomawaniUI.Print('Time In Queue: ' .. msToModernBlizzard(GetBattlefieldTimeWaited(1)))
    end
end

function AlomawaniUI:LoadCommands()
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('zoneid', 'ShowZoneID')
    self:RegisterChatCommand('alomawaniui', 'ToggleOptions')
    self:RegisterChatCommand('mountid', 'GetMountID')
    self:RegisterChatCommand('queuetime', 'QueueTime')
end

