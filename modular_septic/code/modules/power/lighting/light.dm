/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	icon_state = "panel"
	base_icon_state = "panel"
	plane = ABOVE_FRILL_PLANE
	layer = WALL_OBJ_LAYER
	fitting = "panel"
	bulb_colour = "#B7E6F9"
	bulb_emergency_colour = "#FF3232"
	/// Plane the light overlay goes on when powered
	var/overlay_plane = ABOVE_FRILL_PLANE_BLOOM
	/// Whether or not this should have the wall mount element
	var/wall_mounted = TRUE
	/// Whether or not to get flickered by the flickering lights subsystem
	var/random_flickering = TRUE

/obj/machinery/light/Initialize(mapload)
	. = ..()
	if(wall_mounted)
		AddElement(/datum/element/wall_mount, plane, plane)

/obj/machinery/light/Destroy()
	. = ..()
	SSlight_flickering.active_lights -= src

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

/obj/machinery/light/broken
	icon_state = "panel-broken"

/obj/machinery/light/built
	icon_state = "panel-empty"

/obj/machinery/light/small
	plane = GAME_PLANE_UPPER
	overlay_plane = GAME_PLANE_UPPER_BLOOM
	icon_state = "lamp"
	base_icon_state = "lamp"
	fitting = "lamp"
	bulb_colour = "#B7E6F9"
	bulb_emergency_colour = "#FF3232"

/obj/machinery/light/small/broken
	icon_state = "lamp-broken"

/obj/machinery/light/small/built
	icon_state = "lamp-empty"

/obj/machinery/light/floor
	plane = FLOOR_PLANE
	overlay_plane = FLOOR_PLANE_BLOOM
	layer = LOW_OBJ_LAYER
	wall_mounted = FALSE
	bulb_colour = "#FFD6AA"
	bulb_emergency_colour = "#FF3232"
