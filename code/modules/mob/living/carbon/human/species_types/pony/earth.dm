/datum/species/pony
	// Animated beings of stone. They have increased defenses, and do not need to breathe. They're also slow as fuuuck.
	name = "Golem"
	id = SPECIES_GOLEM
	species_traits = list(NOBLOOD,NOTRANSSTING, MUTCOLORS,NO_UNDERWEAR, NO_DNA_COPY)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_NOFIRE,
		TRAIT_CHUNKYFINGERS,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_NODISMEMBER,
	)
	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	mutant_organs = list(/obj/item/organ/heart)
	speedmod = 2
	payday_modifier = 0.75
	armor = 0
	siemens_coeff = 1
	punchdamagelow = 5
	punchdamagehigh = 14
	punchstunthreshold = 11 //about 40% chance to stun
	no_equip = list(ITEM_SLOT_MASK, ITEM_SLOT_OCLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_FEET, ITEM_SLOT_ICLOTHING, ITEM_SLOT_SUITSTORE)
	nojumpsuit = 1
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	sexes = 1
	damage_overlay_type = ""
	meat = /obj/item/food/meat/slab/human/mutant/golem
	species_language_holder = /datum/language_holder/golem
	// To prevent golem subtypes from overwhelming the odds when random species
	// changes, only the Random Golem type can be chosen
	limbs_id = "golem"
	fixed_mut_color = "#aaaaaa"
