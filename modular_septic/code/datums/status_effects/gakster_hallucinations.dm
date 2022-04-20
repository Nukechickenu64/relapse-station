/datum/status_effect/gakster_dissociative_identity_disorder
    id = "DID"

/datum/status_effect/gakster_dissociative_identity_disorder/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_GAKSTER, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/gakster_dissociative_identity_disorder/on_mob_life(mob/living/carbon/spawned_human, delta_time, times_fired)
	if(!(HAS_TRAIT(spawned_human, TRAIT_GAKSTER)))
		return
	if(DT_PROB(2, delta_time))
		INVOKE_ASYNC(src, .proc/handle_gakster_hallucinations, spawned_human)

/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster_hallucinations(mob/living/gakster)
	//Standard screen flash annoyance.3025
	if(HAS_TRAIT(gakster, TRAIT_GAKSTER) && prob(2))
		var/atom/movable/screen/fullscreen/gakster/gakster = owner.current.hud_used?.gakster
			icon_state = "hall[rand(1,3)]"
			animate(gakster, alpha = 255, time = 2)
			spawn(2)
				var/hallsound = pick(
									'modular_septic/sound/insanity/glitchloop.wav',
									'modular_septic/sound/insanity/glitchloop2.wav',
									'modular_septic/sound/insanity/glitchloop3.wav',
									)
				gakster.current.playsound_local(get_turf(gakster.current), hallsound, 100, FALSE)
				spawn(1)
