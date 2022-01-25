/mob/living/carbon/proc/update_shock_penalty(incoming = 0, duration = INJURY_PENALTY_COOLDOWN)
	//use remove_shock_penalty() you idiot
	if(!incoming || !duration)
		return
	if(shock_penalty_timer)
		deltimer(shock_penalty_timer)
		shock_penalty_timer = null
	//pick the bigger value between what we already are suffering and the incoming modification
	shock_penalty = max(incoming, shock_penalty)
	attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/shock_penalty, TRUE, list(STAT_DEXTERITY = -shock_penalty, STAT_INTELLIGENCE = -shock_penalty))
	shock_penalty_timer = addtimer(CALLBACK(src, .proc/remove_shock_penalty), duration, TIMER_STOPPABLE)

/mob/living/carbon/proc/remove_shock_penalty()
	attributes?.remove_attribute_modifier(/datum/attribute_modifier/shock_penalty)
	shock_penalty = 0

/mob/living/carbon/proc/update_blocking_penalty(incoming = 0, duration = BLOCKING_PENALTY_COOLDOWN)
	//use remove_shock_penalty() you idiot
	if(!incoming || !duration)
		return
	if(blocking_penalty_timer)
		deltimer(blocking_penalty_timer)
		blocking_penalty_timer = null
	//add incoming modification
	blocking_penalty += incoming
	blocking_penalty_timer = addtimer(CALLBACK(src, .proc/remove_shock_penalty), duration, TIMER_STOPPABLE)

/mob/living/carbon/proc/remove_blocking_penalty()
	blocking_penalty = 0
