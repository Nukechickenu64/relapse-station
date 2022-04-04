/datum/status_effect/water_affected
	id = "wateraffected"
	alert_type = null
	duration = -1

/datum/status_effect/water_affected/on_apply()
	. = ..()
	//We should be on top of a liquid movable if this is applied
	calculate_water_slow()

/datum/status_effect/water_affected/tick()
	var/turf/owner_turf = get_turf(owner)
	if(!owner_turf?.liquids || (owner_turf.liquids.liquid_state <= LIQUID_STATE_PUDDLE))
		qdel(src)
		return
	calculate_water_slow()
	calculate_floating()
	//Make the reagents touch the person
	var/fraction = SUBMERGEMENT_PERCENT(owner, owner_turf.liquids)
	var/datum/reagents/temporary_holder = owner_turf.liquids.simulate_reagents_flat(SUBMERGEMENT_REAGENTS_TOUCH_AMOUNT*fraction)
	temporary_holder.expose(owner, TOUCH)
	qdel(temporary_holder)
	return ..()

/datum/status_effect/water_affected/proc/calculate_water_slow()
	//TODO: Factor in swimming skill here?
	var/turf/owner_turf = get_turf(owner)
	var/slowdown_amount = owner_turf.liquids.liquid_state * 0.5
	owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown, slowdown_amount)

/datum/status_effect/water_affected/proc/calculate_floating()
	//TODO: Factor in swimming skill here?
	var/turf/owner_turf = get_turf(owner)
	if(owner_turf.liquids.liquid_state >= LIQUID_STATE_WAIST)
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			if(human_owner.carry_weight >= DROWNING_WEIGHT)
				REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
				return
		ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
	else
		REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)

/datum/status_effect/water_affected/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown)
	REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
