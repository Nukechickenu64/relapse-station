/obj/structure/extinguisher_cabinet
	icon = 'modular_septic/icons/obj/structures/wallmounts.dmi'
	icon_state = "cabinet"
	base_icon_state = "cabinet"
	plane = GAME_PLANE_UPPER

/obj/structure/extinguisher_cabinet/Initialize(mapload, ndir, building)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
	update_appearance()
