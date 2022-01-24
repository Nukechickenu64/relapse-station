/mob/living/attackby_secondary(obj/item/weapon, mob/living/user, params)
	return weapon.attack_secondary(src, user, params)

/mob/living/attackby(obj/item/weapon, mob/living/user, params)
	if(..())
		return TRUE
	return weapon.attack(src, user, params)

/obj/item/attack(mob/living/victim, mob/living/user, params)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, victim, user, params)
	if(signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(signal_return & COMPONENT_SKIP_ATTACK)
		return

	var/mob_signal_return = SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, victim, user, params)
	if(mob_signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(mob_signal_return & COMPONENT_SKIP_ATTACK)
		return

	if(item_flags & NOBLUDGEON)
		return

	if(force && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_danger("I don't want to harm other living beings!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAPON_UNREADY))
		to_chat(user, span_warning("I am ready - [src] is not!"))
		return

	var/user_strength = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	var/wielded = SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK)
	if(!wielded)
		if((readying_flags & READYING_FLAG_HARD_TWO_HANDED) && (user_strength < (minimum_strength * 3)))
			to_chat(user, span_warning("I can't use [src] one-handed!"))
			return
		else if((readying_flags & READYING_FLAG_SOFT_TWO_HANDED) && (user_strength < (minimum_strength * 1.5)))
			to_chat(user, span_warning("I can't use [src] one-handed!"))
			return

	if(!ishuman(victim))
		if(!force)
			playsound(loc, 'sound/weapons/tap.ogg', get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
		else if(hitsound)
			playsound(loc, hitsound, get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)

	victim.lastattacker = user.real_name
	victim.lastattackerckey = user.ckey

	if(force && (victim == user))
		user.client?.give_award(/datum/award/achievement/misc/selfouch, user)

	user.do_attack_animation(victim, no_effect = TRUE)
	victim.attacked_by(src, user)

	log_combat(user, victim, "attacked", src.name, "(COMBAT MODE: [uppertext(user.combat_mode)]) INTENT: [uppertext(user.a_intent)] (DAMTYPE: [uppertext(damtype)])")
	add_fingerprint(user)

	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)

	if(readying_flags & READYING_FLAG_HARD_TWO_HANDED)
		if(user_strength < CEILING(minimum_strength * 1.5, 1))
			unready_weapon(user)
			return
	if(!wielded && (readying_flags & READYING_FLAG_SOFT_TWO_HANDED))
		if(user_strength < CEILING(minimum_strength * 2, 1))
			unready_weapon(user)
			return

/obj/item/attack_atom(atom/attacked_atom, mob/living/user, params)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ, attacked_atom, user, params)
	if(signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(signal_return & COMPONENT_SKIP_ATTACK)
		return

	var/mob_signal_return = SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, attacked_atom, user, params)
	if(mob_signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(mob_signal_return & COMPONENT_SKIP_ATTACK)
		return

	if(item_flags & NOBLUDGEON)
		return

	if(HAS_TRAIT_FROM(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT))
		to_chat(user, span_danger("I am ready - [src] is not!"))
		return

	var/user_strength = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	var/wielded = SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK)
	if(!wielded)
		if((readying_flags & READYING_FLAG_HARD_TWO_HANDED) && (user_strength < (minimum_strength * 3)))
			to_chat(user, span_warning("I can't use [src] one-handed!"))
			return
		else if((readying_flags & READYING_FLAG_SOFT_TWO_HANDED) && (user_strength < (minimum_strength * 1.5)))
			to_chat(user, span_warning("I can't use [src] one-handed!"))
			return

	user.do_attack_animation(attacked_atom, no_effect = TRUE)
	attacked_atom.attacked_by(src, user)

	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)

	if(readying_flags & READYING_FLAG_HARD_TWO_HANDED)
		if(user_strength < CEILING(minimum_strength * 1.5, 1))
			unready_weapon(user)
			return
	if(!wielded && (readying_flags & READYING_FLAG_SOFT_TWO_HANDED))
		if(user_strength < CEILING(minimum_strength * 2, 1))
			unready_weapon(user)
			return

/obj/item/afterattack(atom/target, mob/user, proximity_flag, params)
	if(SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, params) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	else if(SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, params) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE

/obj/item/attack_self(mob/user, modifiers)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(HAS_TRAIT_FROM(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT))
		ready_weapon(user)
		return TRUE
	interact(user)

/obj/item/proc/unready_weapon(mob/living/user, silent = FALSE)
	ADD_TRAIT(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT)
	if(!silent)
		unready_message(user)

/obj/item/proc/unready_message(mob/living/user)
	to_chat(user, span_danger("[src] becomes unready!"))

/obj/item/proc/ready_weapon(mob/living/user, silent = FALSE)
	user.changeNext_move(CLICK_CD_READY_WEAPON)
	REMOVE_TRAIT(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT)
	if(!silent)
		ready_message(user)

/obj/item/proc/ready_message(mob/living/user)
	to_chat(user, span_danger("I ready [src]!"))
