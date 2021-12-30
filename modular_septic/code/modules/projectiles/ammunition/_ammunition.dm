/obj/item/ammo_casing
	carry_weight = 0.02
	/// Add this to the projectile diceroll modifiers of whatever we fire
	var/diceroll_modifier = 0
	/// Add this to the projectile diceroll modifiers of whatever we fire, but ONLY against a specified target
	var/list/target_specific_diceroll

/obj/item/ammo_casing/bounce_away(still_warm, bounce_delay)
	if(!heavy_metal)
		return
	update_appearance()
	do_messy()
	SpinAnimation(10, 1)
	var/turf/bouncer = drop_location()
	if(still_warm && bouncer?.bullet_sizzle)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.
	else if(bouncer?.bullet_bounce_sound)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, bouncer.bullet_bounce_sound, 20, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.
