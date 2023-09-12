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
	wielded_inhand_state = TRUE
	rack_sound_vary = FALSE
	sawn_inhand_state = TRUE
	empty_indicator = FALSE
	empty_icon_state = FALSE
	suppressed = SUPPRESSED_NONE
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	worn_icon_state = "shotgun"
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_silenced.wav'
	pickup_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_draw.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_lock_back.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_lockin.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_cycle.wav'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_heavygun.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/safety2.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/safety2.ogg'
	load_sound = list(
		'modular_septic/sound/weapons/guns/shotgun/shell1.wav', \
		'modular_septic/sound/weapons/guns/shotgun/shell2.wav', \
		'modular_septic/sound/weapons/guns/shotgun/shell3.wav', \
	)
	load_sound_volume = 80
	safety_off_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_safety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/shotgun/shotgun_safety1.wav'
	gunshot_animation_information = list(
		"pixel_x" = 24, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	force = 12
	pb_knockback = 0
	can_suppress = TRUE
	suppressor_x_offset = 13
	bolt_type = BOLT_TYPE_LOCKING
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_SHOTGUN
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	tetris_width = 128
	tetris_height = 32

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
	suppressed_sound = list('modular_septic/sound/weapons/guns/shotgun/countryforold1.wav', 'modular_septic/sound/weapons/guns/shotgun/countryforold2.wav')
	empty_indicator = FALSE

// really nice state name
/obj/item/gun/ballistic/shotgun/ithaca/lethal
	name = "\improper ITOBE modelo 38 shotgun"
	icon_state = "ithaca_nigger"
	base_icon_state = "ithaca_nigger"
	inhand_icon_state = "ithaca_nigger"
	worn_icon_state = "shotgun_nigger"
	pickup_sound = 'modular_septic/sound/weapons/guns/shotgun/nigga_shotgun_draw.wav'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal


// ??? SHOTGUN
/obj/item/gun/ballistic/shotgun/riot
	name = "\improper Peneloppe Sit-Down shotgun"
	desc = "A sturdy shotgun with a longer magazine and a fixed tactical stock designed for \"non-lethal\" riot control."
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	icon_state = "riot"
	base_icon_state = "riot"
	inhand_icon_state = "riot"
	empty_indicator = FALSE
	can_be_sawn_off = FALSE
	gunshot_animation_information = list(
		"pixel_x" = 25, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -4, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	suppressor_x_offset = 14

/obj/item/gun/ballistic/shotgun/automatic
	bolt_type = BOLT_TYPE_LOCKING
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lock_back.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_lockin.wav'

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
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = list(
		'modular_septic/sound/weapons/guns/shotgun/comgun1.wav', \
		'modular_septic/sound/weapons/guns/shotgun/comgun2.wav', \
	)
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_silenced.wav'
	empty_indicator = FALSE
	gunshot_animation_information = list(
		"pixel_x" = 23, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -4, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	suppressor_x_offset = 13

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
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_silenced.wav'
	gunshot_animation_information = list(
		"pixel_x" = 25, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

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
	can_unsuppress = FALSE
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/semigun_cycle.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	gunshot_animation_information = list(
		"pixel_x" = 25, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/b2021

/obj/item/gun/ballistic/shotgun/automatic/b2021/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/suppressor = new(src)
	install_suppressor(suppressor)

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
	casing_ejector = TRUE
	bolt_type = BOLT_TYPE_STANDARD
	empty_icon_state = TRUE
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_cycle.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_lock_back.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	load_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	load_sound_volume = 40
	gunshot_animation_information = list(
		"pixel_x" = 25, \
		"pixel_y" = 1, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	pin = /obj/item/firing_pin
	can_suppress = TRUE
	suppressor_x_offset = 12

// SAIGA-12 AUTOMATIC SHOTGUN
/obj/item/gun/ballistic/shotgun/abyss
	name = "\improper AN-12 Abyss automatic shotgun"
	desc = "An odd-looking shotgun manufactured by Godheavy Industries"
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/shotgun_righthand.dmi'
	inhand_icon_state = "saiga"
	icon_state = "saiga"
	worn_icon_state = "saiga"
	base_icon_state = "saiga"
	bolt_wording = "bolt"
	mag_display = TRUE
	empty_icon_state = TRUE
	bolt_type = BOLT_TYPE_STANDARD
	special_mags = FALSE
	mag_display_ammo = TRUE
	semi_auto = TRUE
	internal_magazine = FALSE
	rack_sound_vary = FALSE
	casing_ejector = TRUE
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_cycle.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_lock_back.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/shotgun/rape_gun.wav'
	load_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/shotgun/autogun_magout.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/shotgun/belador_silenced.wav'
	load_sound_volume = 40
	gunshot_animation_information = list(
		"pixel_x" = 31, \
		"pixel_y" = 0, \
		"inactive_wben_suppressed" = TRUE, \
		"add_pixel_x_sawn" = -5, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -15, \
		"recoil_angle_lower" = -30, \
	)
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/abyss_shotgun_drum
	suppressor_x_offset = 8

// BALLS DESTROYER
/obj/item/gun/ballistic/shotgun/bolas
	name = "\improper Destruidor de Bolas 4-gauge shotgun"
	desc = "Holy shit. That's a big fucking shotgun."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	icon_state = "bolas"
	base_icon_state = "bolas"
	inhand_icon_state = "bolas"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/bolas
	fire_sound = list('modular_septic/sound/weapons/guns/shotgun/bolas1.wav', 'modular_septic/sound/weapons/guns/shotgun/bolas2.wav')
	suppressed_sound = list('modular_septic/sound/weapons/guns/shotgun/bolas_silenced1.wav', 'modular_septic/sound/weapons/guns/shotgun/bolas_silenced2.wav')
	load_sound = list(
		'modular_septic/sound/weapons/guns/shotgun/bolas_load1.wav', \
		'modular_septic/sound/weapons/guns/shotgun/bolas_load2.wav', \
		'modular_septic/sound/weapons/guns/shotgun/bolas_load3.wav', \
	)
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/bolas_lock_back.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/shotgun/bolas_lockin.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/shotgun/bolas_pump.wav'
	slot_flags = null
	can_suppress = TRUE
	suppressor_x_offset = 11
