/atom/movable/particle_holder/fire_embers
	plane = ABOVE_FRILL_PLANE_BLOOM

/atom/movable/particle_holder/fire_embers/Initialize(mapload)
	. = ..()
	particles = new /particles/fire_embers()

/atom/movable/particle_holder/fire_smoke
	plane = ABOVE_FRILL_PLANE

/atom/movable/particle_holder/fire_smoke/Initialize(mapload)
	. = ..()
	particles = new /particles/fire_smoke()
