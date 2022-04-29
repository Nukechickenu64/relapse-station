/obj/effect/mob_spawn/human/denominator
	name = "denominator's spawner"
	desc = "A nice comfy bed."
	random = TRUE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"
	mob_name = "an intruder, remember to work with your team-mates, they're your only friends, will you escape together"
	outfit = /datum/outfit/job/denominator
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	short_desc = "You are a Denominator."
	flavour_text = "Being one of the Denominators you are a cult sect based on transparacy with the goal to reveal all of the mysteries about this warehouse, and recover some profit in the process, your services aren't free, after all."
	spawner_job_path = /datum/job/denominator
	var/rank = "Cultist"
	var/spawn_oldpod = TRUE

/obj/effect/mob_spawn/human/denominator/Destroy()
	if(spawn_oldpod)
		new /obj/structure/bed/pod(drop_location())
	return ..()

/datum/job/denominator
	title = ROLE_DENOMINATOR

/datum/outfit/job/denominator
	name = "Denominator uniform"

	uniform = /obj/item/clothing/under/denomination
	suit = /obj/item/clothing/suit/armor/vest/alt/heavy
	backpack_contents = list(
		/obj/item/keycard/red = 1,
		/obj/item/storage/box/lethalshot = 1,
		)
	suit_store = /obj/item/gun/ballistic/shotgun/ithaca/lethal
	mask = /obj/item/clothing/mask/denominator
	belt = /obj/item/storage/belt/military
	ears = /obj/item/radio/headset
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

	back = /obj/item/storage/backpack/satchel/itobe

/obj/effect/mob_spawn/human/denominator/equip(mob/living/carbon/human/H)
	. = ..()
	H.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator)
