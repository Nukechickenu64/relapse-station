/obj/item/gun/ballistic/automatic
	select = 1
	/// The sound effect for switching your gun back to semi-automatic
	var/fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_semi_vary = FALSE
	var/fireselector_semi_volume = 90
	/// The sound effect for switching your gun to burst fire
	var/fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_burst_vary = FALSE
	var/fireselector_burst_volume = 90
	/// The sound effect for switching your gun to full auto fire
	var/fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_auto_vary = FALSE
	var/fireselector_auto_volume = 90
	/// Size of the burst when burst firing
	var/burst_size_toggled = 1
	var/fire_delay_toggled = 0

/obj/item/gun/ballistic/automatic/burst_select()
	var/mob/living/carbon/human/user = usr
	var/datum/component/automatic_fire/full_auto = GetComponent(/datum/component/automatic_fire)
	if(full_auto)
		switch(select)
			// semi auto
			if(1)
				if(burst_size_toggled != initial(burst_size))
					select = 2
				else
					select = 3
			// burst fire
			if(2)
				select = 3
			// full auto
			if(3)
				select = 1
	else if(burst_size_toggled != initial(burst_size))
		select = !select
	// how did this happen?
	else
		return
	switch(select)
		if(1)
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, span_notice("I switch [src] to semi-automatic."))
			playsound(user, fireselector_semi, fireselector_semi_volume, fireselector_semi_vary)
		if(2)
			burst_size = burst_size_toggled
			fire_delay = fire_delay_toggled
			to_chat(user, span_notice("I switch [src] to [burst_size]-round burst."))
			playsound(user, fireselector_burst, fireselector_burst, fireselector_burst_vary)
		if(3)
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, span_notice("I switch [src] to automatic."))
			playsound(user, fireselector_semi, fireselector_auto_volume, fireselector_semi_vary)

	update_appearance()
	update_action_buttons()
