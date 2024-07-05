local _, AlomawaniUI = ...
local BattlePet = AlomawaniUI:GetModule('BattlePet')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return BattlePet.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		BattlePet.db.profile[info[#info]] = value
	end
end

function BattlePet:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Battle Pet module',
			get = myGetterFunc,
			set = function(info, value)
				self.db.profile.enabled = value
				if value and not self:IsEnabled() then
					self:Enable()
				elseif not value and self:IsEnabled() then
					self:Disable()
				end
			end,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			battlepetname = {
				order = 3,
				type = 'input',
				name = 'Pet Name',
				desc = 'Pet Name',
				get = myGetterFunc,
				set = mySetterFunc,
				dialogControl = 'EditBox',
			},
			header2 = AlomawaniUI.Header(4, 'When not to summon'),
			battleground = {
				order = 5,
				type = 'toggle',
				name = 'Battleground',
				desc = 'Do not summon your battle pet during a battleground.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			arena = {
				order = 6,
				type = 'toggle',
				name = 'Arena',
				desc = 'Do not summon your battle pet during an arena match.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			stealth = {
				order = 7,
				type = 'toggle',
				name = 'Stealth',
				desc = 'Do not summon your battle pet while in stealth.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 2,
		type = 'group',
		name = 'Battle Pet',
		arg = 'Battle Pet',
	}

	AlomawaniUI:AddModuleOptions('battlepet', self.options)
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end