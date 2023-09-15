/turf/closed
	var/turf/open/top_turf = /turf/open/dirt
	var/turf/turf_above
	var/climbable = FALSE


/turf/closed/Initialize(mapload)
	. = ..()
	turf_above = get_step_multiz(src,UP)
	if(turf_above.type == /turf/open/openspace)
		turf_above.ChangeTurf(top_turf)
		turf_above.constructed = TRUE

//TODO remember to rename walls and hopefully even make new ones for interconnection
