/datum/status_effect/grouped/heldup
	id = "heldup"
	duration = -1
	tick_interval = -1
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null

/datum/status_effect/grouped/heldup/on_apply()
	owner.apply_status_effect(STATUS_EFFECT_SURRENDER, src)
	return ..()

/datum/status_effect/grouped/heldup/on_remove()
	owner.remove_status_effect(STATUS_EFFECT_SURRENDER, src)
	return ..()

/datum/status_effect/holdup
	alert_type = null
