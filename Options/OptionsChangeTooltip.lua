local _, AlomawaniUI = ...
local ChangeTooltip = AlomawaniUI:GetModule('ChangeTooltip')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return ChangeTooltip.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		ChangeTooltip.db.profile[info[#info]] = value
	end
end

function ChangeTooltip:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable modification to tooltip',
			get = myGetterFunc,
			set = "ToggleModule",
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 3,
		type = 'group',
		name = 'Game Tooltip',
		desc = 'Make modification to Game Tooltip.',
        childGroups = 'tab',
	}

	AlomawaniUI.options.args.miscellaneous.args.changetooltip = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end