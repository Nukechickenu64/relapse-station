/turf
	///Fire movable of this turf
	var/atom/movable/fire/turf_fire
	///Whether or not we can have a turf fire going on
	var/flammable = TRUE

/turf/examine(mob/user)
	. = ..()
	if(turf_fire)
		. += span_warning("Holy shit, [src] is on <b>fire</b>!")

/turf/proc/ignite_turf_fire(power)
	if(!flammable)
		return
	if(turf_fire)
		turf_fire.add_power(power)
		return
	if(istype(src, /turf/open/openspace) || isspaceturf(src))
		return
	new /atom/movable/fire(src, power)
