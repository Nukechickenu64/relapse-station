/obj/item/shard
    var/glass_sound = list('modular_septic/sound/effects/glass1.wav', 'modular_septic/sound/effects/glass2.wav')

/obj/item/shard/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(isliving(AM))
		var/mob/living/L = AM
		if(!(L.movement_type & (FLYING|FLOATING)) || L.buckled)
			playsound(src, glass_sound, HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)
