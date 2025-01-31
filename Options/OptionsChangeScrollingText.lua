local _, AlomawaniUI = ...
local ChangeScrollingText = AlomawaniUI:GetModule('ChangeScrollingText')

function ChangeScrollingText:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 5,
			name = 'Disable Scrolling Text while in party',
			desc = 'Disable Scrolling Text while in party',
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

		AlomawaniUI.options.args.miscellaneous.args.options.args.changescrollingtext = enabled
	end
end