// Add FoV
/mob/living/Initialize(mapload)
	. = ..()
	if(has_field_of_vision && CONFIG_GET(flag/use_field_of_vision))
		LoadComponent(/datum/component/field_of_vision, fov_type, get_fov_angle(fov_type))
	update_shadow()

// Fluoride stare
/mob/living/handle_eye_contact(mob/living/examined_mob)
	if(!istype(examined_mob) || src == examined_mob || stat >= UNCONSCIOUS || examined_mob.stat >= UNCONSCIOUS)
		return

	if(!HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
		if(!client || !LAZYACCESS(examined_mob.client?.recent_examines, src))
			return
		if(get_dist(src, examined_mob) > EYE_CONTACT_RANGE)
			return

	// check to see if their face is blocked or, if not, a signal blocks it
	if(examined_mob.is_face_visible() && SEND_SIGNAL(src, COMSIG_MOB_EYECONTACT, examined_mob, TRUE) != COMSIG_BLOCK_EYECONTACT)
		var/msg = span_smallnotice("I make eye contact with [examined_mob].")
		if(HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
			msg = span_flashinguserdanger("I make eye contact with [examined_mob].")
		addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, src, msg), 3) // so the examine signal has time to fire and this will print after

	if(is_face_visible() && SEND_SIGNAL(examined_mob, COMSIG_MOB_EYECONTACT, src, FALSE) != COMSIG_BLOCK_EYECONTACT)
		var/msg = span_smallnotice("<b>[src]</b> makes eye contact with you.")
		if(HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
			msg = span_flashinguserdanger("<b>[src]</b> makes eye contact with you.")
		addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, examined_mob, msg), 3)

// Update the hud smoothly
/mob/living/changeNext_move(num)
	. = ..()
	if(hud_used?.swap_hand)
		hud_used.swap_hand.last_user_move = world.time
		hud_used.swap_hand.target_time = next_move
		START_PROCESSING(SShuds, hud_used.swap_hand)

/mob/living/ZImpactDamage(turf/T, levels)
	SEND_SIGNAL(T, COMSIG_TURF_MOB_FALL, src)
	fall_scream()
	//TODO: swimming skill
	if(T.liquids?.liquid_state >= LIQUID_STATE_WAIST)
		Knockdown(2 SECONDS)
		return
	var/difficulty = (levels**2)/2 //exponentially harder to succeed the diceroll
	//Freerunning makes it easier
	if(HAS_TRAIT(src, TRAIT_FREERUNNING))
		difficulty -= 5
	var/diceroll = diceroll(GET_MOB_SKILL_VALUE(src, SKILL_ACROBATICS)-difficulty, 10, 3, 6)
	switch(diceroll)
		//Lucky nigga
		if(DICE_CRIT_SUCCESS)
			visible_message(span_danger("<b>[src]</b> regroups as [p_they()] fall[p_they() in list("it", "they") ? "" : "s"] safely on [T]!"), \
						span_userdanger("I fall down on [T], but regroup safely!"))
		if(DICE_SUCCESS)
			visible_message(span_danger("<b>[src]</b> braces and cushions their fall!"), \
						span_userdanger("I cushion my fall on [T]!"))
			var/ouch = (levels * 2.5) ** 2
			var/list/oofzones = pick(list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_L_LEG), list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_R_LEG))
			for(var/limb in oofzones)
				apply_damage(ouch, damagetype = BRUTE, def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
			CombatKnockdown(levels * 25, levels * 1 SECONDS)
		if(DICE_FAILURE)
			visible_message(span_danger("<b>[src]</b> crashes into [T]!"), \
						span_userdanger("I crash into [T]!"))
			var/ouch = (levels * 3) ** 2
			var/list/oofzones = pick(list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_L_LEG), list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_R_LEG))
			for(var/limb in oofzones)
				apply_damage(ouch, damagetype = BRUTE, def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
			oofzones = pick(list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_L_LEG), list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_R_LEG))
			for(var/limb in oofzones)
				apply_damage(ouch, damagetype = BRUTE, def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
			CombatKnockdown(levels * 35, levels * 2.5 SECONDS, levels * 1 SECONDS, TRUE)
		if(DICE_CRIT_FAILURE)
			visible_message(span_danger("<b>[src]</b> crashes into [T] with a sickening noise!"), \
							span_userdanger("I crash into [T] with a sickening noise!"))
			var/ouch = (levels * 3.5) ** 2
			var/list/oofzones = pick(list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_L_LEG), list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_R_LEG))
			for(var/limb in oofzones)
				apply_damage(ouch, damagetype = BRUTE, def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
			oofzones = pick(list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_L_LEG), list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_R_LEG))
			for(var/limb in oofzones)
				apply_damage(ouch, damagetype = BRUTE, def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT))
			CombatKnockdown(levels * 50, levels * 4 SECONDS, levels * 2 SECONDS, TRUE)

/mob/living/get_temperature(datum/gas_mixture/environment)
	var/loc_temp = environment ? environment.temperature : T0C
	if(isobj(loc))
		var/obj/oloc = loc
		var/obj_temp = oloc.return_temperature()
		if(obj_temp != null)
			loc_temp = obj_temp
	else if(isspaceturf(get_turf(src)))
		var/turf/heat_turf = get_turf(src)
		loc_temp = heat_turf.temperature
	else if(isturf(loc) && iscarbon(src))
		var/turf/turf_loc = loc
		var/mob/living/carbon/carbon = src
		if(turf_loc.liquids?.liquid_state >= LIQUID_STATE_ANKLES)
			var/submergement_percent = SUBMERGEMENT_PERCENT(carbon, turf_loc.liquids)
			loc_temp = (loc_temp*(1-submergement_percent)) + (turf_loc.liquids.temperature * submergement_percent)
	return loc_temp

/// Change a mob's act-intent. Input the intent as an intent define or use "right"/"left"
/mob/living/verb/a_intent_change(input as text)
	set name = "a-intent"
	set hidden = 1

	if(!possible_a_intents || !possible_a_intents.len)
		return

	if(input in possible_a_intents)
		a_intent = input
	else
		var/current_intent = possible_a_intents.Find(a_intent)
		if(!current_intent)
			// Failsafe. Just in case some badmin was playing with VV.
			current_intent = 1

		if(input == INTENT_HOTKEY_RIGHT)
			current_intent += 1
		if(input == INTENT_HOTKEY_LEFT)
			current_intent -= 1

		// Handle looping
		if(current_intent < 1)
			current_intent = possible_a_intents.len
		if(current_intent > possible_a_intents.len)
			current_intent = 1

		a_intent = possible_a_intents[current_intent]

	hand_index_to_intent[active_hand_index] = a_intent
	hud_used?.intent_select?.icon_state = "[a_intent]"

/mob/living/set_combat_mode(new_mode, silent)
	if(combat_mode == new_mode)
		return
	. = combat_mode
	combat_mode = new_mode
	if(hud_used?.action_intent)
		hud_used.action_intent.update_appearance()
	if(silent)
		return
	if(combat_mode)
		playsound_local(src, 'sound/misc/ui_togglecombat.ogg', 25, FALSE, pressure_affected = FALSE) //Sound from interbay!
		if(mind?.combat_music)
			SSdroning.play_combat_music(mind.combat_music, client)
	else
		playsound_local(src, 'sound/misc/ui_toggleoffcombat.ogg', 25, FALSE, pressure_affected = FALSE) //Slightly modified version of the above
		if(mind?.combat_music)
			SSdroning.play_area_sound(get_area(src), client)

/mob/living/set_lying_angle(new_lying)
	if(new_lying == lying_angle)
		return
	. = lying_angle
	lying_angle = new_lying
	if(lying_angle != lying_prev)
		update_transform()
		lying_prev = lying_angle
