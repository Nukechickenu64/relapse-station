/datum/status_effect/thug_shaker
	id = "thugshaker"
	duration = -1
	tick_interval = 2
	alert_type = null
	var/intensity = 1
	var/shake_prob = 15
	var/interupt_interval = 5

/datum/status_effect/thug_shaker/tick()
	handle_thug_shaker()

/datum/status_effect/thug_shaker/proc/handle_thug_shaker()
	if(owner.combat_mode)
		INVOKE_ASYNC(src, .proc/handle_screenshake)

/datum/status_effect/thug_shaker/proc/handle_screenshake()
	var/client/C = owner.client
	var/shakeit = 0
	while(shakeit < 10)
		if(prob(shake_prob))
			sleep(interupt_interval)
		shakeit++
		animate(C, pixel_y = intensity, time = intensity/1, flags = ANIMATION_RELATIVE)
		sleep(intensity/2)
		animate(C, pixel_y = -intensity, time = intensity/1, flags = ANIMATION_RELATIVE)
		sleep(intensity/2)
