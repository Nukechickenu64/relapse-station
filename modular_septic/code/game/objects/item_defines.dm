/obj/item
	drop_sound = 'modular_septic/sound/items/drop.wav'

	/// Armour penetration that oly applies to subtractible armor
	var/subtractible_armour_penetration = 0
	/// Whether or not our object is easily hindered by the presence of subtractible armor
	var/weak_against_subtractible_armour = FALSE

	/// How much time we (normally) take to recover from attacking with this
	var/attack_delay = CLICK_CD_MELEE
	/// How much fatigue we (normally) take away from the user when attacking with this - If null, we assume a standard value
	var/attack_fatigue_cost = null

	/// Organ storage component requires this
	var/atom/stored_in
	/// Stat used in melee combat
	var/stat_melee = null
	/// Skill used in melee combat
	var/skill_melee = SKILL_MELEE
	/// Stat used in ranged combat
	var/stat_ranged = null
	/// Skill used in  ranged combat
	var/skill_ranged = SKILL_RANGED
	/// Used for unturning when picked up by a mob
	var/our_angle = 0

	//Mutant icon garbage
	var/worn_icon_muzzled = 'modular_septic/icons/mob/clothing/head_muzzled.dmi'
	var/worn_icon_digi = 'modular_septic/icons/mob/clothing/suit_digi.dmi'
	var/worn_icon_taur_snake = 'modular_septic/icons/mob/clothing/suit_taur_snake.dmi'
	var/worn_icon_taur_paw = 'modular_septic/icons/mob/clothing/suit_taur_paw.dmi'
	var/worn_icon_taur_hoof = 'modular_septic/icons/mob/clothing/suit_taur_hoof.dmi'
	var/mutant_variants = NONE

	//Only mattters when worn on the head
	var/fov_angle = 0
	var/fov_shadow_angle = ""

	//This is used to calculate encumbrance on human mobs
	var/carry_weight
