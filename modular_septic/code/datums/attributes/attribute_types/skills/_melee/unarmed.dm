/**
 * UNARMED
 *
 */
/datum/attribute/skill/unarmed
	name = "Rapier"
	desc = "Any long (over 1 meter), light, thrusting sword."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -6,
		SKILL_BROADSWORD = -4,
		SKILL_SMALLSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_HARD
