/obj/structure/fireaxecabinet
	icon = 'modular_septic/icons/obj/structures/wallmounts.dmi'
	icon_state = "fireaxe_cabinet"
	base_icon_state = "fireaxe_cabinet"
	plane = GAME_PLANE_UPPER

/obj/structure/fireaxecabinet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)
