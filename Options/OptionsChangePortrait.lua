local _, AlomawaniUI = ...
local ChangePortrait = AlomawaniUI:GetModule('ChangePortrait')

function ChangePortrait:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Change the visibility of the Player Portrait',
			desc = 'Change the visibility of the Player Portrait.',
			get = function() return self.db.profile.enabled end,
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

		AlomawaniUI.options.args.miscellaneous.args.options.args.changeportraitenabled = enabled
	end

	-- self.options = {
	-- 	order = 3,
	-- 	type = 'group',
	-- 	name = 'Player Portrait',
	-- 	desc = 'Make modification to the player portrait.',
    --     childGroups = 'tab',
	-- }

	-- AlomawaniUI.options.args.miscellaneous.args.changeportrait = self.options
	-- self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end