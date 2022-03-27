/turf/closed
	plane = GAME_PLANE
	inspect_icon_state = "wall"
	/// Icon path - Smoothing objects larger than 32x32 require a visual object to represent the excess part, in order not to increase its hitbox. We call that a frill.
	var/frill_icon

/turf/closed/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/ric_stone[rand(1,3)].wav"
