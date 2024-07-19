local _, AlomawaniUI = ...
local Alerts = AlomawaniUI:GetModule('Alerts')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return Alerts.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		Alerts.db.profile[info[#info]] = value
	end
end

function Alerts:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Alerts module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			foodmage =  {
				order = 3,
				type = 'toggle',
				name = 'Food mage alerts',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			cookie =  {
				order = 4,
				type = 'toggle',
				name = 'Cookie alerts',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 6,
		type = 'group',
		name = 'Alerts',
		arg = 'Alerts',
	}

	AlomawaniUI.options.args.alert = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end