GLOBAL_LIST_EMPTY(child_enterporter)
GLOBAL_LIST_EMPTY(child_exiterporter)
GLOBAL_LIST_EMPTY(denominator_exiterporter)

/obj/structure/gptdfm
	name = "rapid-major-transportation-effect"
	desc = "Rapid teleportation area."
	icon = 'modular_septic/icons/obj/structures/gptdfm.dmi'
	icon_state = "child_transporter"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	var/gurby = list('modular_septic/sound/effects/teleporter/gurby1.wav', 'modular_septic/sound/effects/teleporter/gurby2.wav', 'modular_septic/sound/effects/teleporter/gurby3.wav', 'modular_septic/sound/effects/teleporter/gurby4.wav', 'modular_septic/sound/effects/teleporter/gurby5.wav')
	var/gurby_escape = 'modular_septic/sound/effects/chadjack.wav'
	var/gurby_unescape = 'modular_septic/sound/effects/soyjack.wav'

/obj/structure/gptdfm/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/gptdfm/entrance
	name = "An unEscape from Nevado"
	desc = "GTFIN!"

/obj/structure/gptdfm/entrance/Initialize(mapload)
	. = ..()
	GLOB.child_enterporter += src

/obj/structure/gptdfm/entrance/Destroy()
	. = ..()
	GLOB.child_enterporter -= src

/obj/structure/gptdfm/denominator
	name = "An unEscape from Nevado but for Denominators"
	desc = "GTFIN IDIOT!"

/obj/structure/gptdfm/denominator/Initialize(mapload)
	. = ..()
	GLOB.denominator_exiterporter += src

/obj/structure/gptdfm/denominator/Destroy()
	. = ..()
	GLOB.denominator_exiterporter -= src

/obj/structure/gptdfm/exit
	name = "An Escape from Nevado"
	desc = "GTFO!"

/obj/structure/gptdfm/exit/Initialize(mapload)
	. = ..()
	name = "[pick("Leave","Escape","Depart","Getaway","Flee","Abandon")] from [rand(1,9)][rand(1,9)][rand(1,9)][rand(1,9)][rand(1,9)]"
	GLOB.child_exiterporter += src

/obj/structure/gptdfm/exit/Destroy()
	. = ..()
	GLOB.child_exiterporter -= src

/obj/structure/gptdfm/examine(mob/living/user)
	playsound(user, gurby, 30, FALSE)
	return

/obj/structure/gptdfm/entrance/examine(mob/user)
	. = list()
	. += span_info("Time to Escape from Nevado!")
	. += span_big(span_alert("What..."))

/obj/structure/gptdfm/exit/examine(mob/user)
	. = list()
	. += span_info("Back to the Safezone!")
	. += span_big(span_alert("Hmm..."))

/obj/structure/gptdfm/proc/teleportation(mob/user, obj/structure/gptdfm/specific_location = pick(GLOB.child_exiterporter), leaving_message = "Time for my journey. I'm going to [specific_location.name].")
	to_chat(user, span_notice("[leaving_message]"))
	if(user.pulling)
		var/mob/friend1 = user.pulling
		var/mob/friend2
		var/mob/friend3
		var/list/collective = list(friend1)
		if(user.pulling.pulling)
			friend2 = user.pulling.pulling
			collective += friend2
		if(user.pulling?.pulling?.pulling)
			friend3 = user.pulling?.pulling?.pulling // I'm fucking tired just let me finish this I really fucking suck at math I want to kill myself
			collective += friend3
		mass_teleportation(user, collective, specific_location)
		return
	if(do_after(user, 50, target = user))
		do_teleport(user, specific_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
		playsound(user, gurby_unescape, 80, FALSE)
		user.flash_darkness(100)

/obj/structure/gptdfm/proc/mass_teleportation(mob/leader, list/mob/friends_list, specific_location)
	var/friend_message_composed = "<div class='infobox'>I'm bringing my PARTY along with me:"
	for(var/mob/friend in friends_list)
		to_chat(friend, span_notice("Our party has gathered, [leader] is taking us to [specific_location]..."))
		var/friend_name = friends_list[friend]
		friend_message_composed += "\n[friend_name]"
	friend_message_composed += "</div>"
	to_chat(leader, span_notice("[friend_message_composed]"))
	friends_list += leader
	if(do_after(leader, 60, target = leader))
		for(var/mob/friend in friends_list)
			do_teleport(friend, specific_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
			friend.flash_darkness(100)
		playsound(leader, gurby_unescape, 80, FALSE)

/obj/structure/gptdfm/exit/teleportation(mob/user, obj/structure/gptdfm/specific_location = pick(GLOB.child_exiterporter), leaving_message = "Time for my journey. I'm going to [specific_location.name].")
	specific_location = pick(GLOB.child_enterporter)
	leaving_message = "I'm going back to the safezone now."
	if(HAS_TRAIT(user, TRAIT_DENOMINATOR_ACCESS))
		leaving_message = "Establishing an exfil back to base."
		if(GLOB.denominator_exiterporter)
			specific_location = pick(GLOB.denominator_exiterporter)
		else
			to_chat(user, span_boldwarning("I can't make it back to my base. I'm stuck!"))
			return
	. = ..()

/obj/structure/gptdfm/proc/on_entered(datum/source, mob/living/child_victim)
	SIGNAL_HANDLER
	if(!istype(child_victim))
		return
	if(child_victim.pulling && isliving(child_victim.pulling))
		INVOKE_ASYNC(src, .proc/teleportation, child_victim.pulling)
	INVOKE_ASYNC(src, .proc/teleportation, child_victim)
