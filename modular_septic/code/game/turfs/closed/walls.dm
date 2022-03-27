/turf/closed/wall
	icon = 'modular_septic/icons/turf/walls/wall.dmi'
	clingable = TRUE

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/walls/reinforced_wall.dmi'
