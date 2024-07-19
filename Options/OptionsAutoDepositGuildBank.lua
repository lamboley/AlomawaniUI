local _, AlomawaniUI = ...
local AutoDepositGuildBank = AlomawaniUI:GetModule('AutoDepositGuildBank')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return AutoDepositGuildBank.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		AutoDepositGuildBank.db.profile[info[#info]] = value
	end
end

function AutoDepositGuildBank:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Guild Bank module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			amounttokeep = {
				order = 3,
				type = 'input',
				name = 'Amount of gold to keep',
				desc = 'Amount of gold to keep in bag. (default: 100)',
				get = myGetterFunc,
				set = mySetterFunc,
				-- dialogControl = 'NumberEditBox',
			},
			checkguildbank = {
				order = 4,
				type = 'toggle',
				name = 'Check matching guild name',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			guildname = {
				order = 5,
				type = 'input',
				name = 'Guild Name',
				desc = 'Guild name to send gold.',
				get = myGetterFunc,
				set = mySetterFunc,
			},


			checkguildbank
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 7,
		type = 'group',
		name = 'Guild Bank',
		arg = 'Guild Bank',
	}

	AlomawaniUI.options.args.autodepositguildbank = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end