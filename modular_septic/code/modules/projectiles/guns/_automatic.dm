/obj/item/gun/ballistic/automatic
	var/fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	var/fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'

/obj/item/gun/ballistic/automatic/burst_select()
	var/mob/living/carbon/human/user = usr
	select = !select
	if(!select)
		burst_size = 1
		fire_delay = 0
		to_chat(user, span_notice("I switch to semi-automatic."))
		playsound(user, fireselector_semi, 100, TRUE)
	else
		burst_size = initial(burst_size)
		fire_delay = initial(fire_delay)
		to_chat(user, span_notice("I switch to [burst_size]-round burst."))
		playsound(user, fireselector_auto, 100, TRUE)

	update_appearance()
	update_action_buttons()
