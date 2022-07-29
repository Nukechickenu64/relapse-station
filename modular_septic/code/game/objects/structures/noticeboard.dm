/obj/structure/noticeboard
	icon = 'modular_septic/icons/obj/stationobjs.dmi'
	icon_state = "noticeboard"
	base_icon_state = "noticeboard"
	plane = ABOVE_FRILL_PLANE

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
