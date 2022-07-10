/obj/machinery/broken_ventilation
	name = "broken vent"
	desc = "Some holes in the wall to cycle air around the warehouse, looks like it hasn't been maintained for years, but it still runs."
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "vents"
	base_icon_state = "vents"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE

/obj/machinery/broken_ventilation/north
	// Infared didn't draw directionals.
	pixel_y = 30
