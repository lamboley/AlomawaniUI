local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local BattlePet = AlomawaniUI:GetModule('BattlePet')

local options
local function getOptions()
	if not options then
		options = {
			type = 'group',
			name = 'Battle Pet',
			arg = 'Battle Pet',
			args = {
				x = {
					order = 1,
					type = 'input',
					name = 'Battle Pet GUID',
					desc = 'Battle Pet GUID',
                    get = function(info)
						return BattlePet.db.profile.battlepetname
					end,
                    set = function(info, value)
						BattlePet.db.profile.battlepetname = value
					end,
					dialogControl = 'EditBox',
				},
			},
		}
	end

	return options
end

function BattlePet:SetupOptions()
	AlomawaniUI:RegisterModuleOptions(getOptions, 'BattlePet')
end