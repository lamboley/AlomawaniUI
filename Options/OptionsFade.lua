local _, AlomawaniUI = ...
local Fade = AlomawaniUI:GetModule('Fade')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return Fade.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		Fade.db.profile[info[#info]] = value
	end
end

function Fade:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Fade module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			menufade = {
				order = 2,
				type = 'toggle',
				name = 'Fade Out the Micro Menu',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.menuoptions = {
			header11 = AlomawaniUI.Header(1, 'Death Sounds'),
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 1,
		type = 'group',
		name = 'General Settings',
		arg = 'General Settings',
	}

	AlomawaniUI.options.args.fade.args.generalsettings = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions

	AlomawaniUI.options.args.fade.args.menu.args = self.menuoptions
end

