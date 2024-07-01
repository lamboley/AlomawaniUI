local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local KeepBattlePet = AlomawaniUI:GetModule("KeepBattlePet")

local options
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = "KeepBattlePet",
			arg = "KeepBattlePet",
			get = function() end,
			set = function(info, value) end,
			args = {
				intro = {
					order = 1,
					type = "description",
					name = "The Coordinates module adds a display of your current location, and the coordinates of your mouse cursor to the World Map frame.",
				},
			},
		}
	end

	return options
end

function KeepBattlePet:SetupOptions()
	AlomawaniUI:RegisterModuleOptions(getOptions, 'KeepBattlePet')
end
