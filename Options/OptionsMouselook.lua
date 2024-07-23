local _, AlomawaniUI = ...
local Mouselook = AlomawaniUI:GetModule('Mouselook')

function Mouselook:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 3,
			name = 'Disable right mouseclick',
			desc = 'Disable right mouseclick',
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

		AlomawaniUI.options.args.miscellaneous.args.options.args.mouselook = enabled
	end
end