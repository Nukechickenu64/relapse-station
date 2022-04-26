/obj/structure/light_construct
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'

/obj/structure/light_construct/Initialize(mapload, ndir, building)
	. = ..()
	AddElement(/datum/element/wall_mount/light_mount, ABOVE_FRILL_PLANE, GAME_PLANE_UPPER)
