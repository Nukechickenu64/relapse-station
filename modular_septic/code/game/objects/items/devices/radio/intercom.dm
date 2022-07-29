/obj/item/radio/intercom
	icon = 'modular_septic/icons/obj/machinery/intercom.dmi'
	icon_state = "intercom"
	base_icon_state = "intercom"
	plane = GAME_PLANE_UPPER

/obj/item/radio/intercom/Initialize(mapload, ndir, building)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
