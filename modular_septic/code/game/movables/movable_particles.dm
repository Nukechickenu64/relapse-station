/atom/movable/proc/add_particle_holder(key = "particles", holder_type = /atom/movable/particle_holder)
	var/atom/particle_holder = new holder_type()
	vis_contents += particle_holder
	LAZYADDASSOC(particle_holders, key, particle_holder)

/atom/movable/proc/remove_particle_holder(key = "particles")
	if(!LAZYACCESS(particle_holders, key))
		return
	vis_contents -= particle_holders[key]
	LAZYREMOVE(particle_holders, key)

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
