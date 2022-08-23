/datum/simcard_application/hacking
	name = "FLESHWORM.gak"
	var/cock_type
	var/unlockable_flags = HACKER_CAN_FIREWALL
	var/level_progress = 0
	var/ability_pool = list("VITAL", "TRACKER", "DDOS", "VIRUS", "MINDJACK")
	var/datum/weakref/hacker
	var/infection_type = /datum/simcard_virus/memz
	var/ping_range = 7
	var/infective = FALSE

/datum/simcard_application/hacking/install(obj/item/simcard/new_parent)
	. = ..()
	// we install a firewall on the parent!
	if(new_parent)
		new_parent.firewall_maxhealth = max(new_parent.firewall_maxhealth, 100)
		new_parent.firewall_health = new_parent.firewall_maxhealth

/datum/simcard_application/hacking/execute(mob/living/user)
	. = ..()
	if(!hacker)
		cock_type = (user.gender != FEMALE ? pick("KNOB", "DICK", "PENIS", "WEINER", "JOHNSON") : pick("FANNY", "CUNNY", "CUNT", "VAGINA", "VEGANA"))
		hacker = WEAKREF(user)
		to_chat(user, span_notice("[icon2html(parent, user)] [cock_type] SCANNED AND SAVED. WELCOME, [user.real_name]."))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_subtlealert.ogg', 65, FALSE)
	else if(hacker != WEAKREF(user))
		to_chat(user, span_danger("[icon2html(parent, user)] INVALID [cock_type] DETECTED. ACCESS DENIED!"))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)
		return
	var/datum/simcard_virus/punjabi_virus = infection_type
	var/static/list/antiviruses = list(
		"Protogen",
		"Norten",
		"McOffee",
		"Magrosoft Defender",
		"Aghast",
		"MalwareFights",
		"Crapersky",
		"ShitDefender",
	)
	var/antivirus_chosen = pick(antiviruses)
	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(parent.parent, random_press_sound, 65, FALSE)
	to_chat(user, div_infobox(span_notice("[icon2html(parent, user)] <b>BINARY INTEGRITY:</b> [CEILING((parent.firewall_health/max(1, parent.firewall_maxhealth)) * 100, 0.1)]%\n\
								[icon2html(parent, user)] MY CALL VIRUS IS [infective ? "ENABLED" : "DISABLED"]\n\
								[icon2html(parent, user)] MY PROGRESS TO A NEW ABILITY IS [level_progress]/100\n\
								[icon2html(parent, user)] MY [uppertext(antivirus_chosen)] IS [parent.virus_immunity ? "ENABLED" : "DISABLED"]")))
	var/antivirus_option = "Toggle [antivirus_chosen] Antivirus"
	var/virus_option = "Toggle \"[initial(punjabi_virus.name)]\" Infection"
	var/vital_option = "Ping"
	var/list/options = list()
	if(unlockable_flags & HACKER_CAN_FIREWALL)
		options += antivirus_option
	if(unlockable_flags & HACKER_CAN_VIRUS)
		options += virus_option
	if(unlockable_flags & HACKER_CAN_VITAL)
		options += vital_option
	var/input = tgui_input_list(user, "What do you want to do today, hacker?", "FLESHWORM", options)
	if(input == virus_option)
		toggle_infectivity(user)
	if(input == antivirus_option)
		toggle_firewall(user, antivirus_chosen)
	if(input == vital_option)
		ping(user)

/datum/simcard_application/hacking/proc/ddos_niggas(mob/living/user)
	var/input = tgui_input_list(user, "Who needs a lesson in humility?", "DDoS NIGGAS", GLOB.active_public_simcard_list)
	if(!input)
		to_chat(user, span_warning("Nevermind."))
		return
	var/obj/item/simcard/friend = GLOB.active_public_simcard_list[input]
	if(!friend?.parent)
		to_chat(user, span_warning("[xbox_rage_msg()] INVALID TARGET!!! FUCK YOU!!!"))
		return
	if(friend.parent.phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[icon2html(friend, user)] TARGET IS ALREADY GLITCHED."))
		return
	friend.parent.start_glitching()
	to_chat(user, span_notice("[icon2html(friend, user)] SUCCESSFUL DOS ATTACK."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/toggle_infectivity(mob/living/user, antivirus)
	infective = !infective
	to_chat(user, span_danger("[icon2html(parent, user)] INFECTIVITY TOGGLED [infective ? "ON" : "OFF"]."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/toggle_firewall(mob/living/user, antivirus)
	parent.virus_immunity = !parent.virus_immunity
	if(parent.virus_immunity)
		to_chat(user, span_notice("[uppertext(antivirus)] ANTIVIRUS ENABLED."))
	else
		to_chat(user, span_warning("[uppertext(antivirus)] ANTIVIRUS DISABLED."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/ping(mob/living/user)
	if(!user || !parent)
		return
	playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
	to_chat(user, span_notice("Pinged all users in radius of <b>7</b>."))
	var/list/near_phones
	for(var/obj/item/simcard/simcard in GLOB.simcard_list_by_username)
		var/turf/pinged_turf
		var/list/pinged_phone
		var/turf/hacker_turf = get_turf(parent)
		if(simcard?.parent && simcard.username)
			continue
		pinged_turf = get_turf(simcard)
		pinged_phone[simcard.username] = simcard
		if(pinged_turf?.z == hacker_turf.z && (get_dist(pinged_turf, hacker_turf) <= ping_range))
			pinged_phone |= near_phones
	if(!length(near_phones))
		to_chat(user, span_notice("Clear. There's no users detected in my immediate area."))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_subtlealert.ogg', 25, FALSE)
		return
	to_chat(user, span_notice("Phones detected. I can dial them from here."))
	if(unlockable_flags & (HACKER_CAN_DDOS|HACKER_CAN_MINDJACK))
		to_chat(user, span_boldnotice("I can hack them, too."))
	var/ping_input = tgui_input_list(user, "Immediate Users", "Some guys really shouldn't have phones.", near_phones)
	if(near_phones[ping_input])
		var/obj/item/simcard/victim_card = near_phones[ping_input]
		if(!victim_card.parent)
			to_chat(user, span_notice("The simcard became inactive..."))
			return
		if(unlockable_flags & (HACKER_CAN_DDOS|HACKER_CAN_MINDJACK))
			var/list/hacker_options = list("Call without being Malicious")
			hacker_options += hacking_additions()
			var/hacker_input = tgui_input_list(user, "SPECIAL ACTIONS", "GET READY FOR THIS ONE, GAKSTERS!", hacker_options)
			switch(hacker_input)
				if("DDOS")
					ping_hacking_abilities(user, victim_card = victim_card, option = "DDOS")
				if("MINDJACK")
					ping_hacking_abilities(user, victim_card = victim_card, option = "MINDJACK")
				if("Call without being Malicious")
					parent.parent.start_calling(victim_card.parent)
					return
		else
			parent.parent.start_calling(victim_card.parent)
	else if(ping_input)
		to_chat(user, span_warning("That's not a real phone, I can't just do that, how did I do that?"))

/datum/simcard_application/hacking/proc/ping_hacking_abilities(mob/living/user, obj/item/simcard/victim_card, option)
	if(!option || !parent?.parent || !victim_card?.parent)
		return
	switch(option)
		if("DDOS")
			if(!victim_card?.parent)
				to_chat(user, span_warning("INVALID TARGET!"))
				return
			if(victim_card.parent.phone_flags & PHONE_GLITCHING)
				to_chat(user, span_warning("This phone is already under attack."))
				return
			victim_card?.parent.start_glitching()
			to_chat(user, span_boldnotice("Successful Denial-of-Service Attack."))
			playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
		if("MINDJACK")
			parent.parent.start_calling(victim_card.parent, mindjack = TRUE)

/datum/simcard_application/hacking/proc/ability_description(selected_ability)
	if(!selected_ability)
		return
	var/ability_text = "ERROR!"
	switch(selected_ability)
		if("vitality tracker")
			ability_text = "You have the ability to see If a phone has a user, as well as If that user is living or deceased."
		if("phone tracker")
			ability_text = "You have the ability to \"ping\" other phones through a P2P system, shows you If any active sim cards are in your vicinity."
		if("denial_of_service")
			ability_text = "You have the ability to temporarily stall phones who are foolishly located on the public board."
		if("MEMZ")
			ability_text = "You have the ability to toggle MEMZ invectivity, \
							which infects any user that comes onto a paired connection with you with a \
							destructive virus that has a possibility to explode their phone fatally."
		if("EARFUCK")
			ability_text = "You have the ability to call others using the call menu with a special nural link, \
							connects you to the user's brain and you assume their conciousness in place with yours, keeping them hostage with your own mind. \
							If any of the paired minds die, everyone connected will suffer a very high probability of a fatal anyurism."
	return ability_text

/datum/simcard_application/hacking/proc/hacking_additions(list/hacker_abilities = list())
	if(unlockable_flags & HACKER_CAN_DDOS)
		hacker_abilities |= "DDOS"
	if(unlockable_flags & HACKER_CAN_MINDJACK)
		hacker_abilities |= "MINDJACK"
	if(hacker_abilities)
		return hacker_abilities

/datum/simcard_application/hacking/proc/check_level_up(mob/living/user, ability, silent = FALSE)
	if(!length(ability_pool))
		to_chat(user, span_notice("I have unlocked everything."))
		return
	if(!level_progress >= 100)
		if(!silent)
			var/funnymessage = "\nKeep it up, champ!"
			var/progressmessage = "LEVEL PROGRESS [level_progress]/100."
			if(prob(1))
				progressmessage = "LEL PROGRESS [level_progress]/100."
			if(prob(5))
				progressmessage += funnymessage
			to_chat(user, div_infobox(span_warning("[progressmessage]")))
			playsound(parent.parent, list('modular_septic/sound/efn/progress_check1.ogg', 'modular_septic/sound/efn/progress_check2.ogg', 'modular_septic/sound/efn/progress_check3.ogg'), 40, FALSE)
		return
	var/selected_ability = pick(ability_pool)
	if(ability)
		selected_ability = ability
	switch(selected_ability)
		if("VITAL")
			unlockable_flags |= HACKER_CAN_VITAL
			selected_ability = "vitality tracker"
			if("VITAL" in ability_pool)
				ability_pool -= "VITAL"
		if("TRACKER")
			unlockable_flags |= HACKER_CAN_TRACKER
			selected_ability = "phone tracker"
			if("TRACKER" in ability_pool)
				ability_pool -= "TRACKER"
		if("DDOS")
			unlockable_flags |= HACKER_CAN_DDOS
			selected_ability = "denial-of-service"
			if("DDOS" in ability_pool)
				ability_pool -= "DDOS"
		if("VIRUS")
			unlockable_flags |= HACKER_CAN_VIRUS
			selected_ability = "MEMZ"
			if("VIRUS" in ability_pool)
				ability_pool -= "VIRUS"
		if("MINDJACK")
			unlockable_flags |= HACKER_CAN_MINDJACK
			selected_ability = "EARFUCK"
			if("MINDJACK" in ability_pool)
				ability_pool -= "MINDJACK"
	level_progress = initial(level_progress)
	to_chat(user, span_notice("I've unlocked [selected_ability]!\n"), \
	div_infobox(span_boldwarning("[ability_description(selected_ability)]")))
	playsound(parent.parent, list('modular_septic/sound/efn/hacker_phone_unlock1.ogg', 'modular_septic/sound/efn/hacker_phone_unlock2.ogg'), 40, FALSE)
