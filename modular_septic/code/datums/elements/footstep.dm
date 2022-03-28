/datum/element/footstep/prepare_step(mob/living/source)
	var/turf/open/turf = get_turf(source)
	if(!istype(turf))
		return

	if(!turf.footstep || source.buckled || source.throwing || source.movement_type & (VENTCRAWLING | FLYING) || HAS_TRAIT(source, TRAIT_IMMOBILIZED))
		return

	if(source.body_position == LYING_DOWN) //play crawling sound if we're lying
		playsound(turf, 'modular_septic/sound/effects/footstep/crawl.ogg', 10 * volume, falloff_distance = 1, vary = sound_vary)
		return

	if(iscarbon(source))
		var/mob/living/carbon/carbon_source = source
		if(!carbon_source.get_bodypart(BODY_ZONE_L_LEG) && !carbon_source.get_bodypart(BODY_ZONE_R_LEG))
			return
		if(carbon_source.m_intent == MOVE_INTENT_WALK)
			return// stealth
	steps_for_living[source] += 1
	var/steps = steps_for_living[source]

	if(steps >= 6)
		steps_for_living[source] = 0
		steps = 0

	if(steps % 2)
		return

	if(steps != 0 && !source.has_gravity(turf)) // don't need to step as often when you hop around
		return
	return turf
