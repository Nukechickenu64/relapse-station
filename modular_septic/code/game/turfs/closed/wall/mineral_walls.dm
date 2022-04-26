/turf/closed/wall/mineral/wood
	icon = 'modular_septic/icons/turf/tall/walls/wood.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/wood_frill.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"

/turf/closed/wall/mineral/wood/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_wood[rand(1,4)].wav"
