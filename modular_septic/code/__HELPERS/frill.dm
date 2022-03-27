/proc/init_frill_blockers()
	var/list/frill_blockers = list()
	for(var/type in typesof(/atom/movable/frill_blocker))
		var/atom/movable/frill_blocker/frill_blocker = new type()
		frill_blockers[frill_blocker.type] = frill_blocker
	return frill_blockers

/proc/get_frill_object(icon, junction, alpha = 255, pixel_x = 0, pixel_y = 0, plane = FRILL_PLANE)
	. = GLOB.frill_objects["[icon]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]"]
	if(.)
		return
	var/mutable_appearance/mut_appearance = mutable_appearance(icon, "frill-[junction]", ABOVE_MOB_LAYER, plane, alpha)
	mut_appearance.pixel_x = pixel_x
	mut_appearance.pixel_y = pixel_y
	return GLOB.frill_objects["[icon]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]"] = mut_appearance
