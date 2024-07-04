local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local BattlePet = AlomawaniUI:GetModule('BattlePet')

function BattlePet:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Battle Pet module',
			get = function() return BattlePet.db.profile.enabled end,
			set = function(info, value)
				BattlePet.db.profile.enabled = value
				if value and not BattlePet:IsEnabled() then
					BattlePet:Enable()
				elseif not value and BattlePet:IsEnabled() then
					BattlePet:Disable()
				end
			end,
			width = 'full',
		}

		self.battlepetoptions = {
			enabled = enabled,
			styleheader = {
				order = 2,
				type = 'header',
				name = 'General',
			},
			guid = {
				order = 3,
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
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 30,
		type = "group",
		name = 'Battle Pet',
		arg = 'Battle Pet',
	}

	AlomawaniUI:RegisterModuleOptions('battlepet', self.options)
	self.options.args = self:IsEnabled() and self.battlepetoptions or self.disabledoptions
end