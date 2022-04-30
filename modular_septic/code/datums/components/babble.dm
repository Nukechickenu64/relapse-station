#define MAX_BABBLE_CHARACTERS 40

/datum/component/babble
	var/babble_sound = 'modular_septic/sound/effects/babble/babble1.wav'
	var/duration = 1
	var/volume = 80
	var/last_babble = 0

/datum/component/babble/Initialize(babble_sound = 'modular_septic/sound/effects/babble/babble1.wav', duration = 1, volume = 80)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	src.babble_sound = babble_sound
	src.duration = duration
	src.volume = volume

/datum/component/babble/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_POST_SAY, .proc/after_say)

/datum/component/babble/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_POST_SAY)

/datum/component/babble/proc/after_say(mob/babbler, list/speech_args)
	SIGNAL_HANDLER

	last_babble = world.time
	INVOKE_ASYNC(src, .proc/handle_babbling, babbler, speech_args[SPEECH_MESSAGE])

/datum/component/babble/proc/handle_babbling(mob/babbler, message = "")
	var/initial_babble_time = last_babble
	for(var/i in 1 to min(length(message), MAX_BABBLE_CHARACTERS))
		// they sent a message while we were babbling, do that instead
		if(last_babble != initial_babble_time)
			continue
		var/sleep_duration = src.duration
		var/volume = src.volume
		var/pitch = 0
		switch(lowertext(message[i]))
			if("!")
				pitch = 15
			if("a")
				pitch = 12
			if("b")
				pitch = 11
			if("c")
				pitch = 10
			if("d")
				pitch = 9
			if("e")
				pitch = 8
			if("f")
				pitch = 7
			if("g")
				pitch = 6
			if("h")
				pitch = 5
			if("i")
				pitch = 4
			if("j")
				pitch = 3
			if("k")
				pitch = 2
			if("m")
				pitch = 1
			if("n")
				pitch = -1
			if("o")
				pitch = -2
			if("p")
				pitch = -3
			if("q")
				pitch = -4
			if("r")
				pitch = -5
			if("s")
				pitch = -6
			if("t")
				pitch = -6
			if("u")
				pitch = -7
			if("v")
				pitch = -8
			if("w")
				pitch = -9
			if("x")
				pitch = -10
			if("y")
				pitch = -11
			if("z")
				pitch = -12
			if("?")
				pitch = -15
			if(" ")
				volume = 0
			if(",", ";", "-")
				pitch = -2
				sleep_duration *= 1.5
			if(".")
				pitch = -3
				sleep_duration *= 2
			else
				pitch = 0
		playsound(babbler.loc, pick(babble_sound), volume, frequency = pitch)
		sleep(sleep_duration)

#undef MAX_BABBLE_CHARACTERS
