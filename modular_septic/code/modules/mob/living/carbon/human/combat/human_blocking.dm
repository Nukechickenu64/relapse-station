/mob/living/carbon/human/check_shields(atom/attacker, \
									damage = 0, \
									attack_text = "the attack", \
									attack_type = MELEE_ATTACK)
	/// Can only block in combat mode, can't block more than once every second, can only block in parry mode
	if(!combat_mode || !COOLDOWN_FINISHED(src, blocking_cooldown) || (dodge_parry != DP_PARRY))
		return COMPONENT_HIT_REACTION_CANCEL
	for(var/obj/item/held_item in held_items)
		//Blocking with clothing would be bad
		if(isclothing(held_item))
			continue
		var/signal_return = held_item.item_block(src, attacker, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(head)
		var/signal_return = head.item_block(src, attacker, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_neck)
		var/signal_return = wear_neck.item_block(src, attacker, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_suit)
		var/signal_return = wear_suit.item_block(src, attacker, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(w_uniform)
		var/signal_return = w_uniform.item_block(src, attacker, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	return FALSE

//blocking score helper
/mob/living/carbon/human/proc/get_blocking_score(skill_used = SKILL_SHIELD, modifier = 0)
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	return FLOOR(3 + GET_MOB_SKILL_VALUE(src, skill_used)/2 + modifier - stun_penalty, 1)
