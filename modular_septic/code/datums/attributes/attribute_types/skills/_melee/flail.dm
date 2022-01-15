/**
 * FLAIL WEAPONS
 *
 * A flail is any flexible, unbalanced weapon with its mass concentrated in the head.
 */
/datum/attribute/skill/flail
	name = "Flail"
	desc = "Any one-handed flail, such as a morningstar or nunchaku."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -6,
		SKILL_IMPACT_WEAPON = -4,
		SKILL_FLAIL_TWOHANDED = -3,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/flail_twohanded
	name = "Two-Handed Flail"
	desc = "Any two-handed flail."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -6,
		SKILL_IMPACT_WEAPON = -4,
		SKILL_IMPACT_WEAPON_TWOHANDED = -4,
		SKILL_FLAIL = -3,
	)
	difficulty = SKILL_DIFFICULTY_HARD
