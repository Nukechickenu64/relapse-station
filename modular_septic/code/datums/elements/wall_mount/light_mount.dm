/datum/element/wall_mount/light_mount
	plane_upper = ABOVE_FRILL_PLANE
	plane_lower = GAME_PLANE_UPPER_BLOOM

/datum/element/wall_mount/light_mount/on_dir_changed(atom/movable/target, olddir, newdir)
	//These magic offsets are chosen for no particular reason
	switch(newdir)
		if(SOUTH)
			target.plane = plane_upper
			target.pixel_y = -2
		if(NORTH)
			target.plane = plane_lower
			target.pixel_y = 35
		if(WEST)
			target.plane = plane_lower
			target.pixel_x = -16
			target.pixel_y = 16
		if(EAST)
			target.plane = plane_lower
			target.pixel_x = 16
			target.pixel_y = 16
