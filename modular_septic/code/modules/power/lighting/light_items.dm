/obj/item/light

/obj/item/light/on_entered(datum/source, mob/living/entered)
	if(istype(entered) && !((entered.movement_type & FLYING|FLOATING) || entered.buckled))
		playsound(src, pick('modular_septic/sound/effects/glass1.wav', 'modular_septic/sound/effects/glass2.wav'), HAS_TRAIT(moving_mob, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
		if((status == LIGHT_BURNED) || (status == LIGHT_OK))
			shatter()
