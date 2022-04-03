/datum/controller/subsystem/explosions/proc/shake_the_room(turf/epicenter, near_distance, far_distance, quake_factor, echo_factor, creaking, sound/near_sound = sound(get_sfx("explosion")), sound/far_sound = sound('modular_septic/sound/effects/explosionfar.wav'), sound/echo_sound = sound('modular_septic/sound/effects/explosion_distant.wav'), sound/creaking_sound = sound(get_sfx("explosion_creaking")), hull_creaking_sound = sound(get_sfx("hull_creaking")))
	var/frequency = get_rand_frequency()
	var/blast_z = epicenter.z
	if(isnull(creaking)) // Autoset creaking.
		var/on_station = SSmapping.level_trait(epicenter.z, ZTRAIT_STATION)
		if(on_station && prob((quake_factor * QUAKE_CREAK_PROB) + (echo_factor * ECHO_CREAK_PROB))) // Huge explosions are near guaranteed to make the station creak and whine, smaller ones might.
			creaking = TRUE // prob over 100 always returns true
		else
			creaking = FALSE

	for(var/mob/listener as anything in GLOB.player_list)
		var/turf/listener_turf = get_turf(listener)
		if(!listener_turf || listener_turf.z != blast_z)
			continue

		var/distance = get_dist(epicenter, listener_turf)
		if(epicenter == listener_turf)
			distance = 0
		var/base_shake_amount = sqrt(near_distance / (distance + 1))

		if(distance <= round(near_distance + world.view - 2, 1)) // If you are close enough to see the effects of the explosion first-hand (ignoring walls)
			listener.playsound_local(epicenter, null, 100, TRUE, frequency, S = near_sound)
			if(base_shake_amount > 0)
				shake_camera(listener, NEAR_SHAKE_DURATION, clamp(base_shake_amount, 0, NEAR_SHAKE_CAP))

		else if(distance < far_distance) // You can hear a far explosion if you are outside the blast radius. Small explosions shouldn't be heard throughout the station.
			var/far_volume = clamp(far_distance / 2, FAR_LOWER, FAR_UPPER)
			if(creaking)
				listener.playsound_local(epicenter, null, far_volume, TRUE, frequency, S = creaking_sound, distance_multiplier = 0)
			else if(prob(FAR_SOUND_PROB)) // Sound variety during meteor storm/tesloose/other bad event
				listener.playsound_local(epicenter, null, far_volume, TRUE, frequency, S = far_sound, distance_multiplier = 0)
			else
				listener.playsound_local(epicenter, null, far_volume, TRUE, frequency, S = echo_sound, distance_multiplier = 0)

			if(base_shake_amount || quake_factor)
				base_shake_amount = max(base_shake_amount, quake_factor * 3, 0) // Devastating explosions rock the station and ground
				shake_camera(listener, FAR_SHAKE_DURATION, min(base_shake_amount, FAR_SHAKE_CAP))

		else if(!isspaceturf(listener_turf) && echo_factor) // Big enough explosions echo through the hull.
			var/echo_volume
			if(quake_factor)
				echo_volume = 60
				shake_camera(listener, FAR_SHAKE_DURATION, clamp(quake_factor / 4, 0, FAR_SHAKE_CAP))
			else
				echo_volume = 40
			listener.playsound_local(epicenter, null, echo_volume, TRUE, frequency, S = echo_sound, distance_multiplier = 0)

		if(creaking) // 5 seconds after the bang, the station begins to creak
			addtimer(CALLBACK(listener, /mob/proc/playsound_local, epicenter, null, rand(FREQ_LOWER, FREQ_UPPER), TRUE, frequency, null, null, FALSE, hull_creaking_sound, 0), CREAK_DELAY)

#undef CREAK_DELAY
#undef QUAKE_CREAK_PROB
#undef ECHO_CREAK_PROB
#undef FAR_UPPER
#undef FAR_LOWER
#undef FAR_SOUND_PROB
#undef NEAR_SHAKE_CAP
#undef FAR_SHAKE_CAP
#undef NEAR_SHAKE_DURATION
#undef FAR_SHAKE_DURATION
#undef FREQ_UPPER
#undef FREQ_LOWER
