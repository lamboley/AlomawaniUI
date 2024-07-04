local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local AceConsole = LibStub('AceConsole-3.0')
local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceDBOptions = LibStub('AceDBOptions-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local options, moduleOptions = nil, {}

local function generateOptions()
	AlomawaniUI.options = {
			type = 'group',
			name = 'AlomawaniUI',
			plugins = {},
			args = {
				general = {
					order = 1,
					type = 'group',
					name = 'General Settings',
					args = {
						intro = {
							order = 1,
							type = 'description',
							name ='AlomawaniUI is the personnal addon of Alomawani.',
						},
					},
				},
			},
	}

	for k,v in AlomawaniUI:IterateModules() do
		if v.SetupOptions then
			v:SetupOptions()
		end
	end

	AlomawaniUI.options.plugins.profiles = {
		profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(AlomawaniUI.db)
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
		AlomawaniUI.Print('Cannot access options during combat.')
		return
	end
	if not input or input:trim() == '' then
		AceConfigDialog:Open('AlomawaniUI')
	end
end

function AlomawaniUI:SetupOptions()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("AlomawaniUI", getOptions)
	AceConfigDialog:SetDefaultSize('AlomawaniUI', 660, 650)
end

function AlomawaniUI:RegisterModuleOptions(id, table)
	if not self.options then
		error("Options table has not been created yet, respond to the callback!", 2)
	end
	AlomawaniUI.options.args[id] = table
end