/obj/machinery/button
	icon = 'modular_septic/icons/obj/stationobjs.dmi'

/obj/machinery/button/Initialize(mapload, ndir, built)
	. = ..()
	AddElement(/datum/element/wall_mount)
