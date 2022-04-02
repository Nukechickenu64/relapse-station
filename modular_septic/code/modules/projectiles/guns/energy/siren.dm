/obj/item/gun/energy/remis/siren
	name = "\improper \"Siren\" Energy Gun"
	desc = "An unwieldly and burdenly heavy firearm capable of firing without physical bullets, but instead utilizing chargable plasma batteries."
	icon = 'modular_septic/icons/obj/items/guns/energy.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/64x64_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	wielded_inhand_state = TRUE
	inhand_icon_state = "plasmarifle"
	icon_state = "plasmarifle"
	base_icon_state = "plasmarifle"
	fire_sound = 'modular_septic/sound/weapons/guns/energy/siren.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyoff.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyon.wav'
	vary_fire_sound = FALSE
	cell_type = /obj/item/stock_parts/cell/high
	charge_delay = 5
	ammo_type = list(/obj/item/ammo_casing/energy/siren)
	custom_materials = list(/datum/material/uranium=10000, \
						/datum/material/titanium=25000, \
						/datum/material/glass=2000)
	modifystate = FALSE
	automatic_charge_overlays = FALSE
	single_shot_type_overlay = FALSE
	display_empty = FALSE
	can_select = FALSE
	force = 15
	carry_weight = 5
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	selfcharge = TRUE
	gunshot_animation_information = list("icon_state" = "boltshot", \
										"pixel_x" = 32, \
										"pixel_y" = 2)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	custom_price = 100000
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_LAW
