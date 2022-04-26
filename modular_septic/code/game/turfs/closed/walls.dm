/turf/closed/wall
	icon = 'modular_septic/icons/turf/tall/walls/iron.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/iron_frill.dmi'
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_iron.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/reinforced_iron_frill.dmi'

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
