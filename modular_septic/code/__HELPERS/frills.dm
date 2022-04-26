/proc/get_frill_appearance(icon, junction, alpha = 255, pixel_x = 0, pixel_y = 0, plane = FRILL_PLANE, layer = ABOVE_MOB_LAYER)
	. = GLOB.frill_appearances["[icon]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[layer]"]
	if(.)
		return
	var/mutable_appearance/frill_appearance = mutable_appearance(icon, "frill-[junction]", layer, plane, alpha)
	frill_appearance.pixel_x = pixel_x
	frill_appearance.pixel_y = pixel_y
	GLOB.frill_appearances["[icon]-[junction]-[alpha]-[pixel_x]-[pixel_y]-[plane]-[layer]"] = frill_appearance
	return frill_appearance
