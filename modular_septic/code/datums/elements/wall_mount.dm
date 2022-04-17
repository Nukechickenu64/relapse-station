/datum/element/wall_mount
	element_flags = ELEMENT_DETACH

/datum/element/wall_mount/Attach(datum/target)
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
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
			target.plane = ABOVE_FRILL_PLANE
			target.pixel_y = -8
		if(SOUTH)
			target.plane = GAME_PLANE
			target.pixel_y = 35
		if(EAST)
			target.plane = GAME_PLANE
			target.pixel_x = -11
			target.pixel_y = 16
		if(WEST)
			target.plane = GAME_PLANE
			target.pixel_x = 11
			target.pixel_y = 16
