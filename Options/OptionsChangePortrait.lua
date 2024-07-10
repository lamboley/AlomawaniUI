local _, AlomawaniUI = ...
local ChangePortrait = AlomawaniUI:GetModule('ChangePortrait')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return ChangePortrait.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		ChangePortrait.db.profile[info[#info]] = value
	end
end

function ChangePortrait:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable modification to the player portrait.',
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
		name = 'Player Portrait',
		desc = 'Make modification to the player portrait.',
        childGroups = 'tab',
	}

	AlomawaniUI.options.args.miscellaneous.args.changeportrait = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end