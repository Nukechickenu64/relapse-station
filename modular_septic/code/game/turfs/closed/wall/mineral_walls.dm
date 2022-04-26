/turf/closed/wall/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wooden.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/wooden_frill.dmi'

/turf/closed/wall/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].wav"
