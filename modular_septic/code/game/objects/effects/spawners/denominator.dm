/obj/effect/mob_spawn/human/denominator
	name = "denominator's spawner"
	desc = "A nice comfy bed."
	random = TRUE
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "bed"
	mob_name = "an intruder, remember to work with your team-mates, they're your only friends, will you escape together"
	outfit = /datum/outfit/denominator
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE
	short_desc = "You are a Denominator."
	flavour_text = "Being one of the Denominators you are a cult sect based on transparacy with the goal to reveal all of the mysteries about this warehouse, and recover some profit in the process, your services aren't free, after all."
	spawner_job_path = /datum/job/denominator
	uses = 2
	var/spawn_oldpod = TRUE

/obj/effect/mob_spawn/human/denominator/Destroy()
	if(spawn_oldpod)
		new /obj/structure/bed/pod(drop_location())
	return ..()

/obj/effect/mob_spawn/human/denominator/equip(mob/living/carbon/human/H)
	. = ..()
	H.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator)
	var/datum/component/babble/babble = H.GetComponent(/datum/component/babble)
	if(!babble)
		H.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/denom.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/denom.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

/datum/job/denominator
	title = ROLE_DENOMINATOR

/datum/outfit/denominator
	name = "Denominator uniform"

	uniform = /obj/item/clothing/under/denomination
	suit = /obj/item/clothing/suit/armor/denominator
	backpack_contents = list(
		/obj/item/keycard/red = 1,
		)
	r_pocket = /obj/item/ammo_box/magazine/ammo_stack/shotgun/buckshot/loaded
	l_pocket = /obj/item/sim_card
	id = /obj/item/cellular_phone
	suit_store = /obj/item/gun/ballistic/shotgun/denominator
	head = /obj/item/clothing/head/denominator
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

	back = /obj/item/storage/backpack/satchel/itobe
