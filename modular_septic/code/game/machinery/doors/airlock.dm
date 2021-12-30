/obj/machinery/door/airlock
	doorOpen = 'modular_septic/sound/machinery/airlock_open.wav'
	doorClose = 'modular_septic/sound/machinery/airlock_close.wav'
	boltUp = 'modular_septic/sound/machinery/airlock_bolt.wav'
	boltDown = 'modular_septic/sound/machinery/airlock_unbolt.wav'
	doorDeni = 'modular_septic/sound/machinery/airlock_deny.ogg'

// airlocks don't get damaged by ramming
/obj/machinery/door/airlock/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 75)
	rammer.sound_hint()
	sound_hint()
