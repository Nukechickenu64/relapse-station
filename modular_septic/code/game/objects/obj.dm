/obj/Initialize(mapload)
	. = ..()
	if(isnull(min_force))
		min_force = force

/obj/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 80)
	rammer.sound_hint()
	sound_hint()
	take_damage(GET_MOB_ATTRIBUTE_VALUE(rammer, STAT_STRENGTH))

/// This returns the damage for a given attack with this object
/obj/proc/get_force(mob/living/user)
	var/final_force = rand(min_force, force)
	if(user?.attributes)
		var/strength = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
		var/strength_multiplier = CEILING(rand(min_force_strength*10, force_strength*10)/10, 0.1)
		/// If the multiplier is negative, we instead punish the dude for each point of strength below ATTRIBUTE_MASTER
		if(strength_multiplier < 0)
			final_force += (strength - ATTRIBUTE_MASTER) * strength_multiplier
		/// Otherwise, elementary stuff
		else
			final_force += strength * strength_multiplier

	return clamp(FLOOR(final_force, DAMAGE_PRECISION), 0, max_force)
