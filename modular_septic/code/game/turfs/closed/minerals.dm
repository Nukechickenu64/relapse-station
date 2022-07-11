/turf/closed/mineral
	clingable = TRUE

/turf/closed/mineral/snowmountain/nevado_surface
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	turf_type = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = NEVADO_SURFACE_DEFAULT_ATMOS

/turf/closed/mineral/shale
	icon = 'modular_septic/icons/turf/tall/shale.dmi'
	smooth_icon = 'modular_septic/icons/turf/tall/shale.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/shale_frill.dmi'
	icon_state = "shale-0"
	base_icon_state = "shale"
	plane = GAME_PLANE
	layer = CLOSED_TURF_LAYER
	environment_type = "shale"
	needs_translation = FALSE

/turf/closed/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wood.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

/turf/closed/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"
