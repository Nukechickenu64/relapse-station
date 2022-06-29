/obj/machinery
	/// Determines if the pipebomb is triggered
	var/pipebomb_triggered = FALSE
	/// Determines if the machine is trapped and about to detonate when the next person uses it. Requires a frag grenade/pipebomb to be put inside for this to work.
	var/ted_kaczynskied = FALSE
	/// A literal fucking pipebomb
	var/obj/item/grenade/frag/pipebomb/bomb

/obj/machinery/attackby(obj/item/weapon, mob/user, params)
	var/message = pick(GLOB.whoopsie)
	if(istype(weapon, /obj/item/grenade/frag/pipebomb) && !ted_kaczynskied)
		if(GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS) <= 6)
			to_chat(user, span_danger("I'm sadly not good enough as my hero."))
			return
		playsound(src, 'modular_septic/sound/effects/ted.wav', 50, FALSE)
		var/godforsaken = pick("godforsaken", "devious", "monumental", "memorable", "good", "fantastic", "really good")
		var/ted_message
		if(prob(5))
			ted_message = "I begin doing a-little bit of [godforsaken] trolling of-course!"
		else
			ted_message = "I begin planting the [src]"
		user.visible_message(span_danger("[user] begins sabotaging the [src] with a [weapon]!"), \
				span_danger("[ted_message]"))
		if(!do_after(user, 2.6 SECONDS))
			to_chat(user, span_warning("[message] I need to hold fucking still!"))
			return
		bomb = weapon
		user.transferItemToLoc(weapon, src)
		ted_kaczynskied = TRUE
		return TRUE
	else
		to_chat(user, span_danger("[message]"))
	if(weapon.tool_behaviour == TOOL_WIRECUTTER)
		if(!(pipebomb_triggered && bomb in src))
			return
		bomb.det_time = initial(bomb.det_time)
		deltimer(bomb.det_timer)
		user.transferItemToLoc(bomb, src.loc)
		bomb = null
		playsound(src, 'sound/items/wirecutter.ogg', 50, FALSE, -1)
		user.visible_message(span_bolddanger("[user] disables the human sabotage device before it explodes!"), \
			span_warning("I disable the pipebomb."))
		return TRUE
	. = ..()

/obj/machinery/MouseEntered(location, control, params, mob/user)
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(bomb in src)
		if(pipebomb_triggered)
			return
		visible_message(span_danger("[bomb] underneath the [src] beeps rapidly!"), \
				span_bigdanger("Looks like I've been left a bright shiny gift!"))
		playsound(src, 'modular_septic/sound/effects/ted_beeping.wav', 80, FALSE, 2)
		sound_hint()
		bomb.det_time = 1 SECONDS
		bomb.spoon_grenade()
		pipebomb_triggered = TRUE
	. = ..()
