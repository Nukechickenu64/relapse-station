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
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_lightgun.ogg'
	skill_melee = SKILL_IMPACT_WEAPON
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	skill_ranged = SKILL_SMG
	suppressed = SUPPRESSED_NONE
	full_auto = TRUE
	w_class = WEIGHT_CLASS_BULKY
	tetris_width = 96
	tetris_height = 96

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
	rack_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_rack.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockin.ogg'
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/hksmg.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_silenced.ogg'
	mag_type =	/obj/item/ammo_box/magazine/hksmg22lr
	weapon_weight = WEAPON_LIGHT
	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BELT
	force = 10
	recoil = 0.2
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 9
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -10, \
		"recoil_angle_lower" = -20, \
		"recoil_burst_speed" = 0.5, \
		"return_burst_speed" = 0.5, \
	)
	client_recoil_animation_information = list(
		"strength" = 0.1,
		"duration" = 1,
	)
	custom_price = 10000

/obj/item/gun/ballistic/automatic/remis/smg/bastardo
	name = "\improper Feio Bastardo R1 submachine gun"
	desc = "A fully-automatic submachine gun issued to ZoomTech officers and military force with an accelerated fire delay, comes with a folding stock, and a threaded barrel for suppression."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	worn_icon_state = "vityaz"
	inhand_icon_state = "vityaz"
	base_icon_state = "vityaz"
	icon_state = "vityaz"
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/vityaz_silenced.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/vityaz.ogg'
	fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/aksafety2.ogg'
	fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/aksafety2.ogg'
	fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/aksafety1.ogg'
	mag_type =	/obj/item/ammo_box/magazine/bastardo9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	recoil = 0.2
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 6
	gunshot_animation_information = list(
		"pixel_x" = 15, \
		"pixel_y" = 2, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -10, \
		"recoil_angle_lower" = -20, \
		"recoil_burst_speed" = 0.5, \
		"return_burst_speed" = 0.5, \
	)
	client_recoil_animation_information = list(
		"strength" = 0.3, \
		"duration" = 1, \
	)
	custom_price = 20000

/obj/item/gun/ballistic/automatic/remis/smg/thump
	name = "\improper Cesno Thump R2 submachine gun"
	desc = "A fully-automatic submachine gun that fires in optional three-round bursts, comes with a threaded barrel, and was engineered as a direct upgrade to the Solitario to .45 ACP."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	worn_icon_state = "ump"
	inhand_icon_state = "ump"
	base_icon_state = "ump"
	icon_state = "ump"
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/thump_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/thump_lockin.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/smg/thump_rack.ogg'
	load_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/thump.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/thump_silenced.ogg'
	mag_type =	/obj/item/ammo_box/magazine/thump45
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_LOCKING
	force = 10
	recoil = 0.2
	fire_delay = 1.7
	burst_size = 3
	can_suppress = TRUE
	suppressor_x_offset = 6
	can_flashlight = TRUE
	flight_x_offset = 30
	flight_y_offset = 14
	client_recoil_animation_information = list(
		"strength" = 0.25, \
		"duration" = 1, \
	)

// SUPPRESSED HK SMG
/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed
	name = "Solitario-SD Inseguro R7 \"Saber\" submachine gun"
	desc = "An integrally suppressed version of the Solitario, changed post-factory to be chambered in .380, however. This has made the drum mags incompatible."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/hksmg380_silenced.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/hksmg380_silenced.ogg'
	weapon_weight = WEAPON_MEDIUM
	worn_icon_state = "hksmgs"
	inhand_icon_state = "hksmgs"
	base_icon_state = "hksmgs"
	icon_state = "hksmgs"
	fire_delay = 1.4
	burst_size = 3
	mag_type = /obj/item/ammo_box/magazine/hksmg380
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	can_suppress = TRUE
	can_unsuppress = FALSE
	w_class = WEIGHT_CLASS_SMALL
	client_recoil_animation_information = list(
		"strength" = 0.15, \
		"duration" = 1, \
	)

/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/no_mag
	spawnwithmagazine = FALSE

// KAKAKAKAKAKAKAKAKAKKAKAKAKAKAKAKA REALLYGOODCOMICS GUN I LOVE REALLYGOODCOMICS YES SIR I AM AN AIR MARSHAL
/obj/item/gun/ballistic/automatic/remis/smg/bolsa
	name = "\improper Bolsa R6 submachine gun"
	desc = "An antique, compact submachine gun that is prohibited to civillians in many stations. Discontinued, but it still has It's strengths, that being the extendable stock and the size."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	worn_icon_state = "uzi"
	inhand_icon_state = "uzi"
	base_icon_state = "uzi"
	icon_state = "uzi"
	load_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_magin.ogg'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_magin.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_magout.ogg'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_magout.ogg'
	rack_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_rack.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_silenced.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/bolsa.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_lockback.ogg'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_lockin.ogg'
	fireselector_auto = 'modular_septic/sound/weapons/guns/smg/bolsa_safety.ogg'
	fireselector_burst = 'modular_septic/sound/weapons/guns/smg/bolsa_safety.ogg'
	fireselector_semi = 'modular_septic/sound/weapons/guns/smg/bolsa_safety.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_safety.ogg'
	safety_on_sound = 'modular_septic/sound/weapons/guns/smg/bolsa_safety.ogg'
	mag_type =	/obj/item/ammo_box/magazine/uzi9mm
	foldable = TRUE
	folded = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_OPEN
	slot_flags = ITEM_SLOT_BELT
	carry_weight = 2.2 KILOGRAMS
	force = 10
	recoil = 0.2
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 2
	gunshot_animation_information = list(
		"pixel_x" = 21, \
		"pixel_y" = 5, \
		"inactive_wben_suppressed" = TRUE, \
	)
	recoil_animation_information = list(
		"recoil_angle_upper" = -10, \
		"recoil_angle_lower" = -20, \
		"recoil_burst_speed" = 0.5, \
		"return_burst_speed" = 0.5, \
	)
	client_recoil_animation_information = list(
		"strength" = 0.2,
		"duration" = 1,
	)
	custom_price = 20000
