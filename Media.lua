local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')
local LSM = LibStub('LibSharedMedia-3.0')

local mediaPath = {
	statusbar = [[Interface\AddOns\AlomawaniUI\Media\Statusbar\]],
	sound = [[Interface\AddOns\AlomawaniUI\Media\Sounds\]],
	background = [[Interface\AddOns\AlomawaniUI\Media\Background\]],
	font = [[Interface\AddOns\AlomawaniUI\Media\Font\]],
}

local function AddMedia(type, name, file)
	LSM:Register(type, name, mediaPath[type] .. file)
end

function AlomawaniUI:LoadMedia()
	AddMedia('statusbar','AlomawaniUIOnePixel', 'AlomawaniUIOnePixel')
	AddMedia('statusbar','AlomawaniUIClean', 'AlomawaniUIClean')
	AddMedia('sound','|cFF00FF00AlomawaniUIGTFO|r', 'GTFO.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUIGTFO Quiet|r', 'GTFO_quiet.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUIGTFO Soft|r', 'GTFO_soft.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI dispelboss|r', 'dispelboss.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI dispelnow|r', 'dispelnow.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI stopmove|r', 'stopmove.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI stopattack|r', 'stopattack.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI runout|r', 'runout.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI runin|r', 'runin.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI runaway|r', 'runaway.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI movetotank|r', 'movetotank.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI movemelee|r', 'movemelee.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI mobsoon|r', 'mobsoon.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI killmob|r', 'killmob.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI keepmove|r', 'keepmove.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI keepjump|r', 'keepjump.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI incomingdebuff|r', 'incomingdebuff.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI helpsoak|r', 'helpsoak.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI healfull|r', 'healfull.ogg')
	AddMedia('sound','|cFF00FF00AlomawaniUI silence|r', 'silence.ogg')
	AddMedia('font','FiraSansCondensed', 'FiraSansCondensed-Medium.ttf')
end

