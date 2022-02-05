// Remove this dumb knockback shit pls
/obj/item/gun/ballistic/shotgun
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "ithaca"
	base_icon_state = "ithaca"
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_righthand.dmi'
	inhand_icon_state = "ithaca"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	empty_icon_state = TRUE
	wielded_inhand_state = TRUE
	sawn_inhand_state = TRUE
	suppressed = SUPPRESSED_NONE
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	equip_sound = list('modular_septic/sound/weapons/guns/rifle/rifle_holster1.wav', 'modular_septic/sound/weapons/guns/rifle/rifle_holster2.wav')
	worn_icon_state = "shotgun"
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_silenced.wav'
	pickup_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_draw.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_lock_back.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_cycle.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/safety2.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/safety2.ogg'
	load_sound = list('modular_septic/sound/weapons/guns/shotgun/shotgun_load.wav',
					 'modular_septic/sound/weapons/guns/shotgun/shotgun_load2.wav')
	safety_off_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_safety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_safety1.wav'
	gunshot_animation_information = list("pixel_x" = 24, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -5)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	force = 12
	pb_knockback = 0
	can_suppress = TRUE
	suppressor_x_offset = 13
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_SHOTGUN

// DOUBLE BARRELED SHOTGUN
/obj/item/gun/ballistic/shotgun/doublebarrel
	pb_knockback = 0
	empty_icon_state = FALSE

// ITHACA SHOTGUN
/obj/item/gun/ballistic/shotgun/ithaca
	name = "\improper ITOBE modelo 37 shotgun"
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "ithaca"
	base_icon_state = "ithaca"
	empty_indicator = FALSE
	empty_icon_state = TRUE

// ??? SHOTGUN
/obj/item/gun/ballistic/shotgun/riot
	name = "\improper Peneloppe Sit-Down shotgun"
	desc = "A sturdy shotgun with a longer magazine and a fixed tactical stock designed for \"non-lethal\" riot control."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "riot"
	base_icon_state = "riot"
	inhand_icon_state = "riot"
	empty_indicator = FALSE
	empty_icon_state = TRUE
	gunshot_animation_information = list("pixel_x" = 25, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -4)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	suppressor_x_offset = 14

// BENELLI M4 SHOTGUN
/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "\improper Peneloppe CYM shotgun"
	desc = "A semi automatic shotgun with tactical furniture and a six-shell(+1) capacity underneath."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "combat"
	base_icon_state = "combat"
	inhand_icon_state = "combat"
	can_flashlight = TRUE
	flight_x_offset = 24
	flight_y_offset = 10
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lock_back.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = list('modular_septic/sound/weapons/guns/shotgun/comgun1.wav',
					'modular_septic/sound/weapons/guns/shotgun/comgun2.wav')
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_silenced.wav'
	empty_indicator = FALSE
	empty_icon_state = TRUE
	gunshot_animation_information = list("pixel_x" = 23, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -4)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	suppressor_x_offset = 12

// BROWNING 2000 SHOTGUN
/obj/item/gun/ballistic/shotgun/automatic/b2000
	name = "\improper Bowling 3000 shotgun"
	desc = "The Bowling 3000 is a gas operated, semi automatic shotgun. \
		It has a 4(+1) shell capacity."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "b2000"
	base_icon_state = "b2000"
	bolt_wording = "slide"
	empty_indicator = FALSE
	empty_icon_state = TRUE
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lock_back.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_silenced.wav'
	gunshot_animation_information = list("pixel_x" = 25, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -5)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)

// BELADOR 2021 SILENCED SHOTGUN
/obj/item/gun/ballistic/shotgun/automatic/b2021
	name = "\improper Belador 2021 shotgun"
	desc = "The Belador 2021 is a gas operated, semi automatic special-operations shotgun developed by the DEATH SEC Unit \
		It has a 9(+1) shell capacity."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "b2021"
	inhand_icon_state = "b2021"
	base_icon_state = "b2021"
	bolt_wording = "slide"
	semi_auto = FALSE
	empty_indicator = FALSE
	empty_icon_state = TRUE
	can_unsuppress = FALSE
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lock_back.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	gunshot_animation_information = list("pixel_x" = 25, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -5)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/b2021

// ??? AUTOMATIC SHOTGUN
/obj/item/gun/ballistic/shotgun/bulldog
	name = "\improper Massacre Shotgun"
	desc = "A semi-auto, mag-fed shotgun for combat in narrow corridors. \
		Compatible only with specialized 8-round(+1) drum magazines. \
		Famously used by a terrorist in the \"Corn syrup rapture\" incident."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "automatic"
	base_icon_state = "automatic"
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_righthand.dmi'
	inhand_icon_state = "auto"
	bolt_wording = "bolt"
	special_mags = FALSE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	empty_alarm = FALSE
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_cycle.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_lock_back.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	load_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	gunshot_animation_information = list("pixel_x" = 25, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -5)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	pin = /obj/item/firing_pin
	can_suppress = TRUE
	suppressor_x_offset = 12

// SAIGA-12 AUTOMATIC SHOTGUN
/obj/item/gun/ballistic/shotgun/abyss
	name = "\improper AN-12 Abyss automatic shotgun"
	desc = "An odd-looking shotgun manufactured by Godheavy Industries \
	Shoots 20-round drums."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_righthand.dmi'
	inhand_icon_state = "saiga"
	icon_state = "saiga"
	worn_icon_state = "saiga"
	base_icon_state = "saiga"
	bolt_wording = "bolt"
	mag_display = TRUE
	empty_indicator = TRUE
	special_mags = FALSE
	mag_display_ammo = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	rack_sound_vary = FALSE
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lock_back.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_cycle.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_lock_back.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	load_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	gunshot_animation_information = list("pixel_x" = 31, \
										"pixel_y" = 0, \
										"inactive_when_silenced" = TRUE,
										"add_pixel_x_sawn" = -5)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/abyss_shotgun_drum
	suppressor_x_offset = 17


/obj/item/gun/ballistic/shotgun/bolas
	name = "\improper Destruidor de Bolas 4-gauge shotgun"
	desc = "Holy shit. That's a big shotgun."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	icon_state = "ks23"
	base_icon_state = "ks23"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/bolas
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/bolas.wav'
	can_suppress = FALSE
