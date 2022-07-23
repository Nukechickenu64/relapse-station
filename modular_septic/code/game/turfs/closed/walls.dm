/turf/closed/wall
	icon = 'modular_septic/icons/turf/tall/walls/victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/victorian_frill.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	clingable = TRUE
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_LOW_WALLS)

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wood.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/wood_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"

/turf/closed/wall/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].ogg"

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
