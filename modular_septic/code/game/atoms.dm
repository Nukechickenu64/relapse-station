/atom/Initialize(mapload, ...)
	. = ..()
	if(uses_integrity)
		if(islist(subarmor))
			subarmor = getSubarmor(arglist(subarmor))
		else if(!subarmor)
			subarmor = getSubarmor()
		else if(!istype(subarmor, /datum/subarmor))
			stack_trace("Invalid type [subarmor.type] found in .subarmor during /atom Initialize()")

// Thrown stuff only bounced in no gravity for some reason, i have fixed this blunder!
/atom/hitby(atom/movable/thrown_atom, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	SEND_SIGNAL(src, COMSIG_ATOM_HITBY, thrown_atom, skipcatch, hitpush, blocked, throwingdatum)
	if(density)
		sound_hint()
		addtimer(CALLBACK(src, .proc/hitby_react, thrown_atom, throwingdatum.speed), 2)

/atom/hitby_react(atom/movable/thrown_atom, speed = 0)
	if(thrown_atom && !QDELETED(thrown_atom) && isturf(thrown_atom.loc) && !thrown_atom.anchored)
		if(isitem(thrown_atom))
			var/obj/item/item = thrown_atom
			item.undo_messy()
			item.do_messy(duration = 4)
		step(thrown_atom, turn(thrown_atom.dir, 180))
		if(ismob(src) || ismob(thrown_atom))
			playsound(src, 'modular_septic/sound/effects/colision_bodyalt.ogg', 65, 0)
		else
			playsound(src, pick('modular_septic/sound/effects/colision1.ogg', 'modular_septic/sound/effects/colision2.ogg', 'modular_septic/sound/effects/colision3.ogg', 'modular_septic/sound/effects/colision4.ogg'), 65, 0)

/// Used to add or reduce germ level on an atom
/atom/proc/adjust_germ_level(add_germs, minimum_germs = 0, maximum_germs = GERM_LEVEL_MAXIMUM)
	germ_level = clamp(germ_level + add_germs, minimum_germs, maximum_germs)

/// Force set the germ level
/atom/proc/set_germ_level(germs)
	var/delta = (germs - germ_level)
	return adjust_germ_level(delta)

/// Ramming into walls (TODO: Turn into element!)
/atom/proc/on_rammed(mob/living/carbon/rammer)
	return FALSE

/// Returns a hitsound for when a projectile impacts us
/atom/proc/get_projectile_hitsound(obj/projectile/projectile)
	return projectile.hitsound
