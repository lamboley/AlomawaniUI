local _, AlomawaniUI = ...
local ChangeChat = AlomawaniUI:GetModule('ChangeChat')

function ChangeChat:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 4,
			name = 'Modify Chat Frame',
			desc = 'Modify Chat Frame',
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

		AlomawaniUI.options.args.miscellaneous.args.options.args.changechatenabled = enabled
	end
end