local AlomawaniUI = LibStub('AceAddon-3.0'):GetAddon('AlomawaniUI')

AlomawaniUI.title = format('|cff1784d1%s |r', 'AlomawaniUI')
AlomawaniUI.version = GetAddOnMetadata('AlomawaniUI', 'Version')
AlomawaniUI.myFaction, AlomawaniUI.myLocalizedFaction = UnitFactionGroup('player')
AlomawaniUI.myLevel = UnitLevel('player')
AlomawaniUI.myLocalizedClass, AlomawaniUI.myClass, AlomawaniUI.myClassID = UnitClass('player')
AlomawaniUI.myLocalizedRace, AlomawaniUI.myRace = UnitRace('player')
AlomawaniUI.myName = UnitName('player')
AlomawaniUI.myRealm = GetRealmName()
AlomawaniUI.myNameRealm = format('%s - %s', AlomawaniUI.myName, AlomawaniUI.myRealm)
AlomawaniUI.wowPatch, AlomawaniUI.wowBuild = GetBuildInfo()
AlomawaniUI.wowBuild = tonumber(AlomawaniUI.wowBuild)