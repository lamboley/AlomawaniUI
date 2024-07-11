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
			desc = 'Modify the ObjectiveTrackerFrame',
			get = function() return self.db.profile.enabled end,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'Layout'),
			scale = {
				order = 3,
				name = 'Scale',
				desc = 'Configure the scale of the ObjectiveTrackerFrame. (Need /reload)',
				type = "range",
				min = 0.01, softMin = .1, softMax = 2, bigStep = 0.05,
				get = myGetterFunc,
				set = mySetterFunc,
			},
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