/obj/machinery
	/// Determines if the pipebomb is triggered
	var/pipebomb_triggered = FALSE
	/// Determines if the machine is trapped and about to detonate when the next person uses it. Requires a frag grenade/pipebomb to be put inside for this to work.
	var/ted_kaczynskied = FALSE
	/// A literal fucking pipebomb
	var/obj/item/grenade/frag/pipebomb/bomb

/obj/machinery/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, bomb) || GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS) != null & !ted_kaczynskied)
		playsound(src, 'modular_septic/sound/effects/ted.wav', 50, FALSE)
		var/godforsaken = pick("godforsaken", "devious", "monumental", "memorable", "good", "fantastic", "really good")
		var/ted_message
		if(prob(5))
			ted_message = "I begin doing a-little bit of [godforsaken] trolling of-course!"
		else
			ted_message = "I begin planting the [src]]"
		user.visible_message(span_danger("[user] begins sabotaging the [src] with a [bomb]!"), \
				span_danger("[ted_message]"))
		if(!do_after(user, 2.6 SECONDS))
			var/message = pick(GLOB.whoopsie)
			to_chat(user, span_warning("[message] I need to hold fucking still!"))
			return
		bomb = weapon
		user.transferItemToLoc(weapon, src)
		ted_kaczynskied = TRUE
		return TRUE
	else
		to_chat(user, span_danger("I'm not as good as him."))
	. = ..()

/obj/machinery/MouseEntered(location, control, params, mob/user)
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(bomb in src & !pipebomb_triggered)
		visible_message(span_danger("[bomb] underneath the [src] beeps rapidly!"), \
				span_bigdanger("Looks like I've been left a bright shiny gift!"))
		playsound(src, 'modular_septic/sound/effects/ted_beeping.wav', 80, FALSE, 2)
		sound_hint()
		bomb.det_time = 1 SECONDS
		bomb.spoon_grenade()
		pipebomb_triggered = TRUE
	. = ..()
