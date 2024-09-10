local _, AlomawaniUI = ...
local BuffFrameFilter = AlomawaniUI:GetModule('BuffFrameFilter')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return BuffFrameFilter.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		BuffFrameFilter.db.profile[info[#info]] = value
	end
end

function BuffFrameFilter:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Buff Frame module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			defaultstate = {
				order = 3,
				name = 'Default state',
				desc = 'Collapse or Expand by default',
				type = 'select',
				values = {EXPAND = 'Expand', COLLAPSE = 'Collapse'},
				set = mySetterFunc,
				get = myGetterFunc,
			},
			header2 = AlomawaniUI.Header(4, 'Location to Collapse'),
			battlegroundcollapse = {
				order = 5,
				type = 'toggle',
				name = 'Battleground',
				desc = 'Collapse when entering in a battleground',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 8,
		type = 'group',
		name = 'Buff Frame',
		arg = 'Buff Frame',
	}

	AlomawaniUI.options.args.buffframefilter = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end