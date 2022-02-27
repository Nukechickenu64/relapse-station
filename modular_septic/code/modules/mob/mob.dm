/mob
	plane = GAME_PLANE_FOV_HIDDEN
	var/cursor_icon = 'modular_septic/icons/effects/mouse_pointers/normal.dmi'
	var/combat_cursor_icon = 'modular_septic/icons/effects/mouse_pointers/combat.dmi'
	var/examine_cursor_icon_combat = 'modular_septic/icons/effects/mouse_pointers/combat_examine.dmi'

/mob/Initialize(mapload)
	. = ..()
	set_hydration(rand(HYDRATION_LEVEL_START_MIN, HYDRATION_LEVEL_START_MAX))
	// If we have an attribute holder, lets get that W
	if(ispath(attributes))
		AttributeInitialize()

/mob/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	return SCREENTIP_MOB(uppertext(name))

/mob/verb/examinate(atom/examinify as mob|obj|turf in view())
	set name = "Examine"
	set category = "IC"

	if(isturf(examinify) && !(sight & SEE_TURFS))
		return

	if(is_blind() && !blind_examine_check(examinify)) //blind people see things differently (through touch)
		return

	face_atom(examinify)
	var/flags = SEND_SIGNAL(src, COMSIG_MOB_EXAMINATE, examinify)
	if(flags & COMPONENT_NO_EXAMINATE)
		return
	else if(flags & COMPONENT_EXAMINATE_BLIND)
		to_chat(src, span_warning("Something is there but you can't see it!"))
		return
	var/too_far_away = !isnull(examinify.maximum_examine_distance) && (get_dist(src, examinify) > examinify.maximum_examine_distance)
	if(too_far_away)
		to_chat(src, span_warning("It's too far away."))
		return
	var/list/result
	var/examine_more = FALSE
	if(client)
		LAZYINITLIST(client.recent_examines)
		var/ref_to_atom = ref(examinify)
		var/examine_time = LAZYACCESS(client.recent_examines, ref_to_atom)
		if(examine_time && (world.time - examine_time < EXAMINE_MORE_WINDOW))
			examine_more = TRUE
			result = examinify.examine_more(src)
			if(!LAZYLEN(result))
				result = list(span_notice("<i>I examine [examinify] closer, but find nothing of interest...</i>"))
			handle_eye_contact(examinify)
		else
			result = examinify.examine(src)
			client.recent_examines[ref_to_atom] = world.time // set the value to when the examine cooldown ends
			addtimer(CALLBACK(src, .proc/clear_from_recent_examines, ref_to_atom), RECENT_EXAMINE_MAX_WINDOW)
			handle_eye_contact(examinify)
	else
		result = examinify.examine(src) // if a tree is examined but no client is there to see it, did the tree ever really exist?

	if(!examine_more)
		var/list/examine_chaser = examinify.examine_chaser(src)
		if(LAZYLEN(examine_chaser))
			result += examine_chaser
		var/list/topic_examine = examinify.topic_examine(src)
		if(LAZYLEN(topic_examine))
			result += div_infobox("[topic_examine.Join(" | ")]")

	if(result)
		to_chat(src, span_infoplain(div_infobox("[result.Join("\n")]")))

///Attributes
/mob/proc/AttributeInitialize()
	attributes = new attributes(src)

///Adjust the hydration of a mob
/mob/proc/adjust_hydration(change)
	hydration = max(0, hydration + change)

///Force set the mob hydration
/mob/proc/set_hydration(change)
	hydration = max(0, change)
