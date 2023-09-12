/datum/element/window_layering
	element_flags = ELEMENT_DETACH

/datum/element/window_layering/Attach(datum/target)
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	var/atom/movable/real_target = target
	on_dir_changed(real_target, real_target.dir, real_target.dir)
	RegisterSignal(real_target, COMSIG_ATOM_DIR_CHANGE, .proc/on_dir_changed)

/datum/element/window_layering/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_DIR_CHANGE)
	var/atom/movable/real_source = source
	real_source.plane = initial(real_source.plane)
	real_source.layer = initial(real_source.layer)
	real_source.setDir(real_source.dir)

/datum/element/window_layering/proc/on_dir_changed(atom/movable/target, olddir, newdir)
	switch(newdir)
		if(NORTH)
			target.plane = GAME_PLANE_MIDDLE
			target.layer = WINDOW_LOW_LAYER
		if(SOUTH)
			target.plane = GAME_PLANE_UPPER
			target.layer = WINDOW_LAYER
		if(EAST)
			target.plane = GAME_PLANE_MIDDLE
			target.layer = WINDOW_MID_LAYER
		if(WEST)
			target.plane = GAME_PLANE_MIDDLE
			target.layer = WINDOW_MID_LAYER
		else
			target.plane = GAME_PLANE_MIDDLE
			target.layer = WINDOW_LOW_LAYER
