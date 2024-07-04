local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')

function AlomawaniUI:GetPetGUID()
    local summonedPetGUID = C_PetJournal.GetSummonedPetGUID()
    if summonedPetGUID then
        print(summonedPetGUID)
    end
end

function AlomawaniUI:ShowZoneID()
    local id = C_Map.GetBestMapForUnit('player')
    print(strjoin(' - ', id, C_Map.GetMapInfo(id).name))
end

function AlomawaniUI:LoadCommands()
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('zoneid', 'ShowZoneID')
end

