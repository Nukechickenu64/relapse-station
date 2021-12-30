// Changing mob planes
/atom/movable/buckle_mob(mob/living/M, force, check_loc, buckle_mob_flags, ignore_self = FALSE)
	. = ..()
	if(.)
		plane = M.plane

/atom/movable/unbuckle_mob(mob/living/buckled_mob, force)
	. = ..()
	if(.)
		plane = initial(plane)
