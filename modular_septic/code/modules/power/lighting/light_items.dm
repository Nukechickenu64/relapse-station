/obj/item/light
    var/glass_sound = list('modular_septic/sound/effects/glass1.wav', 'modular_septic/sound/effects/glass2.wav')

/obj/item/light/proc/on_entered(datum/source, atom/movable/moving_atom)
	SIGNAL_HANDLER
	if(!isliving(moving_atom))
		return
	var/mob/living/moving_mob = moving_atom
	if(!(moving_mob.movement_type & (FLYING|FLOATING)) || moving_mob.buckled)
		playsound(src, glass_sound, HAS_TRAIT(moving_mob, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
		if(status == LIGHT_BURNED || status == LIGHT_OK)
			shatter()

