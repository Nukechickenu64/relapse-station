/mob/living/carbon/proc/update_basic_speed_modifier()
	var/datum/movespeed_modifier/base_speed
	switch(m_intent)
		if(MOVE_INTENT_RUN)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_WALK)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/basic_speed, TRUE, get_basic_speed()-base_speed.multiplicative_slowdown)
	update_stance_efficiency()

/mob/living/carbon/proc/get_basic_speed(force_m_intent = null)
	var/datum/movespeed_modifier/base_speed
	var/final_m_intent = (force_m_intent ? force_m_intent : m_intent)
	switch(final_m_intent)
		if(MOVE_INTENT_RUN)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_WALK)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
	if(!istype(attributes))
		return base_speed.multiplicative_slowdown
	var/dexend = (GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)+GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))/2
	var/extra_speed = (base_speed.multiplicative_slowdown/ATTRIBUTE_MIDDLING)*(dexend-ATTRIBUTE_MIDDLING)
	return max(base_speed.multiplicative_slowdown-extra_speed, 0.25)
