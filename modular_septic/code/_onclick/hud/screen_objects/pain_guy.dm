//pain guy
/atom/movable/screen/human/pain
	name = "pain"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "pain0"
	base_icon_state = "pain"
	screen_loc = ui_pain

/atom/movable/screen/human/pain/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/C = usr
	if(istype(C))
		C.print_pain()
