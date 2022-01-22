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

/obj/item/ammo_casing/add_notes_ammo()
	var/list/readout = list()
	readout += span_notice("<b>Caliber:</b> [caliber]")

	// Try to get a projectile to derive stats from
	var/obj/projectile/exam_proj = GLOB.proj_by_path_key[projectile_type]
	if(!istype(exam_proj) || (pellets == 0))
		return readout
	readout += span_notice("<b>Projectile Damage:</b> [exam_proj.damage]")
	readout += span_notice("<b>Projectile Damage Type:</b> [capitalize_like_old_man(exam_proj.damage_type)]")
	readout += span_notice("<b>Projectile Sharpness:</b> [capitalize_like_old_man(translate_sharpness(exam_proj.get_sharpness()))]")
	return readout.Join("\n")
