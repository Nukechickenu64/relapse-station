/obj/structure/noticeboard
	icon = 'modular_septic/icons/obj/stationobjs.dmi'
	icon_state = "noticeboard"
	base_icon_state = "noticeboard"

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)
