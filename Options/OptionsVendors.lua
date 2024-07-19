local _, AlomawaniUI = ...
local Vendors = AlomawaniUI:GetModule('Vendors')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return Vendors.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		Vendors.db.profile[info[#info]] = value
	end
end

function Vendors:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Auto Repair',
			get = function() return self.db.profile.enabled end,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			useguild = {
				order = 3,
				type = 'toggle',
				name = 'Use guild gold',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 3,
		type = 'group',
		name = 'Vendors',
		desc = 'Make modification when opening Merchant Frame.',
        childGroups = 'tab',
	}

	AlomawaniUI.options.args.miscellaneous.args.vendors = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end