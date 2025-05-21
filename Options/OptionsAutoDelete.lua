local _, AlomawaniUI = ...
local AutoDelete = AlomawaniUI:GetModule('AutoDelete')

function AutoDelete:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 6,
			name = 'Make deleting item more  easy',
			desc = 'Make deleting item more  easy',
			get = function()
				return self.db.profile.enabled
			end,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
		}

		self.disabledoptions = {
			enabled = enabled,
		}

		AlomawaniUI.options.args.miscellaneous.args.options.args.autodeleteenabled = enabled
	end

	-- self.options = {
	-- 	order = 3,
	-- 	type = 'group',
	-- 	name = 'Tooltip',
	-- 	desc = 'Make modification to Game Tooltip.',
    --     childGroups = 'tab',
	-- }

	-- AlomawaniUI.options.args.miscellaneous.args.AutoDelete = self.options
	-- self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end