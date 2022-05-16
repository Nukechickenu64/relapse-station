/obj/structure/gptdfm
	name = "rapid-major-transportation-effect"
	desc = "For the rapid transportation of majors. (not minors)"
	icon = 'modular_septic/icons/obj/structures/gptdfm.dmi'
	icon_state = "child_transporter"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	var/gurby = list('modular_septic/sound/effects/teleporter/gurby1.wav', 'modular_septic/sound/effects/teleporter/gurby2.wav', 'modular_septic/sound/effects/teleporter/gurby3.wav', 'modular_septic/sound/effects/teleporter/gurby4.wav', 'modular_septic/sound/effects/teleporter/gurby5.wav')
	var/gurby_success = list('modular_septic/sound/effects/teleporter/gurby_success1.wav', 'modular_septic/sound/effects/teleporter/gurby_success2.wav', 'modular_septic/sound/effects/teleporter/gurby_success3.wav')
	var/obj/structure/gptdfm/exit_loc

/obj/structure/gptdfm/entrance
	name = "An unEscape from Nevado"
	desc = "GTFIN!"

/obj/structure/gptdfm/exit
	name = "An Escape from Nevado"
	desc = "GTFO!"

/obj/structure/gptdfm/examine(mob/user)
	playsound(src, gurby, 30, FALSE)
	return

/obj/structure/gptdfm/entrance/examine(mob/user)
	. = ..()
	to_chat(user, span_warning("Oh, lovely. A blinking purple square. I should step on it, nothing bad or violent will happen."))

/obj/structure/gptdfm/exit/examine(mob/user)
	. = ..()
	to_chat(user, span_danger("Get me the FUCK OUT OF HERE, NIGGA."))

/obj/structure/gptdfm/entrance/proc/doteleport(mob/user)
	to_chat(user, span_notice("I start to GTFO and take my epic fail with me..."))
	if(do_after(user, 50, target = user))
		do_teleport(user, , no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
		playsound(user, gurby_success, 50, FALSE)

/obj/structure/gptdfm/entrance/proc/on_enter(datum/source, atom/movable/AM)
	var/mob/living/L = AM
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		if(C.body_position == STANDING_UP)
			doteleport(C, exit_loc)
