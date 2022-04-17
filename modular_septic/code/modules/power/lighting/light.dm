/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	plane = GAME_PLANE_UPPER_BLOOM
	layer = WALL_OBJ_LAYER

/obj/machinery/light/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, ABOVE_FRILL_PLANE, src.plane)
