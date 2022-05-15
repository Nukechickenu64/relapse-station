/obj/structure/gptdfm
    name = "rapid-major-transportation-effect"
    desc = "For the rapid transportation of majors. (not minors)"
    density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	var/gurby = list('modular_septic/sound/effects/teleporter/gurby1.wav', 'modular_septic/sound/effects/teleporter/gurby2.wav', 'modular_septic/sound/effects/teleporter/gurby3.wav', 'modular_septic/sound/effects/teleporter/gurby4.wav', 'modular_septic/sound/effects/teleporter/gurby5.wav')

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
	to_chat(user, span_warning("Oh, lovely. A blinking purple square. I should step on it, nothing bad or violent will happen."))
	return

/obj/structure/gptdfm/exit/examine(mob/user)
	to_chat(user, span_danger("Get me the FUCK OUT OF HERE, NIGGA."))
	return

/obj/structure/gptdfm/proc/transportation()
