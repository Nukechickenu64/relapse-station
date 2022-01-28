// c20r
/obj/item/gun/ballistic/automatic/c20r
	pin = /obj/item/firing_pin
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_SMG

// m90
/obj/item/gun/ballistic/automatic/m90
	pin = /obj/item/firing_pin
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_SMG

/obj/item/gun/ballistic/automatic/remis/smg
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_SMG

// kriss vector
/obj/item/gun/ballistic/automatic/remis/smg/vector
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
	custom_price = 5000

// ppsh
/obj/item/gun/ballistic/automatic/remis/smg/ppsh
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
	custom_price = 4000

// hksmg
/obj/item/gun/ballistic/automatic/remis/smg/solitario
	name = "\improper Solitario Inseguro R5 submachine gun"
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
	custom_price = 10000

/obj/item/gun/ballistic/automatic/remis/smg/bastardo
	name = "\improper Feio Bastardo R1 submachine gun"
	desc = "A fully-automatic submachine gun issued to ZoomTech officers and military force with an accelerated fire delay, comes with a folding stock, and a threaded barrel for suppression."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	inhand_icon_state = "vityaz"
	base_icon_state = "vityaz"
	icon_state = "vityaz"
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/vityaz_silenced.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/vityaz.wav'
	mag_type =	/obj/item/ammo_box/magazine/bastardo9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	recoil = 0.2
	fire_delay = 0.8
	burst_size = 3
	can_suppress = TRUE
	suppressor_x_offset = 1
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 2)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
	custom_price = 20000

/obj/item/gun/ballistic/automatic/remis/smg/thump
	name = "\improper Cesno Thump R2 submachine gun"
	desc = "A fully-automatic submachine gun that fires in optional three-round bursts, comes with a threaded barrel, and was engineered as a direct upgrade to the Solitario to .45 ACP."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	inhand_icon_state = "ump"
	base_icon_state = "ump"
	icon_state = "ump"
	rack_sound = 'modular_septic/sound/weapons/guns/smg/thump_rack.wav'
	load_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/thump.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/thump_silenced.wav'
	mag_type =	/obj/item/ammo_box/magazine/thump45
	weapon_weight = WEAPON_MEDIUM
	force = 10
	recoil = 0.2
	fire_delay = 0.8
	burst_size = 3
	can_suppress = TRUE
	suppressor_x_offset = 6
