/obj/structure/window
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "window"
	base_icon_state = "window"
	plane = GAME_PLANE_UPPER
	layer = WINDOW_LAYER

/obj/structure/window/fulltile
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/window_frill.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	plane = GAME_PLANE_WINDOW
	layer = WINDOW_FULLTILE_LAYER
	upper_frill_plane = FRILL_WINDOW_PLANE
	upper_frill_layer = ABOVE_MOB_LAYER
	lower_frill_plane = GAME_PLANE_WINDOW
	lower_frill_layer = ABOVE_WINDOW_FULLTILE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET

/obj/structure/window/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/window/Moved(atom/OldLoc, Dir)
	. = ..()
	update_appearance()

/obj/structure/window/update_icon(updates)
	. = ..()
	if(!fulltile)
		return

	if(islowwallturf(loc))
		pixel_y = WINDOW_ON_FRAME_Y_OFFSET
	else
		pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
