/turf/closed/wall
	icon = 'modular_septic/icons/turf/new/walls/iron.dmi'
	frill_icon = 'modular_septic/icons/turf/new/walls/iron_frill.dmi'
	clingable = TRUE

/turf/closed/wall/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_metal[rand(1,5)].wav"

/turf/closed/wall/r_wall
	icon = 'modular_septic/icons/turf/new/walls/reinforced_iron.dmi'
	frill_icon = 'modular_septic/icons/turf/new/walls/reinforced_iron_frill.dmi'

//Example smooth wall
/turf/closed/wall/smooth
	frill_icon = null
