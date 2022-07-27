/mob/living/carbon/attempt_jump(atom/jump_target, proximity_flag, list/modifiers)
	//We can't jump if it's the same damn tile
	//TODO: Multi-z jumping when certain requirements are met
	if(get_dist(src, jump_target) < 1)
		return FALSE
	//Not while thrown/jumping
	if(throwing)
		return FALSE
	//Not while knocked down
	if(body_position != STANDING_UP)
		to_chat(span_warning("I need to stand up."))
		return FALSE
	//Not while buckled
	if(buckled)
		to_chat(span_warning("I need to unbuckle."))
		return FALSE
	var/range = FLOOR(GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)/(ATTRIBUTE_MIDDLING/2), 1)
	if(range < 1)
		to_chat(src, span_warning("I'm too weak to do this..."))
		return FALSE
	if(ismob(jump_target))
		visible_message(span_warning("<b>[src]</b> jumps at <b>[jump_target]</b>!"), \
					span_userdanger("I jump at <b>[jump_target]</b>!"), \
					ignored_mobs = jump_target)
		to_chat(jump_target, span_userdanger("<b>[src]</b> jumps at me!"))
	else
		visible_message(span_warning("<b>[src]</b> jumps at [jump_target]!"), \
					span_userdanger("I jump at [jump_target]!"))
	jump_grunt()
	sound_hint()
	safe_throw_at(jump_target, range, throw_speed, src, FALSE, callback = CALLBACK(src, .proc/jump_callback))

/mob/living/carbon/proc/jump_callback()
	sound_hint()
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL))
		if(DICE_CRIT_SUCCESS)
			adjustFatigueLoss(15)
		if(DICE_SUCCESS)
			adjustFatigueLoss(30)
			Immobilize(1 SECONDS)
		if(DICE_FAILURE)
			adjustFatigueLoss(50)
			Immobilize(2 SECONDS)
		if(DICE_CRIT_FAILURE)
			adjustFatigueLoss(65)
			CombatKnockdown(75, 2 SECONDS)
