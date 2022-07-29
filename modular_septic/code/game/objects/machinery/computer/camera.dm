/obj/machinery/computer/security/telescreen
	icon = 'modular_septic/icons/obj/machinery/telescreen.dmi'
	icon_state = "telescreen"
	base_icon_state = "telescreen"
	plane = ABOVE_FRILL_PLANE

/obj/machinery/computer/security/telescreen/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
	update_appearance()
