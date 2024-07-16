local _, AlomawaniUI = ...
local ChangeTooltip = AlomawaniUI:GetModule('ChangeTooltip')

function ChangeTooltip:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Hide tooltip during Combat',
			desc = 'Hide tooltip during Combat',
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

		AlomawaniUI.options.args.miscellaneous.args.options.args.changetooltipenabled = enabled
	end

	-- self.options = {
	-- 	order = 3,
	-- 	type = 'group',
	-- 	name = 'Tooltip',
	-- 	desc = 'Make modification to Game Tooltip.',
    --     childGroups = 'tab',
	-- }

	-- AlomawaniUI.options.args.miscellaneous.args.changetooltip = self.options
	-- self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end