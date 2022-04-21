/datum/status_effect/gakster_dissociative_identity_disorder
	id = "DID"
	duration = -1
	alert_type = null

/datum/status_effect/gakster_dissociative_identity_disorder/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_GAKSTER, TRAIT_STATUS_EFFECT(id))
	owner.playsound_local(owner, 'modular_septic/sound/effects/stream.wav', 60)
	to_chat(owner, span_warning("I feel myself going insane! So nice!"))
	hud_used.gakster = new()

/datum/status_effect/gakster_dissociative_identity_disorder/on_remove()
	owner.playsound_local(owner, 'modular_septic/sound/effects/tiktok_camera.wav', 60)
	to_chat(owner, span_warning("I feel myself going sane! So good!"))
	qdel(owner.hud_used.gakster)

/datum/status_effect/gakster_dissociative_identity_disorder/process(mob/living/carbon/spawned_human, delta_time, times_fired)
	if(!HAS_TRAIT(spawned_human, TRAIT_STATUS_EFFECT(id)))
		return
	if(DT_PROB(2, delta_time))
		INVOKE_ASYNC(src, .proc/handle_gakster_hallucinations, spawned_human)

/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster_hallucinations()
	//Standard screen flash annoyance.3025
	if(HAS_TRAIT(owner, TRAIT_GAKSTER))
		var/atom/movable/screen/fullscreen/gakster/hall = owner.hud_used?.gakster
		if(hall)
			hall.icon_state = "hall[rand(1,4)]"
			animate(hall, alpha = 255, time = 2)
			spawn(2)
				var/hallsound = pick(
									'modular_septic/sound/insanity/glitchloop.wav',
									'modular_septic/sound/insanity/glitchloop2.wav',
									'modular_septic/sound/insanity/glitchloop3.wav',
									)
				owner.playsound_local(owner, hallsound, 100, FALSE)
