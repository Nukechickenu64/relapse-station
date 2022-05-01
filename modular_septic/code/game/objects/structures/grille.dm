/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window_frill.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	plane = GAME_PLANE_UPPER
	frill_plane = FRILL_PLANE_LOW
	layer = GRILLE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLES)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_GRILLES)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/update_appearance(updates)
	. = ..()
	if(islowwallturf(loc))
		pixel_y = WINDOW_ON_FRAME_Y_OFFSET
	else
		pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
