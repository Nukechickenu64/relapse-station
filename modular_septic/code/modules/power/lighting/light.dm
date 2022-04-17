/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	plane = GAME_PLANE_UPPER_BLOOM
	layer = WALL_OBJ_LAYER

/obj/machinery/light/Initialize(mapload)
	. = ..()
	setDir(dir)

/obj/machinery/light/setDir(newdir)
	. = ..()
	if(layer != WALL_OBJ_LAYER)
		return
	switch(dir)
		if(SOUTH)
			pixel_y = -2
		if(NORTH)
			pixel_y = 35
		if(WEST)
			pixel_x = -16
			pixel_y = 16
		if(EAST)
			pixel_x = 16
			pixel_y = 16
