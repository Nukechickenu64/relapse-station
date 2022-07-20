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
	H.mind.add_antag_datum(/datum/antagonist/denominator)
	H.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator)
	var/datum/component/babble/babble = H.GetComponent(/datum/component/babble)
	if(!babble)
		H.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/denom.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/denom.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION


/obj/effect/mob_spawn/human/denominator/special(mob/living/new_spawn)
	. = ..()
	new_spawn.hairstyle = "Bald"
	new_spawn.facial_hairstyle = "Shaved"
	new_spawn.skin_tone = "albino"
