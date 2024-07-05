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
	AceConfigDialog:SetDefaultSize('AlomawaniUI', 590, 650)
end