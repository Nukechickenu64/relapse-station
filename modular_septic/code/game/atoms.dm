// I hate that i have to give fucking areas a germ level but it be like that
/atom
	/// Basically the level of dirtiness on an atom, which will spread to wounds and stuff and cause infections
	var/germ_level = GERM_LEVEL_AMBIENT

// Thrown stuff only bounced in no gravity for some reason, i have fixed this blunder!
/atom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	SEND_SIGNAL(src, COMSIG_ATOM_HITBY, AM, skipcatch, hitpush, blocked, throwingdatum)
	if(density)
		sound_hint()
		addtimer(CALLBACK(src, .proc/hitby_react, AM, throwingdatum.speed), 2)

/atom/hitby_react(atom/movable/AM, speed = 0)
	if(AM && !QDELETED(AM) && isturf(AM.loc) && !AM.anchored)
		if(isitem(AM))
			var/obj/item/item = AM
			item.undo_messy()
			item.do_messy(duration = 4)
		step(AM, turn(AM.dir, 180))
		if(ismob(src) || ismob(AM))
			playsound(src, 'modular_septic/sound/effects/colision_bodyalt.ogg', 65, 0)
		else
			playsound(src, pick('modular_septic/sound/effects/colision1.ogg', 'modular_septic/sound/effects/colision2.ogg', 'modular_septic/sound/effects/colision3.ogg', 'modular_septic/sound/effects/colision4.ogg'), 65, 0)

/// Used to add or reduce germ level on an atom
/atom/proc/adjust_germ_level(add_germs, minimum_germs = 0, maximum_germs = MAXIMUM_GERM_LEVEL)
	germ_level = clamp(germ_level + add_germs, minimum_germs, maximum_germs)

/// Force set the germ level
/atom/proc/set_germ_level(germs)
	var/delta = (germs - germ_level)
	return adjust_germ_level(delta)

/// Ramming into walls (TODO: Turn into element!)
/atom/proc/on_rammed(mob/living/carbon/rammer)
	return FALSE
