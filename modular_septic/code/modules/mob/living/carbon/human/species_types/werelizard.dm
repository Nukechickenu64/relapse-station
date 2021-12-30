/datum/species/lizard
	name = "Iglaak"
	limbs_icon = 'modular_septic/icons/mob/human/species/lizard/lizard_parts_greyscale.dmi'
	limbs_id = "lizard"
	default_color = "D8FFCE"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list()
	mutant_organs = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"spines" = ACC_RANDOM,
		"frills" = ACC_RANDOM,
		"horns" = ACC_RANDOM,
		"wings" = "None",
	)
	examine_icon_state = "werelizard"
	say_mod = "hisses"
	default_genitals = list(ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis/hemi,
							ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles/internal,
							ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
							ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
							ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
							)
