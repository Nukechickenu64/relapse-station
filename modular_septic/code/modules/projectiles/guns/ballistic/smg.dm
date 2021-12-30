// c20r
/obj/item/gun/ballistic/automatic/c20r
	pin = /obj/item/firing_pin

// m90
/obj/item/gun/ballistic/automatic/m90
	pin = /obj/item/firing_pin

// kriss vector
/obj/item/gun/ballistic/automatic/vector
	name = "\improper \"Chris Kektor\" smg"
	desc = "An unconventional, ancient-designed sub-machine gun renowned for an accelerated rate of fire, reduced recoil and magazine size. \
		Proudly manufactured by Godheavy Industries'."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
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
	mag_display = TRUE
	mag_display_ammo = FALSE
	empty_indicator = FALSE

// ppsh
/obj/item/gun/ballistic/automatic/ppsh
	name = "\improper Papasha SMG"
	desc = "Despite the dated appearance the Papasha is more of a machine pistol than an SMG, the unreliable drum magazine being discarded by the Death Sec Unit decades ago due to many mechanical faults."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	icon_state = "ppsh"
	mag_type = /obj/item/ammo_box/magazine/ppsh9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	fire_delay = 2
	burst_size = 3
	mag_display = TRUE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
