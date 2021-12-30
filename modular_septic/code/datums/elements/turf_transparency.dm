/datum/element/turf_z_transparency/on_multiz_turf_del(turf/our_turf, turf/below_turf, dir)
	if(dir != DOWN)
		return

	update_multiz(our_turf, TRUE, TRUE)

/datum/element/turf_z_transparency/on_multiz_turf_new(turf/our_turf, turf/below_turf, dir)
	if(dir != DOWN)
		return

	update_multiz(our_turf, TRUE, TRUE)

/datum/element/turf_z_transparency/update_multiz(turf/our_turf, prune_on_fail = FALSE, init = FALSE)
	var/turf/below_turf = our_turf.below()
	if(!below_turf)
		our_turf.vis_contents.len = 0
		if(!show_bottom_level(our_turf) && prune_on_fail) //If we cant show whats below, and we prune on fail, change the turf to plating as a fallback
			our_turf.ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return FALSE
	if(init)
		our_turf.vis_contents += below_turf

	if(isclosedturf(our_turf)) //Show girders below closed turfs
		var/mutable_appearance/girder_underlay = mutable_appearance('icons/obj/structures.dmi', "girder", layer = TURF_LAYER-0.01)
		girder_underlay.appearance_flags = RESET_ALPHA | RESET_COLOR
		our_turf.underlays += girder_underlay
		var/mutable_appearance/plating_underlay = mutable_appearance('icons/turf/floors.dmi', "plating", layer = TURF_LAYER-0.02)
		plating_underlay = RESET_ALPHA | RESET_COLOR
		our_turf.underlays += plating_underlay
	return TRUE
