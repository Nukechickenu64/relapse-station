/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	var/plane_on = GAME_PLANE_UPPER_BLOOM
	var/random_flickering = FALSE

/obj/machinery/light/Initialize(mapload)
	. = ..()
	if(!plane_on)
		plane_on = plane
	if(plane != FLOOR_PLANE)
		AddElement(/datum/element/wall_mount/light_mount)

/obj/machinery/light/Destroy()
	. = ..()
	SSlight_flickering.active_lights -= src

/obj/machinery/light/update_icon(updates)
	. = ..()
	switch(status)
		if(LIGHT_BROKEN,LIGHT_BURNED,LIGHT_EMPTY)
			plane = initial(plane)
		else
			plane = plane_on

/obj/machinery/light/update(trigger)
	. = ..()
	if(!random_flickering)
		SSlight_flickering.active_lights -= src
		return
	switch(status)
		if(LIGHT_BROKEN,LIGHT_BURNED,LIGHT_EMPTY)
			SSlight_flickering.active_lights |= src
		else
			SSlight_flickering.active_lights -= src

/obj/machinery/light/floor
	plane = FLOOR_PLANE
	layer = LOW_OBJ_LAYER
	plane_on = null
