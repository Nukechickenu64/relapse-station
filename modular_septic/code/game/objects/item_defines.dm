/obj/item
	drop_sound = 'modular_septic/sound/items/drop.wav'

	// Mutant icon garbage
	var/worn_icon_muzzled = 'modular_septic/icons/mob/clothing/head_muzzled.dmi'
	var/worn_icon_digi = 'modular_septic/icons/mob/clothing/suit_digi.dmi'
	var/worn_icon_taur_snake = 'modular_septic/icons/mob/clothing/suit_taur_snake.dmi'
	var/worn_icon_taur_paw = 'modular_septic/icons/mob/clothing/suit_taur_paw.dmi'
	var/worn_icon_taur_hoof = 'modular_septic/icons/mob/clothing/suit_taur_hoof.dmi'
	var/mutant_variants = NONE

	// Only mattters when worn on the head
	var/fov_angle = 0
	var/fov_shadow_angle = ""

	/// Organ storage component requires this
	var/atom/stored_in

	/// Used for unturning when picked up by a mob
	var/our_angle = 0

	/// How much to remove from edge_protection
	var/edge_protection_penetration = 0
	/// Armour penetration that oly applies to subtractible armor
	var/subtractible_armour_penetration = 0
	/// Whether or not our object is easily hindered by the presence of subtractible armor
	var/weak_against_subtractible_armour = FALSE

	/**
	 *  Modifier for block score
	 *
	 * DO NOT SET THIS AS 0 IF YOU DON'T WANT THE ITEM TO ATTEMPT TO BLOCK
	 * SET TO NULL INSTEAD!
	 */
	var/blocking_modifier = null
	/// Flags related to what the fuck we can block
	var/blocking_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	/**
	 *  Modifier for parry score
	 *
	 * DO NOT SET THIS AS 0 IF YOU DON'T WANT THE ITEM TO ATTEMPT TO PARRY
	 * SET TO NULL INSTEAD!
	 */
	var/parrying_modifier = null
	/// Flags related to what the fuck we can parry
	var/parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN

	/**
	 * How much fatigue we (normally) take away from the user when attacking with this.
	 *
	 * LEAVING THIS AS NULL WILL CALCULATE A NEW attack_fatigue_cost BASED ON W_CLASS ON INITIALIZE()
	 */
	var/attack_fatigue_cost = null

	/// How much time we (normally) take to recover from attacking with this
	var/attack_delay = CLICK_CD_MELEE

	/// Skill used in melee combat
	var/skill_melee = SKILL_IMPACT_WEAPON
	/// Skill used in ranged combat
	var/skill_ranged = SKILL_RIFLE
	/**
	 * Skill used for blocking
	 *
	 * LEAVING THIS AS NULL WILL MAKE THIS EQUAL TO SKILL_MELEE
	 */
	var/skill_blocking = null
	/**
	 * Skill used for parrying
	 *
	 * LEAVING THIS AS NULL WILL MAKE THIS EQUAL TO SKILL_MELEE
	 */
	var/skill_parrying = null

	/**
	 * This is used to calculate encumbrance on human mobs.
	 *
	 * LEAVING THIS AS NULL WILL CALCULATE A NEW CARRY_WEIGHT BASED ON W_CLASS ON INITIALIZE()
	 */
	var/carry_weight = null

	/**
	 * The minimum Strength required to use the weapon properly.
	 * If you try to use a weapon that requires more ST than you have,
	 * you will be at -1 to weapon skill per point of ST you lack.
	 */
	var/minimum_strength = 10
	/**
	 * Maximum strength amount for the purposes of damage calculations
	 */
	var/maximum_strength = ATTRIBUTE_MAX
	/// Several flags related to readying behavior
	var/readying_flags = NONE
