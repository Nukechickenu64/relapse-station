/**
 * FENCING WEAPONS
 *
 * Fencing weapons are light, onehanded weapons, usually hilted blades, optimized for parrying.
 */
/datum/attribute/skill/rapier
	name = "Rapier"
	desc = "Any long (over 1 meter), light thrusting sword."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_BROADSWORD = -4,
		SKILL_SABER = -3,
		SKILL_SMALLSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/saber
	name = "Saber"
	desc = "Any light cut-and-thrust sword."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_BROADSWORD = -4,
		SKILL_SHORTSWORD = -4,
		SKILL_RAPIER = -3,
		SKILL_SMALLSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/smallsword
	name = "Smallsword"
	desc = "Any short (up to 1 meter), light thrusting sword or one-handed short staff."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_BROADSWORD = -4,
		SKILL_SHORTSWORD = -4,
		SKILL_RAPIER = -3,
		SKILL_SABER = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
