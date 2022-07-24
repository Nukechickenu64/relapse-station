/turf
	/// This turf's fire movable
	var/atom/movable/fire/turf_fire
	/// Chance of a turf fire spreading to us
	var/flammability = TURF_DEFAULT_FLAMMABILITY

/turf/examine(mob/user)
	. = ..()
	if(turf_fire)
		. += span_danger("Holy shit, [src] is on <b>fire</b>!")

/turf/proc/ignite_turf_fire(power)
	if(!flammable)
		return
	if(turf_fire)
		turf_fire.add_power(power)
		return
	if(isopenspaceturf(src) || isspaceturf(src))
		return
	new /atom/movable/fire(src, power)
