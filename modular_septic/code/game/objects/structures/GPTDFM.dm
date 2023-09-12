GLOBAL_LIST_EMPTY(child_enterporter)
GLOBAL_LIST_EMPTY(child_exiterporter)

/obj/structure/gptdfm
	name = "rapid-major-transportation-effect"
	desc = "For the rapid transportation of majors. (not minors)"
	icon = 'modular_septic/icons/obj/structures/gptdfm.dmi'
	icon_state = "child_transporter"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	var/gurby = list('modular_septic/sound/effects/teleporter/gurby1.wav', 'modular_septic/sound/effects/teleporter/gurby2.wav', 'modular_septic/sound/effects/teleporter/gurby3.wav', 'modular_septic/sound/effects/teleporter/gurby4.wav', 'modular_septic/sound/effects/teleporter/gurby5.wav')
	var/gurby_escape = 'modular_septic/sound/effects/chadjack.wav'
	var/gurby_unescape = 'modular_septic/sound/effects/soyjack.wav'
	var/obj/structure/gptdfm/exit_loc

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

/obj/structure/gptdfm/exit
	name = "An Escape from Nevado"
	desc = "GTFO!"

/obj/structure/gptdfm/exit/Initialize(mapload)
	. = ..()
	GLOB.child_exiterporter += src

/obj/structure/gptdfm/examine(mob/user)
	playsound(user, gurby, 30, FALSE)
	return

/obj/structure/gptdfm/entrance/examine(mob/user)
	. = list()
	. += span_info("Time to Escape from Nevado!")
	. += span_big(span_alert("Oh, lovely. A blinking purple square. I should step on it, nothing bad or violent will happen to me or my family members!"))

/obj/structure/gptdfm/exit/examine(mob/user)
	. = list()
	. += span_info("Back to the Safezone!")
	. += span_big(span_alert("Fuckingm, FUC, yHUJFDid  IFGD FUC<ING HATE THIS FUCHFJDNF KING PLACE GET ME OUT OF HERE!! GET ME ROUT"))

/obj/structure/gptdfm/proc/teleportation(mob/user)
	to_chat(user, span_notice("I start to GTFO and take my epic fail with me..."))
	if(do_after(user, 50, target = user))
		do_teleport(user, pick(GLOB.child_exiterporter), no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
		playsound(user, gurby_unescape, 80, FALSE)
		user.flash_darkness(100)

/obj/structure/gptdfm/exit/teleportation(mob/user)
	to_chat(user, span_notice("I start to GTFIN and take my epic success with me!"))
	if(do_after(user, 50, target = user))
		do_teleport(user, pick(GLOB.child_enterporter), no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
		playsound(user, gurby_escape, 80, FALSE)
		user.flash_darkness(100)

/obj/structure/gptdfm/proc/on_entered(datum/source, mob/living/child_victim)
	SIGNAL_HANDLER
	if(!istype(child_victim))
		return
	if(child_victim.pulling && isliving(child_victim.pulling))
		INVOKE_ASYNC(src, .proc/teleportation, child_victim.pulling)
	INVOKE_ASYNC(src, .proc/teleportation, child_victim)



