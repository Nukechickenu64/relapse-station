/datum/status_effect/gakster_dissociative_identity_disorder
	id = "DID"
	duration = -1
	tick_interval = 2
	alert_type = null

/datum/status_effect/gakster_dissociative_identity_disorder/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_GAKSTER, TRAIT_STATUS_EFFECT(id))
	owner.playsound_local(owner, 'modular_septic/sound/effects/stream.wav', 60)
	to_chat(owner, span_warning("I feel myself going insane! So nice!"))
	owner.hud_used.gakster = new()

/datum/status_effect/gakster_dissociative_identity_disorder/on_remove()
	owner.playsound_local(owner, 'modular_septic/sound/effects/tiktok_camera.wav', 60)
	to_chat(owner, span_warning("I feel myself going sane! So good!"))
	qdel(owner.hud_used?.gakster)

/datum/status_effect/gakster_dissociative_identity_disorder/tick(delta_time, times_fired)
	if(!owner)
		return
	handle_gakster()

/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster()
	INVOKE_ASYNC(owner, .proc/handle_gakster_screenflash)
	INVOKE_ASYNC(owner, .proc/handle_gakster_objectedge)

/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster_screenflash()
	//Standard screen flash annoyance.3025
	if(!HAS_TRAIT(owner, TRAIT_GAKSTER))
		return
	if(prob(2))
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
	
/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster_objectedge()
	var/list/objects = list()
	if(!HAS_TRAIT(owner, TRAIT_GAKSTER))
		return
	if(prob(4))
		for(var/obj/O in view(owner))
			objects += O
		if(length(objects))
			var/message
			if(prob(66) || !length(owner.last_words))
				var/list/gakster_object = GLOB.gakster_object.Copy()
				gakster_object |= "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
				message = pick(gakster_object)
			else
				message = owner.last_words
			message = replacetext_char(message, "SRC", "[owner.real_name]")
			message = replacetext_char(message, "CAPITALIZEME", "[uppertext(owner.real_name)]")
			var/obj/speaker = pick(objects)
			if(speaker && message)
				var/speak_sound = pick(
								'modular_septic/sound/insanity/hoom.wav',
								'modular_septic/sound/insanity/hoom2.wav',
								'modular_septic/sound/insanity/hoom3.wav',
								)
				owner.playsound_local(get_turf(owner), speak_sound, 50, 0)
				var/new_message = owner.compose_message(speaker, owner.language_holder?.selected_language, message)
				to_chat(owner, new_message)
				owner.create_chat_message(speaker, null, message)
