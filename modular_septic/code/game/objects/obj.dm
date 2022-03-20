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

/**
 * This returns the damage for one given attack with this object, taking into account the base variation and
 * the strength driven variation.
 * Damage will never exceed max_force and will never be below zero.
 *
 * Formulas:
 * Minimum damage = min_force + (min_force_strength * strength_value)
 * Maximum damage = force + (force_strength * strength_value)
 */
/obj/proc/get_force(mob/living/user, strength_value = ATTRIBUTE_MIDDLING)
	var/final_force = rand(min_force*10, force*10)/10
	/// Fraggots are always considered to have absolutely 0 strength
	if(!user || !HAS_TRAIT(user, TRAIT_FRAGGOT))
		var/strength_multiplier = CEILING(rand(min_force_strength*10, force_strength*10)/10, DAMAGE_PRECISION)
		/**
		 * If the multiplier is negative, we instead punish the dude for each point of strength below ATTRIBUTE_MASTER
		 * You really shouldn't make this possible though as it makes understanding the damage of an item even more insane.
		 */
		if(strength_multiplier < 0)
			final_force += (strength_value - ATTRIBUTE_MASTER) * strength_multiplier
		/// Otherwise, elementary multiplier stuff
		else
			final_force += strength_value * strength_multiplier

	return clamp(FLOOR(final_force, DAMAGE_PRECISION), 0, max_force)
