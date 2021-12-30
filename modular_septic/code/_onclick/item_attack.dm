/mob/living/attackby(obj/item/I, mob/living/user, params)
	if(..())
		return TRUE
	user.changeNext_move(I.attack_delay)
	user.adjustFatigueLoss(I.attack_fatigue_cost)
	return I.attack(src, user, params)

/mob/living/attackby_secondary(obj/item/weapon, mob/living/user, params)
	var/result = weapon.attack_secondary(src, user, params)

	// Normal attackby updates click cooldown, so we have to make up for it
	if (result != SECONDARY_ATTACK_CALL_NORMAL)
		user.changeNext_move(weapon.attack_delay)
		user.adjustFatigueLoss(weapon.attack_fatigue_cost)

	return result

/obj/item/attack(mob/living/M, mob/living/user, params)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, M, user, params)
	if(signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(signal_return & COMPONENT_SKIP_ATTACK)
		return

	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, M, user, params)

	if(item_flags & NOBLUDGEON)
		return

	if(force && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm other living beings!"))
		return

	if(!ishuman(M))
		if(!force)
			playsound(loc, 'sound/weapons/tap.ogg', get_clamped_volume(), TRUE, -1)
		else if(hitsound)
			playsound(loc, hitsound, get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)

	M.lastattacker = user.real_name
	M.lastattackerckey = user.ckey

	if(force && M == user && user.client)
		user.client.give_award(/datum/award/achievement/misc/selfouch, user)

	user.do_attack_animation(M, no_effect = TRUE)
	M.attacked_by(src, user)

	log_combat(user, M, "attacked", src.name, "(COMBAT MODE: [uppertext(user.combat_mode)]) INTENT: [uppertext(user.a_intent)] (DAMTYPE: [uppertext(damtype)])")
	add_fingerprint(user)

/obj/item/attack_atom(atom/attacked_atom, mob/living/user, params)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ, attacked_atom, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	if(item_flags & NOBLUDGEON)
		return
	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)
	user.do_attack_animation(attacked_atom, no_effect = TRUE)
	attacked_atom.attacked_by(src, user)
