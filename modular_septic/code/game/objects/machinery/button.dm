/obj/machinery/button
	icon = 'modular_septic/icons/obj/stationobjs.dmi'
	plane = GAME_PLANE_UPPER

/obj/machinery/button/Initialize(mapload, ndir, built)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
