/**
 * IMPACT WEAPONS
 *
 * An impact weapon is any rigid, unbalanced weapon with most of its mass concentrated in the head
 */
/datum/attribute/skill/impact_weapon
	name = "Impact Weapon"
	desc = "Any short to medium-length one-handed impact weapon, such as an axe, hatchet, pickaxe, mace or knobbed club."
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FLAIL = -4,
		SKILL_IMPACT_WEAPON_TWOHANDED = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/impact_weapon_twohanded
	name = "Two-Handed Impact Weapon"
	desc = "Any long, two-handed impact weapon, such as a baseball bat, battleaxe, maul, or warhammer"
	category = SKILL_CATEGORY_MELEE
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_POLEARM = -4,
		SKILL_FLAIL_TWOHANDED = -4,
		SKILL_IMPACT_WEAPON = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
