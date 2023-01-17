/obj/effect/mob_spawn/human/inborn
	name = "inborn's spawner"
	desc = "wow this is fantastic!"
	random = TRUE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"
	mob_name = "a manifestation of love"
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	outfit = /datum/outfit/inborn
	spawner_job_path = /datum/job/inborn
	mob_species = /datum/species/inborn
	uses = 2

/obj/effect/mob_spawn/human/inborn/equip(mob/living/carbon/human/H)
	. = ..()
	H.apply_status_effect(/datum/status_effect/thug_shaker)

/obj/effect/mob_spawn/human/inborn/special(mob/living/new_spawn)
	. = ..()
	new_spawn.fully_replace_character_name(new_spawn.real_name, "Inborn")
	new_spawn.mind.add_antag_datum(/datum/antagonist/inborn)
	new_spawn.attributes.add_sheet(/datum/attribute_holder/sheet/job/inborn)

/datum/outfit/inborn
	name = "Inborn uniform"

	uniform = /obj/item/clothing/under/stray
	r_pocket = /obj/item/keycard/inborn
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
	r_hand = /obj/item/changeable_attacks/sword/kukri
