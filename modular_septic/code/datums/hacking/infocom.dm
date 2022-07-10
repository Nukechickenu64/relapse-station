/datum/hacking/infocom
	holder_type = /obj/machinery/infocom
	proper_name = "Information Communication"
	hacking_actions = "malicious"

/datum/hacking/infocom/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Virus" = .proc/virus,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/infocom/destroy_holder(mob/living/hackerman)
	var/obj/machinery/infocom/infocom = holder
	//We have to return immediately
	INVOKE_ASYNC(src, .proc/infocom_destruction)

/datum/hacking/infocom/proc/infocom_destruction(mob/living/hackerman)
	var/obj/machinery/infocom/infocom = holder
	sleep(1 SECONDS)
	do_sparks(1, FALSE, secure_closet)
	sleep(0.6 SECONDS)
	do_sparks(2, FALSE, secure_closet)
	secure_closet.deconstruct(FALSE)

/datum/hacking/infocom/proc/virus(atom/hackerman)
	var/obj/machinery/infocom/infocom = holder
	if(infocom.virused)
		return
	else
		to_chat(user, span_warning("I've infected [src] with painware."))
		do_sparks(1, FALSE, secure_closet)
		infocom.virused = TRUE
		infocom.radiotune = list('modular_septic/sound/efn/hackedcom1.ogg', 'modular_septic/sound/efn/hackedcom2.ogg', 'modular_septic/sound/efn/hackedcom3.ogg')
		infocom.voice_lines = list("WHY AR%$# Y%$#U HE%$#E$#*", "YOU BBL%$%#ACK", "YOU N%$##R", "YOU D#$%@ERVE% NOTHING BUT H%$#TE", "I WI%$#LL COME TO YOU RHO%$%#USE AND K%$ILL YOU")
		INVOKE_ASYNC(src, .proc/start_spitting_fax)

