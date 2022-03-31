//Assistant
/datum/attribute_holder/sheet/job/beggar
	attribute_variance = list(
		STAT_STRENGTH = list(-4, -2),
		STAT_ENDURANCE = list(-4, -2),
		STAT_DEXTERITY = list(-4, -2),
		STAT_INTELLIGENCE = list(-4, -2),
		SKILL_BRAWLING = list(-2, 1),
		SKILL_WRESTLING = list(-2, 1),
		SKILL_KNIFE = list(-1, 0),
		SKILL_GAMING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_KNIFE = -2,
		SKILL_GAMING = 0,
	)

//Atmos tech/Engineer
/datum/attribute_holder/sheet/job/engineer
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 0),
		STAT_INTELLIGENCE = list(-1, 3),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_IMPACT_WEAPON = list(-1, 3),
		SKILL_SHOTGUN = list(-1, 1),
		SKILL_ELECTRONICS = list(-2, 1),
		SKILL_MASONRY = list(-2, 2),
		SKILL_SMITHING = list(-1, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = -1,
		SKILL_SHOTGUN = -2,
		SKILL_ELECTRONICS = 4,
		SKILL_MASONRY = 4,
		SKILL_SMITHING = -2,
		SKILL_LOCKPICKING = 2,
		SKILL_ACROBATICS = 5,
	)

//Bartender
/datum/attribute_holder/sheet/job/innkeeper
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(1, 2),
		STAT_DEXTERITY = list(-2, 0),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_SHOTGUN = list(-1, 2),
		SKILL_THROWING = list(-2, 2),
		SKILL_CHEMISTRY = list(-2, 2),
		SKILL_COOKING = list(-3, 4),
		SKILL_CLEANING = list(0, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SHOTGUN = -2,
		SKILL_THROWING = -3,
		SKILL_CHEMISTRY = 0,
		SKILL_COOKING = 2,
		SKILL_CLEANING = 0,
	)

//Botanist (Formerly Chuck's)
/datum/attribute_holder/sheet/job/farmer
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 0),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 1),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_COOKING = list(-4, 2),
		SKILL_BOTANY = list(-4, 2),
		SKILL_CLEANING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SHOTGUN = -4,
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = 4,
		SKILL_COOKING = 2,
		SKILL_BOTANY = 5,
		SKILL_CLEANING = 0,
	)

//Captain
/datum/attribute_holder/sheet/job/doge
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-3, 1),
		SKILL_IMPACT_WEAPON = list(-4, 3),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_PISTOL = list(-3, 3),
		SKILL_SMG = list(-4, 4),
		SKILL_RIFLE = list(-4, 4),
		SKILL_RAPIER = list(-2, 2),
		SKILL_SHORTSWORD = list(-3, 3),
		SKILL_LONGSWORD = list(-3, 3),
		SKILL_THROWING = list(-1, 3),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MEDICINE = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 4,
		SKILL_PISTOL = 4,
		SKILL_RAPIER = 5,
		SKILL_LONGSWORD = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_SMG = 0,
		SKILL_RIFLE = 0,
		SKILL_THROWING = -3,
		SKILL_CLEANING = 0,
		SKILL_MEDICINE = 0,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = 4,
	)

//Cargo tech
/datum/attribute_holder/sheet/job/freighter
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 1),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_IMPACT_WEAPON = list(-1, 3),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_PISTOL = list(-2, 1),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MASONRY = list(-2, 2),
		SKILL_SCIENCE = list(-1, 1),
		SKILL_PICKPOCKET = list(-2, 2),
		SKILL_LOCKPICKING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 0,
		SKILL_PISTOL = 0,
		SKILL_KNIFE = -2,
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -3,
		SKILL_CLEANING = -2,
		SKILL_MASONRY = -3,
		SKILL_SCIENCE = -3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
	)

//Chaplain
/datum/attribute_holder/sheet/job/chaplain
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 2),
		STAT_ENDURANCE = list(-2, 2),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(0, 3),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_THROWING = list(-2, 1),
		SKILL_MEDICINE = list(-1, 1),
		SKILL_COOKING = list(-1, 2),
		SKILL_CLEANING = list(-1, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = -2,
		SKILL_THROWING = -2,
		SKILL_MEDICINE = -2,
		SKILL_COOKING = -2,
		SKILL_CLEANING = -2,
	)

//Chemist
/datum/attribute_holder/sheet/job/apothecary
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(0, 3),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_KNIFE = list(0, 2),
		SKILL_PISTOL = list(0, 1),
		SKILL_THROWING = list(-1, 2),
		SKILL_CHEMISTRY = list(-1, 2),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SCIENCE = list(0, 1),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_KNIFE = -3,
		SKILL_PISTOL = -3,
		SKILL_THROWING = -2,
		SKILL_CHEMISTRY = 6,
		SKILL_MEDICINE = 1,
		SKILL_SCIENCE = 0,
	)

//Chief engineer
/datum/attribute_holder/sheet/job/chief_engi
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-2, 1),
		STAT_INTELLIGENCE = list(-1, 4),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_POLEARM = list(0, 3),
		SKILL_ELECTRONICS = list(-2, 3),
		SKILL_MASONRY = list(-2, 3),
		SKILL_SMITHING = list(-2, 4),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-1, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 0,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 0,
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_POLEARM = -3,
		SKILL_ELECTRONICS = 6,
		SKILL_MASONRY = 6,
		SKILL_SMITHING = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = -2,
	)

//CMO
/datum/attribute_holder/sheet/job/hippocrite
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 1),
		STAT_DEXTERITY = list(-2, 4),
		STAT_INTELLIGENCE = list(-1, 4),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-1, 1),
		SKILL_THROWING = list(-2, 2),
		SKILL_CHEMISTRY = list(-2, 2),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SURGERY = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -2,
		SKILL_PISTOL = -2,
		SKILL_KNIFE = 2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_THROWING = 0,
		SKILL_CHEMISTRY = 0,
		SKILL_MEDICINE = 6,
		SKILL_SURGERY = 6,
		SKILL_SCIENCE = 0,
	)

//Clown and mime
/datum/attribute_holder/sheet/job/jester
	attribute_variance = list(
		STAT_STRENGTH = list(-6, 6),
		STAT_ENDURANCE = list(-6, 6),
		STAT_DEXTERITY = list(-6, 6),
		STAT_INTELLIGENCE = list(-6, 6),
		SKILL_BRAWLING = list(-6, 2),
		SKILL_WRESTLING = list(-8, 2),
		SKILL_IMPACT_WEAPON = list(-6, 2),
		SKILL_POLEARM = list(-4, 2),
		SKILL_STAFF = list(-2, 2),
		SKILL_FLAIL = list(-4, 4),
		SKILL_FLAIL_TWOHANDED = list(-4, 4),
		SKILL_THROWING = list(-2, 4),
		SKILL_PICKPOCKET = list(-2, 4),
		SKILL_GAMING = list(-1, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_POLEARM = 0,
		SKILL_STAFF = -2,
		SKILL_FLAIL = -2,
		SKILL_FLAIL_TWOHANDED = 0,
		SKILL_THROWING = 2,
		SKILL_PICKPOCKET = 0,
		SKILL_GAMING = 4,
	)

//Chef
/datum/attribute_holder/sheet/job/chef
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_WRESTLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_COOKING = list(-2, 4),
		SKILL_BOTANY = list(-2, 4),
		SKILL_CLEANING = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SHOTGUN = -2,
		SKILL_COOKING = 6,
		SKILL_BOTANY = 0,
		SKILL_CLEANING = 0,
	)

//Detective
/datum/attribute_holder/sheet/job/sheriff
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 0),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_PISTOL = list(-2, 4),
		SKILL_FORENSICS = list(-2, 4),
		SKILL_LOCKPICKING = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 2,
		SKILL_PISTOL = 3,
		SKILL_FORENSICS = 4,
		SKILL_LOCKPICKING = 0,
	)

//Geneticist / Medical Doctor
/datum/attribute_holder/sheet/job/humorist
	attribute_variance = list(STAT_STRENGTH = list(-1, 1),
							STAT_ENDURANCE = list(-1, 2),
							STAT_DEXTERITY = list(1, 3),
							STAT_INTELLIGENCE = list(-1, 3),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_PISTOL = list(-2, 2),
							SKILL_THROWING = list(-4, 4),
							SKILL_CHEMISTRY = list(-1, 2),
							SKILL_MEDICINE = list(-2, 2),
							SKILL_SURGERY = list(-2, 2),
							SKILL_SCIENCE = list(-2, 2))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 4,
							SKILL_PISTOL = 2,
							SKILL_THROWING = 6,
							SKILL_BRAWLING = 3,
							SKILL_WRESTLING = 3,
							SKILL_CHEMISTRY = 7,
							SKILL_MEDICINE = 12,
							SKILL_SURGERY = 12,
							SKILL_SCIENCE = 4)

//Head of personnel
/datum/attribute_holder/sheet/job/gatekeeper
	attribute_variance = list(STAT_STRENGTH = list(-1, 2),
							STAT_ENDURANCE = list(-1, 2),
							STAT_DEXTERITY = list(-1, 2),
							STAT_INTELLIGENCE = list(-1, 2),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_BRAWLING = list(-1, 2),
							SKILL_WRESTLING = list(-1, 2),
							SKILL_SMG = list(-2, 2),
							SKILL_PISTOL = list(-1, 3),
							SKILL_RAPIER = list(-1, 2),
							SKILL_SHORTSWORD = list(-2, 2),
							SKILL_THROWING = list(-2, 2),
							SKILL_PICKPOCKET = list(-2, 2),
							SKILL_LOCKPICKING = list(-2, 2),
							SKILL_SCIENCE = list(-4, 2),
							SKILL_ACROBATICS = list(-2, 4))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 8,
							SKILL_SMG = 10,
							SKILL_PISTOL = 12,
							SKILL_RAPIER = 10,
							SKILL_BRAWLING = 5,
							SKILL_WRESTLING = 6,
							SKILL_SHORTSWORD = 10,
							SKILL_THROWING = 2,
							SKILL_PICKPOCKET = 8,
							SKILL_LOCKPICKING = 8,
							SKILL_SCIENCE = 4,
							SKILL_ACROBATICS = 6)

//Head of security
/datum/attribute_holder/sheet/job/coordinator
	attribute_variance = list(STAT_STRENGTH = list(0, 5),
						STAT_ENDURANCE = list(0, 5),
						STAT_DEXTERITY = list(-2, 3),
						STAT_INTELLIGENCE = list(-2, -1),
						SKILL_IMPACT_WEAPON = list(-2, 2),
						SKILL_BRAWLING = list(-1, 2),
						SKILL_WRESTLING = list(-1, 2),
						SKILL_SHOTGUN = list(-1, 2),
						SKILL_PISTOL = list(-2, 2),
						SKILL_RIFLE = list(-2, 2),
						SKILL_SMG = list(-1, 2),
						SKILL_LAW = list(-1, 1),
						SKILL_SHORTSWORD = list(-2, 2),
						SKILL_RAPIER = list(-2, 2),
						SKILL_LONGSWORD = list(-1, 2),
						SKILL_FORCESWORD = list(-2, 2),
						SKILL_IMPACT_WEAPON_TWOHANDED = list(-1, 3),
						SKILL_SWORD_TWOHANDED = list(-1, 1),
						SKILL_THROWING = list(-2, 4),
						SKILL_FORENSICS = list(-2, 4),
						SKILL_ACROBATICS = list(-2, 2))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 17,
							SKILL_BRAWLING = 10,
							SKILL_WRESTLING = 10,
							SKILL_SHOTGUN = 13,
							SKILL_RIFLE = 14,
							SKILL_PISTOL = 14,
							SKILL_SMG = 16,
							SKILL_LAW = 10,
							SKILL_SHORTSWORD = 11,
							SKILL_RAPIER = 10,
							SKILL_LONGSWORD = 13,
							SKILL_FORCESWORD = 8,
							SKILL_IMPACT_WEAPON_TWOHANDED = 12,
							SKILL_SWORD_TWOHANDED = 13,
							SKILL_THROWING = 12,
							SKILL_FORENSICS = 12,
							SKILL_ACROBATICS = 8)

//Janitor
/datum/attribute_holder/sheet/job/janitor
	attribute_variance = list(STAT_STRENGTH = list(-1, 2),
						STAT_ENDURANCE = list(-1, 3),
						STAT_DEXTERITY = list(-2, 1),
						STAT_INTELLIGENCE = list(-3, 2),
						SKILL_CLEANING = list(-2, 2),
						SKILL_MASONRY = list(-4, 2),
						SKILL_IMPACT_WEAPON = list(-2, 3),
						SKILL_BRAWLING = list(-1, 3),
						SKILL_WRESTLING = list(-1, 3),
						SKILL_POLEARM = list(-2, 2),
						SKILL_THROWING = list(-2, 2))
	raw_attribute_list = list(SKILL_CLEANING = 18,
							SKILL_MASONRY = 6,
							SKILL_IMPACT_WEAPON = 8,
							SKILL_BRAWLING = 5,
							SKILL_WRESTLING = 5,
							SKILL_POLEARM = 7,
							SKILL_THROWING = 6,
							SKILL_ACROBATICS = 6)

//Paramedic
/datum/attribute_holder/sheet/job/paramedic
	attribute_variance = list(STAT_STRENGTH = list(-1, 3),
							STAT_ENDURANCE = list(-1, 3),
							STAT_DEXTERITY = list(-2, 1),
							STAT_INTELLIGENCE = list(-2, 1),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_BRAWLING = list(-1, 1),
							SKILL_WRESTLING = list(-1, 1),
							SKILL_PISTOL = list(-2, 2),
							SKILL_THROWING = list(-2, 2),
							SKILL_CHEMISTRY = list(-4, 4),
							SKILL_MEDICINE = list(-3, 3),
							SKILL_SURGERY = list(-2, 2))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 9,
							SKILL_PISTOL = 8,
							SKILL_BRAWLING = 5,
							SKILL_WRESTLING = 5,
							SKILL_THROWING = 6,
							SKILL_CHEMISTRY = 6,
							SKILL_MEDICINE = 13,
							SKILL_SURGERY = 8)

//Quartermaster
/datum/attribute_holder/sheet/job/merchant
	attribute_variance = list(STAT_STRENGTH = list(-2, 1),
							STAT_ENDURANCE = list(-2, 1),
							STAT_DEXTERITY = list(-1, 3),
							STAT_INTELLIGENCE = list(-1, 3),
							SKILL_IMPACT_WEAPON = list(-4, 4),
							SKILL_WRESTLING = list(-3, 3),
							SKILL_BRAWLING = list(-4, 4),
							SKILL_SMG = list(-3, 3),
							SKILL_PISTOL = list(-1, 2),
							SKILL_THROWING = list(-4, 2),
							SKILL_CLEANING = list(-6, 2),
							SKILL_PICKPOCKET = list(-2, 2),
							SKILL_LOCKPICKING = list(-2, 2))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 8,
							SKILL_SMG = 10,
							SKILL_PISTOL = 14,
							SKILL_BRAWLING = 6,
							SKILL_WRESTLING = 7,
							SKILL_THROWING = 4,
							SKILL_CLEANING = 8,
							SKILL_PICKPOCKET = 8,
							SKILL_LOCKPICKING = 10)

//Research Director
/datum/attribute_holder/sheet/job/technocrat
	attribute_variance = list(STAT_STRENGTH = list(-2, 1),
							STAT_ENDURANCE = list(-2, 1),
							STAT_DEXTERITY = list(1, 3),
							STAT_INTELLIGENCE = list(1, 5),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_BRAWLING = list(-2, 4),
							SKILL_WRESTLING = list(-1, 2),
							SKILL_PISTOL = list(-2, 2),
							SKILL_RAPIER = list(-2, 2),
							SKILL_KNIFE = list(-2, 2),
							SKILL_LAW = list(-2, 3),
							SKILL_THROWING = list(-2, 2),
							SKILL_CHEMISTRY = list(-2, 4),
							SKILL_MEDICINE = list(-2, 4),
							SKILL_SURGERY = list(-2, 2),
							SKILL_SCIENCE = list(-2, 4),
							SKILL_ACROBATICS = list(-4, 4),
							SKILL_ELECTRONICS = list(-4, 4))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 6,
							SKILL_PISTOL = 12,
							SKILL_LAW = 13,
							SKILL_BRAWLING = 6,
							SKILL_WRESTLING = 7,
							SKILL_RAPIER = 11,
							SKILL_KNIFE, 10,
							SKILL_THROWING = 6,
							SKILL_CHEMISTRY = 10,
							SKILL_MEDICINE = 6,
							SKILL_SURGERY = 6,
							SKILL_SCIENCE = 16,
							SKILL_ELECTRONICS = 14,
							SKILL_ACROBATICS = 10)
//Technomancer
/datum/attribute_holder/sheet/job/technologist
	attribute_variance = list(STAT_STRENGTH = list(-2, 1),
							STAT_ENDURANCE = list(-2, 1),
							STAT_DEXTERITY = list(0, 2),
							STAT_INTELLIGENCE = list(0, 2),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_WRESTLING = list(-1, 1),
							SKILL_BRAWLING = list(-1, 2),
							SKILL_PISTOL = list(-2, 2),
							SKILL_KNIFE = list(0, 2),
							SKILL_THROWING = list(-2, 2),
							SKILL_CHEMISTRY = list(-2, 4),
							SKILL_MEDICINE = list(-2, 4),
							SKILL_SURGERY = list(-2, 2),
							SKILL_SCIENCE = list(-2, 4),
							SKILL_ACROBATICS = list(-4, 4))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 7,
							SKILL_BRAWLING = 5,
							SKILL_WRESTLING = 5,
							SKILL_PISTOL = 10,
							SKILL_KNIFE = 9,
							SKILL_THROWING = 6,
							SKILL_CHEMISTRY = 12,
							SKILL_MEDICINE = 6,
							SKILL_SURGERY = 6,
							SKILL_SCIENCE = 16,
							SKILL_ACROBATICS = 16)

//Machinist/Roboticist
/datum/attribute_holder/sheet/job/machinist
	attribute_variance = list(STAT_STRENGTH = list(-1, 3),
							STAT_ENDURANCE = list(-1, 3),
							STAT_DEXTERITY = list(-3, 1),
							STAT_INTELLIGENCE = list(-1, 2),
							SKILL_IMPACT_WEAPON = list(-2, 2),
							SKILL_BRAWLING = list(-2, 2),
							SKILL_WRESTLING = list(-2, 2),
							SKILL_SHOTGUN = list(-2, 2),
							SKILL_THROWING = list(-2, 2),
							SKILL_CHEMISTRY = list(-2, 4),
							SKILL_MEDICINE = list(-2, 4),
							SKILL_SURGERY = list(-2, 2),
							SKILL_SCIENCE = list(-2, 4),
							SKILL_ACROBATICS = list(-2, 4),
							SKILL_ELECTRONICS = list(-2, 6))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 11,
							SKILL_BRAWLING = 7,
							SKILL_WRESTLING = 7,
							SKILL_SHOTGUN = 9,
							SKILL_PISTOL = 6,
							SKILL_THROWING = 6,
							SKILL_CHEMISTRY = 2,
							SKILL_MEDICINE = 4,
							SKILL_SURGERY = 10,
							SKILL_SCIENCE = 10,
							SKILL_ACROBATICS = 10,
							SKILL_ELECTRONICS = 12)

//Security officer
/datum/attribute_holder/sheet/job/ordinator
	attribute_variance = list(STAT_STRENGTH = list(0, 3),
						STAT_ENDURANCE = list(0, 3),
						STAT_DEXTERITY = list(-2, 2),
						STAT_INTELLIGENCE = list(-3, 0),
						SKILL_IMPACT_WEAPON = list(-1, 2),
						SKILL_BRAWLING = list(-1, 2),
						SKILL_WRESTLING = list(-1, 2),
						SKILL_SMG = list(-2, 2),
						SKILL_PISTOL = list(-2, 1),
						SKILL_RIFLE = list(-4, 2),
						SKILL_SHOTGUN = list(-3, 3),
						SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
						SKILL_LONGSWORD = list(-2, 2),
						SKILL_SHORTSWORD = list(-2, 2),
						SKILL_FORCESWORD = list(-4, 3),
						SKILL_THROWING = list(-4, 2),
						SKILL_FORENSICS = list(-2, 2),
						SKILL_ACROBATICS = list(-2, 2))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 13,
							SKILL_BRAWLING = 8,
							SKILL_WRESTLING = 8,
							SKILL_SMG = 13,
							SKILL_PISTOL = 12,
							SKILL_SHOTGUN = 13,
							SKILL_RIFLE = 12,
							SKILL_IMPACT_WEAPON_TWOHANDED = 10,
							SKILL_LONGSWORD = 11,
							SKILL_SHORTSWORD = 10,
							SKILL_FORCESWORD = 2,
							SKILL_THROWING = 12,
							SKILL_MEDICINE = 16,
							SKILL_SURGERY = 16,
							SKILL_FORENSICS = 8,
							SKILL_ACROBATICS = 4)

//Miner
/datum/attribute_holder/sheet/job/miner
	attribute_variance = list(STAT_STRENGTH = list(-1, 3),
						STAT_ENDURANCE = list(-1, 3),
						STAT_DEXTERITY = list(-2, 2),
						STAT_INTELLIGENCE = list(-3, 0),
						SKILL_IMPACT_WEAPON = list(-2, 2),
						SKILL_BRAWLING = list(-1, 1),
						SKILL_WRESTLING = list(-1, 1),
						SKILL_KNIFE = list(-1, 2),
						SKILL_PISTOL = list(-2, 2),
						SKILL_RIFLE = list(-4, 2),
						SKILL_SHOTGUN = list(-2, 2),
						SKILL_THROWING = list(-4, 3),
						SKILL_FORENSICS = list(-2, 2),
						SKILL_ACROBATICS = list(-2, 4))
	raw_attribute_list = list(SKILL_IMPACT_WEAPON = 14,
							SKILL_BRAWLING = 7,
							SKILL_WRESTLING = 7,
							SKILL_PISTOL = 14,
							SKILL_RIFLE = 13,
							SKILL_SHOTGUN = 12,
							SKILL_KNIFE = 10,
							SKILL_THROWING = 12,
							SKILL_FORENSICS = 2,
							SKILL_ACROBATICS = 10)
