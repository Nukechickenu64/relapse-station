/turf/closed/wall
	icon = 'modular_septic/icons/turf/tall/walls/iron.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/iron_frill.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_iron.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/reinforced_iron_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
