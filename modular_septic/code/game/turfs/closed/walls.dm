/turf/closed/wall
	icon = 'modular_septic/icons/turf/new/walls/metal.dmi'
	frill_icon = 'modular_septic/icons/turf/new/walls/metal_frill.dmi'
	clingable = TRUE

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/walls/reinforced_wall.dmi'

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
