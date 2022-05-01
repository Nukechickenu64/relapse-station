/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window_frill.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	plane = GAME_PLANE_MIDDLE
	layer = GRILLE_LAYER
	upper_frill_plane = FRILL_PLANE_LOW
	upper_frill_layer = ABOVE_MOB_LAYER
	lower_frill_plane = GAME_PLANE_MIDDLE
	lower_frill_layer = ABOVE_GRILLE_LAYER
	frill_uses_icon_state = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLES)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_GRILLES)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/set_smoothed_icon_state(new_junction)
	var/integrity = FLOOR(atom_integrity/max_integrity, 0.01)
	var/damage_state = ""
	switch(integrity)
		if(0.75 to 0.5)
			damage_state = "_d25"
		if(0.5 to 0.25)
			damage_state = "_d50"
		if(0.25 to 0)
			damage_state = "_d75"
	base_icon_state = "[initial(base_icon_state)][damage_state]"
	return ..()

/obj/structure/grille/Moved(atom/OldLoc, Dir)
	. = ..()
	update_nearby_icons()

/obj/structure/grille/proc/update_nearby_icons()
	update_appearance()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH_NEIGHBORS(src)
