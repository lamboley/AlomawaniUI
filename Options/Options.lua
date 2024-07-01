local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local AceConsole = LibStub("AceConsole-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local options, moduleOptions = nil, {}
local function getOptions()
	if not options then
		options = {
			type = "group",
			name = "AlomawaniUI",
			args = {
				general = {
					order = 1,
					type = "group",
					name = "General Settings",
                    get = function() end,
                    set = function(info, value) end,
					args = {
						intro = {
							order = 1,
							type = "description",
							name ="AlomawaniUI allows you to control various aspects of your World Map. You can change the style of the map, control the plugins that extend the map with new functionality, and configure different profiles for every of your characters.",
						},
					},
				},
			},
		}
		for k,v in pairs(moduleOptions) do
			options.args[k] = (type(v) == "function") and v() or v
		end
	end

	return options
end

function AlomawaniUI:ChatCommand(input)
	if InCombatLockdown() then
		self:Print(L["Cannot access options during combat."])
		return
	end
	if not input or input:trim() == "" then
		AceConfigDialog:Open("AlomawaniUI")
	end
end

function AlomawaniUI:SetupOptions()
	self:RegisterModuleOptions(AceDBOptions:GetOptionsTable(self.db), "Profiles")

	if LibDualSpec then
		LibDualSpec:EnhanceOptions(AceDBOptions:GetOptionsTable(self.db), AlomawaniUI.db)
	end

	AceConfigRegistry:RegisterOptionsTable("AlomawaniUI", getOptions)


	AceConfigDialog:SetDefaultSize("AlomawaniUI", 660, 650)
	self:RegisterChatCommand( "alomawaniui", "ChatCommand")
end

function AlomawaniUI:RegisterModuleOptions(optionTbl, name)
	moduleOptions[name] = optionTbl
end