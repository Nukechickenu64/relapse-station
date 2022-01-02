// c20r
/obj/item/gun/ballistic/automatic/c20r
	pin = /obj/item/firing_pin

// m90
/obj/item/gun/ballistic/automatic/m90
	pin = /obj/item/firing_pin


// kriss vector
/obj/item/gun/ballistic/automatic/remis/vector
	name = "\improper \"Chris Kektor\" submachine gun"
	desc = "An unconventional, ancient-designed sub-machine gun renowned for an accelerated rate of fire, reduced recoil and magazine size. \
		Proudly manufactured by Godheavy Industries'."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	base_icon_state = "vector"
	icon_state = "vector"
	rack_sound = 'modular_septic/sound/weapons/guns/smg/vector_rack.ogg'
	pickup_sound = 'modular_septic/sound/weapons/guns/smg/vector_draw.ogg'
	fire_sound = list('modular_septic/sound/weapons/guns/smg/vector1.ogg', \
					'modular_septic/sound/weapons/guns/smg/vector2.ogg')
	mag_type = /obj/item/ammo_box/magazine/m45vector
	weapon_weight = WEAPON_MEDIUM
	force = 10
	fire_delay = 1
	burst_size = 4

// ppsh
/obj/item/gun/ballistic/automatic/remis/ppsh
	name = "\improper Papasha SMG"
	desc = "Despite the dated appearance the Papasha is more of a machine pistol than an SMG, the unreliable drum magazine being discarded by the Death Sec Unit decades ago due to many mechanical faults."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	base_icon_state = "ppsh"
	icon_state = "ppsh"
	mag_type = /obj/item/ammo_box/magazine/ppsh9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	fire_delay = 2
	burst_size = 3

//hksmg
/obj/item/gun/ballistic/automatic/remis/solitario
	name = "\improper Solitario e Inseguro R5 submachine gun"
	desc = "A reliable submachine gun with a high-magazine capacity maufactured by popular civilian arms dealer S&I"
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	inhand_icon_state = "hksmg"
	base_icon_state = "hksmg"
	icon_state = "hksmg"
	rack_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_rack.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/hksmg.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_silenced.wav'
	mag_type =	/obj/item/ammo_box/magazine/hksmg22lr
	weapon_weight = WEAPON_LIGHT
	force = 10
	recoil = 0.2
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 9
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 2)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
