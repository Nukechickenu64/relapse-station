/obj/machinery/light_switch
	icon = 'modular_septic/icons/obj/machinery/power.dmi'
	plane = GAME_PLANE_UPPER

/obj/machinery/light_switch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
