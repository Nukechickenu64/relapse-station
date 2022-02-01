//main proc for parrying
/mob/living/carbon/human/proc/check_parry(atom/attacker, \
									damage = 0, \
									attack_text = "the attack", \
									attack_type = MELEE_ATTACK)
	/// Can only parry in combat mode, can only block in parry mode
	if(!combat_mode || (dodge_parry != DP_PARRY))
		return COMPONENT_HIT_REACTION_CANCEL
	for(var/obj/item/held_item in held_items)
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

//parrying score helper
/mob/living/carbon/human/proc/get_parrying_score(skill_used = SKILL_IMPACT_WEAPON, modifier = 0)
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	return FLOOR(3 + GET_MOB_SKILL_VALUE(src, skill_used)/2 + modifier - stun_penalty, 1)

/mob/living/carbon/human/proc/update_parrying_penalty(incoming = 0, duration = PARRYING_PENALTY_COOLDOWN)
	//use remove_shock_penalty() you idiot
	if(!incoming || !duration)
		return
	if(parrying_penalty_timer)
		deltimer(parrying_penalty_timer)
		parrying_penalty_timer = null
	//add incoming modification
	parrying_penalty += incoming
	parrying_penalty_timer = addtimer(CALLBACK(src, .proc/remove_shock_penalty), duration, TIMER_STOPPABLE)

/mob/living/carbon/human/proc/remove_parrying_penalty()
	parrying_penalty = 0
	parrying_penalty_timer = null

//main proc for dodging
/mob/living/carbon/human/proc/check_dodge(atom/attacker, \
									damage = 0, \
									attack_text = "the attack", \
									attack_type = MELEE_ATTACK)
	/// Can only parry in combat mode, can only block once every second, can only block in parry mode
	if(!combat_mode || !COOLDOWN_FINISHED(src, dodging_cooldown) || (dodge_parry != DP_PARRY))
		return COMPONENT_HIT_REACTION_CANCEL
	var/dodging_modifier = 0
	for(var/obj/item/held_item in held_items)
		dodging_modifier += held_item.dodging_modifier
	if(head)
		dodging_modifier += head.dodging_modifier
	if(wear_neck)
		dodging_modifier += wear_neck.dodging_modifier
	if(wear_suit)
		dodging_modifier += wear_suit.dodging_modifier
	if(w_uniform)
		dodging_modifier += w_uniform.dodging_modifier
	var/dodging_score = get_dodging_score(dodging_modifier)
	// successful dodge attempt, if we manage to move to any adjacent time that is
	if(diceroll(dodging_score) >= DICE_SUCCESS)
		for(var/direction in shuffle(GLOB.alldirs))
			var/turf/move_to = get_step(src, direction)
			if(istype(move_to) && Move(move_to, direction))
				visible_message(span_danger("<b>[src]</b> dodges [attack_text] with [src]!"), \
										span_danger("I dodge [attack_text] with [src]!"), \
										vision_distance = COMBAT_MESSAGE_RANGE)
				return COMPONENT_HIT_REACTION_CANCEL | COMPONENT_HIT_REACTION_BLOCK
	return FALSE

//dodging score helper
/mob/living/carbon/human/proc/get_dodging_score(modifier = 0)
	var/basic_speed = GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)+GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)/4
	var/encumbrance_penalty = 0
	switch(encumbrance)
		if(ENCUMBRANCE_LIGHT)
			encumbrance_penalty = 1
		if(ENCUMBRANCE_MEDIUM)
			encumbrance_penalty = 2
		if(ENCUMBRANCE_HEAVY)
			encumbrance_penalty = 3
		if(ENCUMBRANCE_EXTREME)
			encumbrance_penalty = 4
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	return FLOOR(3 + basic_speed + modifier - encumbrance_penalty - stun_penalty, 1)
