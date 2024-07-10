local _, AlomawaniUI = ...
local ChangeQuestFrame = AlomawaniUI:GetModule('ChangeQuestFrame')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return ChangeQuestFrame.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		ChangeQuestFrame.db.profile[info[#info]] = value
	end
end

function ChangeQuestFrame:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable modification to Quest Frame.',
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
		order = 2,
		type = 'group',
		name = 'Quest Frame',
		desc = 'Make modification to Objective Tracker Frame.',
        childGroups = 'tab',
	}

	AlomawaniUI.options.args.miscellaneous.args.changequestframe = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end