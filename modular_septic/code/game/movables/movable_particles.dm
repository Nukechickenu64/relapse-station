/atom/movable/proc/add_particles()
	particles = new /particles

/atom/movable/proc/remove_particles()
	particles = null

/atom/movable/proc/modify_particles_value(varName, varVal)
	if(!particles)
		return
	particles.vars[varName] = varVal

/atom/movable/proc/transition_particles(list/new_params, time, easing, loop, flags = LINEAR_EASING)
	if(!particles)
		return
	animate(particles, new_params, time = time, easing = easing, loop = loop, flags = flags)
