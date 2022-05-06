/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	plane = GAME_PLANE_MIDDLE
	layer = GRILLE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLES)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_GRILLES)
	/// Whether or not this is a grille that goes above windows
	var/window_grille = FALSE

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/update_icon_state()
	. = ..()
	var/damage_state = ""
	var/damage_percentage = clamp(CEILING((1 - atom_integrity/max_integrity) * 100, 25), 0, 75)
	if(window_grille && (damage_percentage >= 25))
		damage_state = "-d[damage_percentage]"
	else if(damage_percentage >= 50)
		damage_state = "-d50"
	if(!isnull(smoothing_junction) && (smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK)))
		icon_state = "[base_icon_state][damage_state]-[smoothing_junction]"
	else
		icon_state = "[base_icon_state][damage_state]"

/obj/structure/grille/set_smoothed_icon_state(new_junction)
	. = smoothing_junction
	smoothing_junction = new_junction
	update_appearance(UPDATE_ICON)
	var/damage_state = ""
	var/damage_percentage = clamp(CEILING((1 - atom_integrity/max_integrity) * 100, 25), 0, 75)
	if(window_grille && (damage_percentage >= 25))
		damage_state = "-d[damage_percentage]"
	else if(damage_percentage >= 50)
		damage_state = "-d50"
	SEND_SIGNAL(src, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, new_junction, "[base_icon_state][damage_state]")

/obj/structure/grille/Moved(atom/OldLoc, Dir)
	. = ..()
	update_nearby_icons()

/obj/structure/grille/proc/update_nearby_icons()
	update_appearance()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/structure/grille/window
	name = "window grille"
	desc = "A simple, fragile grille that protects windows."
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/grille_window_frill.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	plane = GAME_PLANE_MIDDLE
	layer = WINDOW_GRILLE_LAYER
	upper_frill_plane = FRILL_PLANE_LOW
	upper_frill_layer = ABOVE_MOB_LAYER
	lower_frill_plane = GAME_PLANE_MIDDLE
	lower_frill_layer = ABOVE_WINDOW_GRILLE_LAYER
	frill_uses_icon_state = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_GRILLES_WINDOW)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_GRILLES_WINDOW)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
	window_grille = TRUE
