//HEAD RAPE
//DURATION SHOULD ALWAYS BE DIVISIBLE BY 40 (4 SECONDS) TO ENSURE SMOOTH ANIMATION.
//IF YOU DON'T ABIDE BY THE ABOVE, YOUR MAILBOX WILL RECEIVE A VERY NASTY SURPRISE.
/datum/status_effect/incapacitating/headrape
	id = "head_rape"
	status_type = STATUS_EFFECT_REFRESH
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	tick_interval = 4 SECONDS
	/// Alpha of the first composite layer
	var/static/starting_alpha = 128
	/// How many total layers we get, each new layer halving the previous layer's alpha
	var/intensity = 3
	/// Render relay plate we are messing with
	var/atom/movable/screen/plane_master/rendering_plate/our_plate
	/// Each filter we are handling, assoc list
	var/list/list/filters_handled = list()

/datum/status_effect/incapacitating/headrape/Destroy()
	our_plate = null
	filters_handled = null
	return ..()

/datum/status_effect/incapacitating/headrape/on_apply()
	. = ..()
	if(owner?.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME])
		our_plate = owner.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		for(var/i in 1 to intensity)
			var/anim_color = rgb(255, 255, 255, max(16, starting_alpha/(2**i)))
			filters_handled["headrape[i]"] = layering_filter(x = 0, y = 0, color = anim_color)
		for(var/i in 1 to intensity)
			var/list/filter_params = filters_handled["headrape[i]"].Copy()
			filter_params["render_source"] = our_plate.render_target
			our_plate.add_filter("headrape[i]", 10+i, filter_params)

/datum/status_effect/incapacitating/headrape/tick()
	. = ..()
	if(our_plate)
		INVOKE_ASYNC(src, .proc/perform_animation)

/datum/status_effect/incapacitating/headrape/before_remove()
	. = ..()
	if(our_plate)
		INVOKE_ASYNC(src, .proc/end_animation)

/datum/status_effect/incapacitating/headrape/proc/perform_animation()
	for(var/i in 1 to intensity)
		filters_handled["headrape[i]"]["x"] = rand(-16, 16)
		filters_handled["headrape[i]"]["y"] = rand(-16, 16)
	update_filters(4 SECONDS)

/datum/status_effect/incapacitating/headrape/proc/end_animation()
	var/kill_color = rgb(255, 255, 255, 0)
	for(var/i in 1 to intensity)
		filters_handled["headrape[i]"] = layering_filter(x = 0, y = 0, color = kill_color)
	update_filters(2 SECONDS)
	var/atom/movable/screen/plane_master/rendering_plate/our_old_plate = our_plate
	//Sleep call ensures the ending looks smooth no matter what
	sleep(2 SECONDS)
	//KILL the filters now
	if(!QDELETED(our_old_plate))
		for(var/i in 1 to intensity)
			our_old_plate.remove_filter("headrape[i]")

/datum/status_effect/incapacitating/headrape/proc/update_filters(time = 4 SECONDS)
	for(var/i in 1 to intensity)
		var/list/filter_params = filters_handled["headrape[i]"].Copy()
		filter_params -= "type"
		filter_params -= "render_source"
		our_plate.transition_filter("headrape[i]", time, filter_params, LINEAR_EASING, FALSE)
