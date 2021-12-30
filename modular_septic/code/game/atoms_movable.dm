/atom/movable/throw_at(atom/target, range, speed, mob/thrower, spin, diagonals_first, datum/callback/callback, force, gentle, quickstart)
	spin = FALSE
	return ..()

/atom/movable/can_zFall(turf/source, levels = 1, turf/target, direction)
	if(!direction)
		direction = DOWN
	if(!source)
		source = get_turf(src)
		if(!source)
			return FALSE
	if(!target)
		target = get_step_multiz(source, direction)
		if(!target)
			return FALSE
	return !(movement_type & FLYING) && !(movement_type & FLOATING) && has_gravity(source) && !throwing

/atom/movable/onZImpact(turf/T, levels)
	var/atom/highest = T
	for(var/i in T.contents)
		var/atom/A = i
		if(!A.density)
			continue
		if(isobj(A) || ismob(A))
			if(A.layer > highest.layer)
				highest = A
	return TRUE
