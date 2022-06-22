/obj/item/trickysign
	name = "stop sign"
	desc = "A antique stop sign, for flouridated pedestrians and drivers to tell them when to not run over random people or stampede them. But now It's used to hit people in the head until they're dead."
	icon_state = "tricky"
	inhand_icon_state = "tricky"
	worn_icon_state = null
	icon = 'modular_septic/icons/obj/items/melee/bizzare.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/bizzare_righthand.dmi'
	worn_icon = null
	equip_sound = null
	hitsound = list('modular_septic/sound/weapons/melee/sign1.wav', 'modular_septic/sound/weapons/melee/sign2.wav')
	miss_sound = list('modular_septic/sound/weapons/melee/sign_miss1.wav', 'modular_septic/sound/weapons/melee/sign_miss2.wav')
	pickup_sound = 'modular_septic/sound/weapons/melee/sign_pickup.wav'
	drop_sound = 'modular_septic/sound/weapons/melee/sign_drop.wav'
	wield_info = /datum/wield_info/tricky
	min_force = 8
	force = 13
	min_force_strength = 0.8
	force_strength = 1.25
	parrying_modifier = 1
	wound_bonus = 5
	bare_wound_bonus = 1
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_HUGE
	attack_fatigue_cost = 4.5
	slot_flags = null
	sharpness = NONE
	parrying_modifier = 1
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED
	tetris_width = 32
	tetris_height = 96

/obj/item/trickysign/MouseDrop(mob/user, atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	var/turf/open/open_space
	if(istype(over, open_space) && (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) <= 13))
		var/obj/structure/trickysign/trickysign = new /obj/structure/trickysign(open_space)
		playsound(user, 'modular_septic/sound/weapons/melee/stone_embed.wav', 80, FALSE)
		transferItemToLoc(src, trickysign)
		QDEL_NULL(trickysign.sign) //it already gets one on initialize, we need to troll
		trickysign.sign = src
		user.visible_message(span_danger("[user] embeds [src] into the ground with great force!"), \
						span_danger("I embed [src] into the ground as hard as I can.")
	else
		var/message = pick(GLOB.whoopsie)
		to_chat(user, "[whoopsie] I'm too fucking weak")
		return

/obj/item/trickysign/update_icon(updates)
	. = ..()
	if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		inhand_icon_state = "[initial(inhand_icon_state)]_wielded"
	else
		inhand_icon_state = "[initial(inhand_icon_state)]"
