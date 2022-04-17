/datum/element/wall_mount
	element_flags = ELEMENT_DETACH | ELEMENT_BESPOKE
	var/plane_upper = ABOVE_FRILL_PLANE
	var/plane_lower = GAME_PLANE

/datum/element/wall_mount/Attach(datum/target, plane_upper = ABOVE_FRILL_PLANE, plane_lower = GAME_PLANE)
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.plane_upper = plane_upper
	src.plane_lower = plane_lower
	var/atom/movable/real_target = target
	RegisterSignal(real_target, COMSIG_ATOM_DIR_CHANGE, .proc/on_dir_changed)
	on_dir_changed(real_target, real_target.dir, real_target.dir)

/datum/element/wall_mount/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_DIR_CHANGE)

/datum/element/wall_mount/proc/on_dir_changed(atom/movable/target, olddir, newdir)
	//These magic offsets are chosen for no particular reason
	//The wall mount template is made to work with them
	switch(newdir)
		if(NORTH)
			target.plane = plane_upper
			target.pixel_y = -8
		if(SOUTH)
			target.plane = plane_lower
			target.pixel_y = 35
		if(EAST)
			target.plane = plane_lower
			target.pixel_x = -11
			target.pixel_y = 16
		if(WEST)
			target.plane = plane_lower
			target.pixel_x = 11
			target.pixel_y = 16
