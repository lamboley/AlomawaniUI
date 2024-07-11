local _, AlomawaniUI = ...
local MoutSummonEnhanced = AlomawaniUI:GetModule('MoutSummonEnhanced')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return MoutSummonEnhanced.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		MoutSummonEnhanced.db.profile[info[#info]] = value
	end
end

local function UpdateZoneID()
end

function MoutSummonEnhanced:SetupOptions()
	if not self.options then
		local enabled = {
			type = 'toggle',
			order = 1,
			name = 'Enabled',
			desc = 'Enable the Enhanced Mount module',
			get = myGetterFunc,
			set = 'ToggleModule',
			handler = self,
			width = 'full',
		}

		self.modulesoptions = {
			enabled = enabled,
			header1 = AlomawaniUI.Header(2, 'General'),
			-- groundmount = {
			-- 	order = 3,
			-- 	type = 'input',
			-- 	name = 'Ground Mount ID',
			-- 	desc = 'Ground Mount ID',
			-- 	get = myGetterFunc,
			-- 	set = mySetterFunc,
			-- 	dialogControl = 'EditBox',
			-- },
			groundmount = {
				name = 'Select ground mount',
				type = 'select',
				order = 3,
				width = 2,
				get = myGetterFunc,
				set = mySetterFunc,
				values = function()
					local filters = {}
					for _, id in ipairs(C_MountJournal.GetMountIDs()) do
						local creatureName, _, iconTexture, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(id)
						if isCollected and isUsable  then
							filters[id] = format('|T%s:14:14:::64:64:4:60:4:60|t %s', iconTexture, creatureName)
						end
					end
					return filters
				end,
			},
			-- flyingmount = {
			-- 	order = 4,
			-- 	type = 'input',
			-- 	name = 'Flying Mount ID',
			-- 	desc = 'Flying Mount ID',
			-- 	get = myGetterFunc,
			-- 	set = mySetterFunc,
			-- 	dialogControl = 'EditBox',
			-- },
			flyingmount = {
				name = 'Select flying mount',
				type = 'select',
				order = 4,
				width = 2,
				get = myGetterFunc,
				set = mySetterFunc,
				values = function()
					local filters = {}
					for _, id in ipairs(C_MountJournal.GetMountIDs()) do
						local creatureName, _, iconTexture, _, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(id)
						if isCollected and isUsable  then
							filters[id] = format('|T%s:14:14:::64:64:4:60:4:60|t %s', iconTexture, creatureName)
						end
					end
					return filters
				end,
			},
			header2 = AlomawaniUI.Header(5, 'Force Ground Mount'),
			forcegroundmountinbattleground = {
				order = 6,
				type = 'toggle',
				name = 'Battleground',
				desc = 'Use ground mount in a battleground.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			forcegroundmountinarena = {
				order = 7,
				type = 'toggle',
				name = 'Arena',
				desc = 'Use ground mount in arena.',
				set = mySetterFunc,
				get = myGetterFunc,
			},
			header3 = AlomawaniUI.Header(8, 'Zone ID to force ground mount'),
			addZoneID = {
				type = 'input',
				order = 9,
				name = 'Add a zoneID',
				desc = 'Add the zoneID to the forced ground mount list.',
				get = function() return '' end,
				set = function(_, value)
					if value == '' or gsub(value, '%s+', '') == '' then return end
					self.db.profile.donotfly[value] = true
					UpdateZoneID()
				end,
			},
			removeZoneID = {
				type = 'input',
				order = 10,
				name = 'Remove a zoneID',
				desc = 'Remove the zoneID from the forced ground mount list.',
				get = function() return '' end,
				set = function(_, value)
					if value == '' or gsub(value, '%s+', '') == '' then return; end
					self.db.profile.donotfly[value] = nil
					UpdateZoneID()
				end,
			},
			-- descriptionAddRemoveAuto = AlomawaniUI.Description(11, 'Add or remove the current regionID from the list of forced ground mount.', 'full'),
			addCurrentZoneID = {
				type = 'execute',
				order = 11,
				name = 'Add current zoneID',
				desc = 'Add the current zoneID to the forced ground mount list.',
				func = function()
					self.db.profile.donotfly[tostring(AlomawaniUI.GetZoneID())] = true
					UpdateZoneID()
				end
			},
			removeCurrentZoneID = {
				type = 'execute',
				order = 12,
				name = 'Remove current zoneID',
				desc = 'Remove the current zoneID from the forced ground mount list.',
				func = function()
					self.db.profile.donotfly[tostring(AlomawaniUI:GetZoneID())] = nil
					UpdateZoneID()
				end
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 4,
		type = 'group',
		name = 'Summon Mount',
		arg = 'Summon Mount',
	}

	AlomawaniUI.options.args.summonmount = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end