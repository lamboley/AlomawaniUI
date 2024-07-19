local _, AlomawaniUI = ...
local AceDBOptions = LibStub('AceDBOptions-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)
local AceConfig = LibStub('AceConfig-3.0')

local function generateOptions()
	AlomawaniUI.options = {
			type = 'group',
			name = 'AlomawaniUI',
			plugins = {},
			childGroups = 'tree',
			args = {
				miscellaneous = {
					order = 1,
					type = 'group',
					name = 'Miscellaneous',
					args = {
						options = {
							type = 'group',
							order = 0,
							name = function(info) if info.uiType == 'dialog' then return '' else return 'Bar Options' end end,
							guiInline = true,
							args = {
							}
						},
					},
				},
				voicing = {
					order = 5,
					type = "group",
					name = 'Voicing',
					childGroups = "tab",
					args = {
						ilgynoth = {
							order = 2,
							type = 'group',
							name = 'Ilgynoth',
							arg = 'Ilgynoth',
							args = {
							},
						},
						yshaarj = {
							order = 3,
							type = 'group',
							name = 'Yshaarj',
							arg = 'Yshaarj',
							args = {
							},
						},
						xalatath = {
							order = 4,
							type = 'group',
							name = 'Xalatath',
							arg = 'Xalatath',
							args = {
							},
						},
						yoggsaron = {
							order = 5,
							type = 'group',
							name = 'Yogg Saron',
							arg = 'Yogg Saron',
							args = {
							},
						},
					}
				},
			},
	}

	for k,v in AlomawaniUI:IterateModules() do
		if v.SetupOptions then
			v:SetupOptions()
		end
	end

	AlomawaniUI.options.plugins.profiles = {
		profiles = AceDBOptions:GetOptionsTable(AlomawaniUI.db)
	}

	if LibDualSpec then
		LibDualSpec:EnhanceOptions(AlomawaniUI.options.plugins.profiles.profiles, AlomawaniUI.db)
	end
end

local function getOptions()
	if not AlomawaniUI.options then
		generateOptions()
		generateOptions = nil
	end

	return AlomawaniUI.options
end

function AlomawaniUI:ToggleOptions(input)
	if InCombatLockdown() then
		AlomawaniUI.Print("Can't open options in combats.")
		return
	end

	AceConfigDialog:Open('AlomawaniUI')
end

function AlomawaniUI:SetupOptions()
	AceConfig:RegisterOptionsTable('AlomawaniUI', getOptions)
	AceConfigDialog:SetDefaultSize('AlomawaniUI', 940, 650)
end