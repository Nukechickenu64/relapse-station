/datum/hacking/vending
	holder_type = /obj/machinery/vending
	proper_name = "Vending Machine"
	hacking_actions = "vending"
	var/obvious = TRUE
	var/loud_sound = 'modular_septic/sound/effects/obvious.wav'

/datum/hacking/vending/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Virus" = .proc/infection,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/vending/proc/infection(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	if(!vending.infected)
		vending.infected = TRUE
		vending.slogan_delay = 150
		do_sparks(2, FALSE, vending)
		to_chat(hackerman, span_warning("I have infected the operating system with \"" + \
			span_green("P") + span_yellow("A") + span_green("I") + span_white("N") + " " + \
			span_yellow("W") + span_white("A") + span_yellow("R") + span_yellow("E") + \
			"\"!"))

/datum/hacking/vending/destroy_holder(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	if(obvious)
		playsound(vending, loud_sound, 60, FALSE)
		do_sparks(1, FALSE, vending)

	vending_destruct(vending)

/datum/hacking/vending/proc/vending_destruct(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	sleep(1 SECONDS)
	do_sparks(1, FALSE, vending)
	sleep(6)
	do_sparks(2, FALSE, vending)
	vending.deconstruct(FALSE)
