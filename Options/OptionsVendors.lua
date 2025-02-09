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
			header2 = AlomawaniUI.Header(4, 'Blacklist'),
			blacklist = {
				type = 'input',
				order = 5,
				width = 'full',
				name = '',
				multiline = 16,
				get = function()
					local auras = {}
					for _, aura in pairs(self.db.profile.blacklist) do
						auras[#auras+1] = aura
					end
					return table.concat(auras, "\n" )
				end,
				set = function(_, value)
					wipe(self.db.profile.blacklist)
					local auras = { strsplit("\n", strtrim(value)) }
					for _, name in pairs(auras) do
						local aura = strtrim(name)
						if #aura>0 then
							table.insert(self.db.profile.blacklist, tonumber(aura) or aura)
						end
					end
				end,
			}
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