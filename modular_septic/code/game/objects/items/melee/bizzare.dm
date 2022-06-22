/obj/item/trickysign
	name = "stop sign"
	desc = "A antique stop sign, for flouridated pedestrians and drivers to tell them when to not run over random people or stampede them. But now It's used to hit people in the head until they're dead."
	icon_state = "cockri"
	inhand_icon_state = "cockri"
	worn_icon_state = "cockri"
	icon = 'modular_septic/icons/obj/items/melee/bizzare.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_righthand.dmi'
	worn_icon = null
	equip_sound = null
	hitsound = list('modular_septic/sound/weapons/melee/sign1.wav', 'modular_septic/sound/weapons/melee/sign2.wav')
	miss_sound = list('modular_septic/sound/weapons/melee/sign_miss1.wav', 'modular_septic/sound/weapons/melee/sign_miss2.wav')
	pickup_sound = 'modular_septic/sound/weapons/melee/sign_pickup.wav'
	drop_sound = 'modular_septic/sound/weapons/melee/sign_drop.wav'
	min_force = 8
	force = 13
	min_force_strength = 0
	force_strength = 0
	parrying_modifier = 1
	wound_bonus = 5
	bare_wound_bonus = 1
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED
	wielded_inhand_state = TRUE
	tetris_width = 32
	tetris_height = 96

/obj/item/trickysign/update_icon(updates)
	. = ..()
	if(wielded_inhand_state)
		if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
			inhand_icon_state = "[initial(inhand_icon_state)]_wielded"
		else
			inhand_icon_state = "[initial(inhand_icon_state)]"
