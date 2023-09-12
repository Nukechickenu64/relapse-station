/obj/item/gun/energy/remis/railgun
	name = "\improper \"Siren\" Heavy Plasma Rifle"
	desc = "An unwieldly and burdenly heavy firearm capable of firing without physical bullets, but instead utilizing chargable plasma batteries."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	icon_state = "railgun"
	base_icon_state = "railgun"
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/64x64_righthand.dmi'
	inhand_icon_state = "plasmarifle"
	wielded_inhand_state = TRUE
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	fire_sound = list('modular_septic/sound/weapons/guns/energy/railgun1.wav', 'modular_septic/sound/weapons/guns/energy/railgun2.wav', 'modular_septic/sound/weapons/guns/energy/railgun3.wav')
	safety_off_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyoff.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyon.wav'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_heavygun.wav'
	vary_fire_sound = FALSE
	cell_type = /obj/item/stock_parts/cell/high
	charge_delay = 5
	fire_delay = 3 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/siren)
	custom_materials = list(/datum/material/uranium=10000, \
						/datum/material/titanium=25000, \
						/datum/material/glass=2000)
	modifystate = FALSE
	can_select = FALSE
	automatic_charge_overlays = TRUE
	shaded_charge = TRUE
	charge_sections = 5
	display_empty = TRUE
	selfcharge = TRUE
	gunshot_animation_information = list("icon_state" = "boltshot", \
										"pixel_x" = 28, \
										"pixel_y" = 13)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -25)
	custom_price = 100000
	force = 15
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	burst_size = 3
	carry_weight = 5
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_LAW
	tetris_width = 160
	tetris_height = 128
