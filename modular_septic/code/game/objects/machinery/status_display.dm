/obj/machinery/status_display
	icon = 'modular_septic/icons/obj/machinery/status_display.dmi'
	plane = ABOVE_FRILL_PLANE

/obj/machinery/status_display/Initialize(mapload, ndir, building)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
