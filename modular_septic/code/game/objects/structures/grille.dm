/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/structures.dmi'
	plane = GAME_PLANE_UPPER
	layer = GRILLE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE)

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/update_appearance(updates)
	. = ..()
	if(islowwallturf(loc))
		pixel_y = WINDOW_ON_FRAME_Y_OFFSET
	else
		pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
