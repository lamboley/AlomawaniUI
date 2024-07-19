local _, AlomawaniUI = ...
local Voicing = AlomawaniUI:NewModule('Voicing', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
        timer = 10,
        debug = false,
		deathsound = true,
		combatstart = true,
		combatstop = true,
		duringcombat = true,
		ilgynothdeathsounds = {
			[1360543] = true, -- "You have failed those who needed you"
			[1360544] = true, -- "Your light sputters out"
			[1360545] = true, -- "Welcome death. Do not fight it"
		},
		yshaarjdeathsounds = {
			[901523] = true, -- "Wish each thread unravel, a step closer to my realm"
			[901525] = true, -- "Another blemish on your soul"
			[901527] = true, -- "You will rest in Ny'alotha"
		},
		xalatathdeathsounds = {
			[1391162] = true, -- Delicious
			[1391163] = true, -- Every little death helps
			[1391164] = true, -- Enjoy that?
			[1391165] = true, -- Boring
			[1391167] = true, -- *Long laugh*
			[1391194] = true, -- *Short laugh*
		},
		yoggsarondeathsounds = {
			[564844] = true, -- "Your will is no longer your own"
		},
	}
}

function Voicing:PLAYER_DEAD()
	local possibleSounds = {}

    if self.currentSoundHandle then
        StopSound(self.currentSoundHandle)
        self.currentSoundHandle = nil
    end

	for key, value in pairs(self.db.profile.ilgynothdeathsounds) do
		if value then
			table.insert(possibleSounds, key)
		end
	end

	for key, value in pairs(self.db.profile.yshaarjdeathsounds) do
		if value then
			table.insert(possibleSounds, key)
		end
	end

	for key, value in pairs(self.db.profile.xalatathdeathsounds) do
		if value then
			table.insert(possibleSounds, key)
		end
	end

	for key, value in pairs(self.db.profile.yoggsarondeathsounds) do
		if value then
			table.insert(possibleSounds, key)
		end
	end

	local soundFile = possibleSounds[math.random(1, #possibleSounds)]
	local currentTime = time()

	if (currentTime - self.lastSoundTime) > self.db.profile.timer  then
		local willPlay, soundHandle = PlaySoundFile(soundFile , 'Master', true, false)
		if willPlay then
			if self.db.profile.debug then
				AlomawaniUI.Print('Playing Sounds : ' .. soundFile)
			end

			self.lastSoundTime = currentTime
			self.currentSoundHandle = soundHandle
		end
	end
end

function Voicing:OnInitialize()
    self.db = AlomawaniUI.db:RegisterNamespace('Voicing', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self.lastSoundTime = 0
end

function Voicing:OnEnable()
	if self.db.profile.deathsound then
		self:RegisterEvent('PLAYER_DEAD')
	end

    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Voicing:ApplyConfig(config)
	if config then
		self.config = config
	end
end