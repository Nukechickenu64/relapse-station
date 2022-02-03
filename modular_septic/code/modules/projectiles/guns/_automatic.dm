/obj/item/gun/ballistic/automatic
	var/fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	// The sound effect for switching your gun back to semi-automatic.
	var/fireselector_semi_vary = FALSE
	var/fireselector_semi_volume = 90
	var/fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	// The sound effect for switching your gun to burst fire.
	var/fireselector_auto_vary = FALSE
	var/fireselector_auto_volume = 90

/obj/item/gun/ballistic/automatic/burst_select()
	var/mob/living/carbon/human/user = usr
	select = !select
	if(!select)
		burst_size = 1
		fire_delay = 0
		to_chat(user, span_notice("I switch to semi-automatic."))
		playsound(user, fireselector_semi, fireselector_semi_volume, fireselector_semi_vary)
	else
		burst_size = initial(burst_size)
		fire_delay = initial(fire_delay)
		to_chat(user, span_notice("I switch to [burst_size]-round burst."))
		playsound(user, fireselector_auto, fireselector_auto_volume, fireselector_auto_vary)

	update_appearance()
	update_action_buttons()
