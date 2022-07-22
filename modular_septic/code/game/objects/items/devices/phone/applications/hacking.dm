/datum/simcard_application/hacking
	name = "FLESHWORM.gak"
	var/cock_type
	var/datum/weakref/hacker
	var/infection_type = /datum/simcard_virus/memz
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
	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(parent.parent, random_press_sound, 65, FALSE)
	to_chat(user, span_notice("[icon2html(parent, user)] <b>BINARY INTEGRITY:</b> [CEILING((parent.firewall_health/max(1, parent.firewall_maxhealth)) * 100, 0.1)]%\n\
								MY CALL VIRUS IS [infective ? "ENABLED" : "DISABLED"]"))
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
	var/antivirus_option = "Toggle [antivirus_chosen] Antivirus"
	var/virus_option = "Toggle \"[initial(punjabi_virus.name)]\" Infection"
	var/list/options = list("Denial of Service", virus_option, antivirus_option)
	var/input = tgui_input_list(user, "What do you want to do today, hacker?", "FLESHWORM", options)
	if(input == "Denial of Service")
		ddos_niggas(user)
	else if(input == virus_option)
		toggle_infectivity(user)
	else if(input == antivirus_option)
		toggle_firewall(user, antivirus_chosen)
	else
		to_chat(user, span_warning("Nevermind."))

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
	playsound(parent.parent, 'modular_septic/sound/efn/phone_subtlealert.ogg', 65, FALSE)

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
