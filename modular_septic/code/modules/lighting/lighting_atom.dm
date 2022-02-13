/atom/movable/set_opacity(new_opacity)
	. = ..()
	if(isnull(.) || !isturf(loc))
		return
	var/turf/turf_loc = loc
	if(!turf_loc.opacity)
		turf_loc.update_shadowcasting_overlays()
		for(var/turf/neighbor in oview(11))
			neighbor.update_shadowcasting_overlays()
