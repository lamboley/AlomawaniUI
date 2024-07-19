local _, AlomawaniUI = ...
local Voicing = AlomawaniUI:GetModule('Voicing')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return Voicing.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		Voicing.db.profile[info[#info]] = value
	end
end

function Voicing:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Voicing module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			debug = {
				order = 2,
				type = 'toggle',
				name = 'Print message when sound play',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			timer = {
				order = 3,
				name = 'Timer',
				desc = 'Minimum seconds between sounds.',
				type = 'range',
				min = 5, max = 300, bigStep = 1,
				get = myGetterFunc,
				set = mySetterFunc,
				-- width = 'full',
			},

			header2 = AlomawaniUI.Header(4, 'Event'),
			deathsound = {
				order = 5,
				type = 'toggle',
				name = 'When player die',
				desc = 'Make sound when player die.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			combatstart = {
				order = 6,
				type = 'toggle',
				name = 'When combat start',
				desc = 'Make sound when combat start.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			combatstop = {
				order = 7,
				type = 'toggle',
				name = 'When combat stop',
				desc = 'Make sound when combat stop.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			duringcombat = {
				order = 8,
				type = 'toggle',
				name = 'During combat',
				desc = 'Make sound during combat.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
		}

		self.ilgynothoptions = {
			header11 = AlomawaniUI.Header(1, 'Death Sounds'),
			['1360543'] = {
				order = 2,
				type = 'toggle',
				name = '1360543',
				desc = 'You have failed those who needed you.',
				set = function(_, value)
					self.db.profile.ilgynothdeathsounds[1360543] = value
				end,
				get = function()
					return self.db.profile.ilgynothdeathsounds[1360543]
				end,
			},
			['1360544'] = {
				order = 3,
				type = 'toggle',
				name = '1360544',
				desc = 'Your light sputters out.',
				set = function(_, value)
					self.db.profile.ilgynothdeathsounds[1360544] = value
				end,
				get = function()
					return self.db.profile.ilgynothdeathsounds[1360544]
				end,
			},
			['1360545'] = {
				order = 4,
				type = 'toggle',
				name = '1360545',
				desc = 'Welcome death. Do not fight it',
				set = function(_, value)
					self.db.profile.ilgynothdeathsounds[1360545] = value
				end,
				get = function()
					return self.db.profile.ilgynothdeathsounds[1360545]
				end,
			},
		}

		self.yshaarjoptions = {
			header21 = AlomawaniUI.Header(1, 'Death Sounds'),
			['901523'] = {
				order = 2,
				type = 'toggle',
				name = '901523',
				desc = 'Wish each thread unravel, a step closer to my realm.',
				set = function(_, value)
					self.db.profile.yshaarjdeathsounds[901523] = value
				end,
				get = function()
					return self.db.profile.yshaarjdeathsounds[901523]
				end,
			},
			['901525'] = {
				order = 3,
				type = 'toggle',
				name = '901525',
				desc = 'Another blemish on your soul.',
				set = function(_, value)
					self.db.profile.yshaarjdeathsounds[901525] = value
				end,
				get = function()
					return self.db.profile.yshaarjdeathsounds[901525]
				end,
			},
			['901527'] = {
				order = 4,
				type = 'toggle',
				name = '901527',
				desc = "You will rest in Ny'alotha",
				set = function(_, value)
					self.db.profile.yshaarjdeathsounds[901527] = value
				end,
				get = function()
					return self.db.profile.yshaarjdeathsounds[901527]
				end,
			},
		}

		self.xalatathoptions = {
			header31 = AlomawaniUI.Header(1, 'Death Sounds'),
			['1391162'] = {
				order = 2,
				type = 'toggle',
				name = '1391162',
				desc = 'Delicious',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391162] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391162]
				end,
			},
			['1391163'] = {
				order = 3,
				type = 'toggle',
				name = '1391163',
				desc = 'Every little death helps',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391163] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391163]
				end,
			},
			['1391164'] = {
				order = 4,
				type = 'toggle',
				name = '1391164',
				desc = 'Enjoy that?',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391164] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391164]
				end,
			},
			['1391165'] = {
				order = 5,
				type = 'toggle',
				name = '1391165',
				desc = 'Boring',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391165] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391165]
				end,
			},
			['1391167'] = {
				order = 6,
				type = 'toggle',
				name = '1391167',
				desc = '*Long laugh*',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391167] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391167]
				end,
			},
			['1391194'] = {
				order = 7,
				type = 'toggle',
				name = '1391194',
				desc = '*Short laugh*',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[1391194] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[1391194]
				end,
			},
		}

		self.yoggsaronoptions = {
			header41 = AlomawaniUI.Header(1, 'Death Sounds'),
			['564844'] = {
				order = 2,
				type = 'toggle',
				name = '564844',
				desc = 'Your will is no longer your own',
				set = function(_, value)
					self.db.profile.xalatathdeathsounds[564844] = value
				end,
				get = function()
					return self.db.profile.xalatathdeathsounds[564844]
				end,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 1,
		type = 'group',
		name = 'General Settings',
		arg = 'General Settings',
	}

	AlomawaniUI.options.args.voicing.args.generalsettings = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions

	AlomawaniUI.options.args.voicing.args.ilgynoth.args = self.ilgynothoptions
	AlomawaniUI.options.args.voicing.args.yshaarj.args = self.yshaarjoptions
	AlomawaniUI.options.args.voicing.args.xalatath.args = self.xalatathoptions
	AlomawaniUI.options.args.voicing.args.yoggsaron.args = self.yoggsaronoptions
end

