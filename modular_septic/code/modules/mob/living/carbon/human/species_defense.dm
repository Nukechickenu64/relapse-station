/datum/species
	punchdamagelow = 6
	punchdamagehigh = 8
	punchstunthreshold = 16
	attack_sound = list('modular_septic/sound/attack/punch1.ogg',
						'modular_septic/sound/attack/punch2.wav',
						'modular_septic/sound/attack/punch3.wav')
	miss_sound = list('modular_septic/sound/attack/punchmiss.ogg')
	attack_effect = ATTACK_EFFECT_PUNCH
	attack_verb = "punch"
	var/attack_verb_continuous = "punches"
	var/attack_sharpness = NONE
	var/attack_armor_damage_modifier = 0
	var/kick_effect = ATTACK_EFFECT_KICK
	var/kick_verb = "kick"
	var/kick_verb_continuous = "kicks"
	var/kick_sharpness = NONE
	var/kick_armor_damage_modifier = 0
	var/kick_sound = 'modular_septic/sound/attack/kick.wav'
	var/bite_effect = ATTACK_EFFECT_BITE
	var/bite_verb = "bite"
	var/bite_verb_continuous = "bites"
	var/bite_sharpness = NONE
	var/bite_sound = list('modular_septic/sound/attack/bite1.wav', 'modular_septic/sound/attack/bite2.wav', 'modular_septic/sound/attack/bite3.wav', 'modular_septic/sound/attack/bite4.wav')
	var/bite_armor_damage_modifier = 0

/datum/species/handle_fire(mob/living/carbon/human/burned, delta_time, times_fired, no_protection = FALSE)
	if(!CanIgniteMob(burned))
		return TRUE
	if(burned.on_fire)
		SEND_SIGNAL(burned, COMSIG_HUMAN_BURNING)
		//the fire tries to damage the exposed clothes and items
		var/list/burning_items = list()
		var/obscured = burned.check_obscured_slots(TRUE)
		//HEAD//
		if(burned.glasses && !(obscured & ITEM_SLOT_EYES))
			burning_items += burned.glasses
		if(burned.wear_mask && !(obscured & ITEM_SLOT_MASK))
			burning_items += burned.wear_mask
		if(burned.wear_neck && !(obscured & ITEM_SLOT_NECK))
			burning_items += burned.wear_neck
		if(burned.ears && !(obscured & ITEM_SLOT_LEAR))
			burning_items += burned.ears
		if(burned.ears_extra && !(obscured & ITEM_SLOT_REAR))
			burning_items += burned.ears_extra
		if(burned.head)
			burning_items += burned.head

		//CHEST//
		if(burned.w_uniform && !(obscured & ITEM_SLOT_ICLOTHING))
			burning_items += burned.w_uniform
		if(burned.wear_suit)
			burning_items += burned.wear_suit

		//ARMS & HANDS//
		var/obj/item/clothing/arm_clothes = null
		if(burned.gloves && !(obscured & ITEM_SLOT_GLOVES))
			arm_clothes = burned.gloves
		else if(burned.wear_suit && ((burned.wear_suit.body_parts_covered & HANDS) || (burned.wear_suit.body_parts_covered & ARMS)))
			arm_clothes = burned.wear_suit
		else if(burned.w_uniform && ((burned.w_uniform.body_parts_covered & HANDS) || (burned.w_uniform.body_parts_covered & ARMS)))
			arm_clothes = burned.w_uniform
		if(arm_clothes)
			burning_items |= arm_clothes

		//LEGS & FEET//
		var/obj/item/clothing/leg_clothes = null
		if(burned.shoes && !(obscured & ITEM_SLOT_FEET))
			leg_clothes = burned.shoes
		else if(burned.wear_suit && ((burned.wear_suit.body_parts_covered & FEET) || (burned.wear_suit.body_parts_covered & LEGS)))
			leg_clothes = burned.wear_suit
		else if(burned.w_uniform && ((burned.w_uniform.body_parts_covered & FEET) || (burned.w_uniform.body_parts_covered & LEGS)))
			leg_clothes = burned.w_uniform
		if(leg_clothes)
			burning_items |= leg_clothes

		for(var/obj/item/burned_item in burning_items)
			burned_item.fire_act(burned.fire_stacks * 50) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = burned.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			burned.adjust_bodytemperature(5.5 * delta_time)
		else
			burned.adjust_bodytemperature((BODYTEMP_HEATING_MAX + (burned.fire_stacks * 12)) * 0.5 * delta_time)
			SEND_SIGNAL(burned, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/spec_stun(mob/living/carbon/human/stunned, amount)
	if(stunned.movement_type & FLYING)
		for(var/obj/item/organ/external/wings/wings in stunned.getorganslotlist(ORGAN_SLOT_EXTERNAL_WINGS))
			wings.toggle_flight(stunned)
			wings.fly_slip(stunned)
	if(is_wagging_tail(stunned))
		stop_wagging_tail(stunned)
	return stunmod * stunned.physiology.stun_mod * amount

/datum/species/spec_attacked_by(obj/item/weapon, \
								mob/living/user, \
								obj/item/bodypart/affecting, \
								mob/living/carbon/human/victim, \
								list/modifiers)
	var/damage = weapon.get_force(user, GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
	// Allows you to put in item-specific reactions based on species
	damage *= check_species_weakness(weapon, user)
	var/sharpness = weapon.get_sharpness()
	var/attack_delay = weapon.attack_delay
	var/attack_fatigue_cost = weapon.attack_fatigue_cost
	var/attack_skill_modifier = 0
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(human_user && LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(victim.combat_style)
			if(CS_WEAK)
				damage *= 0.35
			if(CS_AIMED)
				attack_skill_modifier += 4
				attack_delay *= 1.2
				human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_STRONG)
				damage *= 1.5
				human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_FEINT)
				human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	if(user != victim)
		var/hit_modifier = weapon.melee_modifier+attack_skill_modifier+attack_skill_modifier
		var/hit_zone_modifier = weapon.melee_zone_modifier
		if(affecting)
			hit_modifier = affecting.melee_hit_modifier
			hit_zone_modifier = affecting.melee_hit_zone_modifier
			//very hard to miss when hidden by fov
			if(!(victim in fov_viewers(2, user)))
				hit_modifier += 5
				hit_zone_modifier += 5
			//easy to kick people when they are down
			if((victim.body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
				hit_modifier += 4
				hit_zone_modifier += 4
		var/diceroll = DICE_FAILURE
		var/skill_modifier = 0
		if(weapon.skill_melee)
			skill_modifier += GET_MOB_SKILL_VALUE(user, weapon.skill_melee)
		var/strength_difference = max(0, weapon.minimum_strength-GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
		diceroll = user.diceroll(skill_modifier+hit_modifier-strength_difference)
		if(diceroll <= DICE_FAILURE)
			affecting = null
		else
			diceroll = user.diceroll(skill_modifier+hit_zone_modifier-strength_difference)
			if(diceroll <= DICE_FAILURE)
				affecting = victim.get_bodypart(ran_zone(user.zone_selected, 0))
		if(victim.check_block())
			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			var/attack_message = "attack"
			if(length(weapon.attack_verb_simple))
				attack_message = pick(weapon.attack_verb_simple)
			victim.visible_message(span_warning("<b>[victim]</b> blocks <b>[user]</b>'s [attack_message] with [user.p_their()] [weapon]!"), \
							span_userdanger("I block <b>[user]</b>'s [attack_message] with [user.p_their()] [weapon]!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("<b>[victim]</b> blocks my [attack_message] with my [weapon]!"))
			user.sound_hint()
			victim.sound_hint()
			return FALSE
		if(victim.check_shields(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			victim.sound_hint()
			return FALSE
		if(victim.check_parry(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			victim.sound_hint()
			return FALSE
		if(victim.check_dodge(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			victim.sound_hint()
			return FALSE
	//No bodypart? That means we missed - Theoretically, we should never miss attacking ourselves
	if(!affecting)
		SSblackbox.record_feedback("amount", "item_attack_missed", 1, "[weapon.type]")
		var/attack_message = "attack"
		if(LAZYLEN(weapon.attack_verb_simple))
			attack_message = pick(weapon.attack_verb_simple)
		user.sound_hint()
		var/target_area = parse_zone(check_zone(user.zone_selected))
		playsound(user, weapon.miss_sound, weapon.get_clamped_volume(), extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
		user.visible_message(span_danger("<b>[user]</b> tries to [attack_message] <b>[src]</b>'s [target_area] with [weapon], but misses!"), \
				span_userdanger("I try to [attack_message] <b>[src]</b>'s [target_area] with my [weapon], but miss!"), \
				span_hear("I hear a swoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = victim)
		to_chat(victim, span_userdanger("<b>[user]</b> tries to [attack_message] my [target_area] with [weapon], but misses!"))
		user.changeNext_move(attack_delay)
		user.adjustFatigueLoss(attack_fatigue_cost)
		return FALSE

	SEND_SIGNAL(weapon, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)

	var/hit_area = affecting?.name
	var/def_zone = affecting?.body_zone
	var/intended_zone = user.zone_selected

	var/armor_block = victim.run_armor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					weapon.armour_penetration, \
					weak_against_armour = weapon.weak_against_armour, \
					sharpness = sharpness)
	var/armor_reduce = victim.run_subarmor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					weapon.subtractible_armour_penetration, \
					weak_against_armour = weapon.weak_against_subtractible_armour, \
					sharpness = sharpness)
	var/edge_protection = victim.get_edge_protection(affecting)
	edge_protection = max(0, edge_protection - weapon.edge_protection_penetration)
	var/subarmor_flags = victim.get_subarmor_flags(affecting)

	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)
	playsound(user, weapon.hitsound, weapon.get_clamped_volume(), TRUE, extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
	if(damage && !(weapon.item_flags & NOBLUDGEON))
		apply_damage(victim, \
					damage, \
					weapon.damtype, \
					def_zone, \
					armor_block, \
					wound_bonus = weapon.wound_bonus, \
					bare_wound_bonus = weapon.bare_wound_bonus, \
					sharpness = sharpness, \
					organ_bonus = weapon.organ_bonus, \
					bare_organ_bonus = weapon.bare_organ_bonus, \
					reduced = armor_reduce, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		victim.damage_armor(damage+weapon.armor_damage_modifier, MELEE, weapon.damtype, sharpness, def_zone)
		post_hit_effects(victim, user, affecting, weapon, damage, MELEE, weapon.damtype, sharpness, def_zone, intended_zone, modifiers)
	user.sound_hint()
	victim.sound_hint()
	victim.send_item_attack_message(weapon, user, hit_area, affecting)
	SEND_SIGNAL(victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	if(!(weapon.item_flags & NOBLUDGEON))
		if((weapon.damtype == BRUTE) && damage && prob(25 + (damage * 2)) && affecting.is_organic_limb())
			//Makes the weapon bloody, not the person
			weapon.add_mob_blood(victim)
			//blood spatter!
			if(prob(damage * 2))
				var/turf/location = victim.loc
				if(istype(location))
					victim.do_hitsplatter(get_dir(user, victim), min_range = 0, max_range = 2, splatter_loc = pick(FALSE, TRUE))
				//people with TK won't get smeared with blood
				if(get_dist(user, victim) <= 1)
					user.add_mob_blood(victim)
				//now this is what makes the person bloody
				switch(def_zone)
					if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_NECK, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
						if(victim.head)
							victim.head.add_mob_blood(victim)
							victim.update_inv_head()
						if(victim.wear_mask)
							victim.wear_mask.add_mob_blood(victim)
							victim.update_inv_wear_mask()
						if(victim.glasses)
							victim.glasses.add_mob_blood(victim)
							victim.update_inv_glasses()
						if(victim.wear_neck)
							victim.wear_neck.add_mob_blood(victim)
							victim.update_inv_neck()
					if(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT)
						if(victim.shoes)
							victim.shoes.add_mob_blood(victim)
							victim.update_inv_shoes()
					if(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)
						if(victim.gloves)
							victim.gloves.add_mob_blood(victim)
						else
							victim.add_mob_blood(victim)
					else
						if(victim.wear_suit)
							victim.wear_suit.add_mob_blood(victim)
							victim.update_inv_wear_suit()
						if(victim.w_uniform)
							victim.w_uniform.add_mob_blood(victim)
							victim.update_inv_w_uniform()
	return TRUE

/datum/species/spec_attack_hand(mob/living/carbon/human/user, \
								mob/living/carbon/human/victim, \
								datum/martial_art/attacker_style, \
								list/modifiers)
	if(!istype(user))
		return
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_HAND, user, victim, attacker_style)

	switch(user.a_intent)
		if(INTENT_HELP)
			help(user, victim, attacker_style, modifiers)
		if(INTENT_DISARM)
			disarm(user, victim, attacker_style, modifiers)
		if(INTENT_GRAB)
			grab(user, victim, attacker_style, modifiers, biting_grab = FALSE)
		if(INTENT_HARM)
			harm(user, victim, attacker_style, modifiers, SPECIAL_ATK_NONE)
		else
			help(user, victim, attacker_style, modifiers, SPECIAL_ATK_NONE)

/datum/species/help(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers)
	if((target.body_position == STANDING_UP) || (user.zone_selected in list(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)))
		target.help_shake_act(user)
		if(target != user)
			log_combat(user, target, "shaken")
		return TRUE
	else if(user.zone_selected in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_MOUTH))
		user.do_cpr(target, user.zone_selected == BODY_ZONE_CHEST ? CPR_CHEST : CPR_MOUTH)
		return TRUE

/datum/species/disarm(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers)
	var/attack_delay = CLICK_CD_MELEE
	var/attack_fatigue_cost = 6
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_AIMED)
				attack_delay *= 1.5
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	if(user != target)
		if(target.check_block())
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			target.visible_message(span_warning("<b>[user]</b>'s shove is blocked by [target]!"), \
							span_userdanger("I block <b>[user]</b>'s shove!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("My shove at <b>[target]</b> was blocked!"))
			log_combat(user, target, "attempted to shove, was blocked by")
			return FALSE
		if(target.check_shields(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
		if(target.check_parry(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
		if(target.check_dodge(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
	if(attacker_style?.disarm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	if(user == target)
		return FALSE
	user.disarm(target, modifiers)
	return TRUE

/datum/species/harm(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers, \
					special_attack = SPECIAL_ATK_NONE)
	//yes i have to do this here i'm sorry
	if(LAZYACCESS(modifiers, RIGHT_CLICK) && (user.combat_style == CS_FEINT))
		var/user_diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_BRAWLING), return_flags = RETURN_DICE_DIFFERENCE)
		var/most_efficient_skill = max(GET_MOB_SKILL_VALUE(target, SKILL_SHIELD), \
									GET_MOB_SKILL_VALUE(target, SKILL_BUCKLER), \
									GET_MOB_SKILL_VALUE(target, SKILL_FORCE_SHIELD), \
									GET_MOB_ATTRIBUTE_VALUE(target, STAT_DEXTERITY))
		var/target_diceroll = target.diceroll(most_efficient_skill, return_flags = RETURN_DICE_DIFFERENCE)
		if(!target.combat_mode)
			target_diceroll -= 18
		var/feign_attack_verb = pick(user.dna.species.attack_verb)
		//successful feint
		if(user_diceroll >= target_diceroll)
			var/feint_message_spectator = "<b>[user]</b> successfully feigns [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>]!"
			var/feint_message_victim = "Something feigns an attack on me!"
			var/feint_message_attacker = "I feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on something!"
			if(user in fov_viewers(2, target))
				feint_message_attacker = "I feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>!"
			if(target in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> feigns [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			target.visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("I hear a whoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
		//failed feint
		else
			var/feint_message_spectator = "<b>[user]</b> fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>!"
			var/feint_message_victim = "Something fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			var/feint_message_attacker = "I fail to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on something!"
			if(user in fov_viewers(2, target))
				feint_message_attacker = "I fail to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b> with!"
			if(target in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			target.visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("I hear a whoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
	var/attack_damage = rand(user.dna.species.punchdamagelow, user.dna.species.punchdamagehigh)
	var/attack_armor_damage = 0
	var/attack_verb
	var/attack_verb_continuous
	var/attack_effect
	var/attack_sharpness
	var/attack_fatigue_cost = 4
	var/attack_delay = CLICK_CD_MELEE
	var/attack_skill_modifier = 0
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			attack_skill_modifier -= 2
			attack_armor_damage = user.dna.species.bite_armor_damage_modifier
			attack_verb = pick(user.dna.species.bite_verb)
			attack_verb_continuous = pick(user.dna.species.bite_verb_continuous)
			attack_effect = pick(user.dna.species.bite_effect)
			attack_sharpness = user.dna.species.bite_sharpness
			attack_fatigue_cost *= 1.5
			attack_delay *= 2
		if(SPECIAL_ATK_KICK)
			attack_skill_modifier -= 2
			attack_damage *= 2
			attack_armor_damage = user.dna.species.kick_armor_damage_modifier
			attack_verb = pick(user.dna.species.kick_verb)
			attack_verb_continuous = pick(user.dna.species.kick_verb_continuous)
			attack_effect = pick(user.dna.species.kick_effect)
			attack_sharpness = user.dna.species.kick_sharpness
			attack_fatigue_cost *= 2
			attack_delay *= 2
		else
			attack_armor_damage = user.dna.species.attack_armor_damage_modifier
			attack_verb = pick(user.dna.species.attack_verb)
			attack_verb_continuous = pick(user.dna.species.attack_verb_continuous)
			attack_effect = pick(user.dna.species.attack_effect)
			attack_sharpness = user.dna.species.attack_sharpness
	if(user.attributes)
		attack_damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm <b>[target]</b>!"))
		user.changeNext_move(CLICK_CD_MELEE)
		return FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_WEAK)
				attack_damage *= 0.35
				attack_fatigue_cost = 2
			if(CS_AIMED)
				attack_skill_modifier += 4
				attack_delay *= 1.2
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_STRONG)
				attack_damage *= 1.5
				attack_fatigue_cost *= 1.5
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_FEINT)
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	if(user != target)
		if(target.check_block())
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s [attack_verb]!"), \
							span_userdanger("I block <b>[user]</b>'s [attack_verb]!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			if(user != target)
				to_chat(user, span_userdanger("My [attack_verb] at <b>[target]</b> was blocked!"))
			log_combat(user, target, "attempted to [attack_verb], was blocked by")
			return FALSE
		if(target.check_shields(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
		if(target.check_parry(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
		if(target.check_dodge(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.sound_hint()
			return FALSE
	if(attacker_style?.harm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE

	user.do_attack_animation(target, attack_effect, no_effect = TRUE)
	user.sound_hint()

	var/obj/item/bodypart/attacking_part
	switch(attack_effect)
		if(ATTACK_EFFECT_BITE)
			attacking_part = user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		if(ATTACK_EFFECT_KICK)
			attacking_part = user.get_active_foot()
		else
			attacking_part = user.get_active_hand()
	if(!attacking_part)
		attack_damage = 0
	else
		attack_damage *= (attacking_part.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))

	///melee skill
	var/skill_modifier = GET_MOB_SKILL_VALUE(user, SKILL_BRAWLING)
	///calculate the odds that a punch misses entirely
	var/hit_modifier = 0
	///chance to hit the wrong zone
	var/hit_zone_modifier = 0
	if(affecting)
		hit_modifier = affecting.melee_hit_modifier
		hit_zone_modifier = affecting.melee_hit_zone_modifier
		//very hard to miss when hidden by fov
		if(!(src in fov_viewers(2, user)))
			hit_modifier += 5
			hit_zone_modifier += 5
		//easy to kick people when they are down
		if((target.body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
			hit_modifier += 4
			hit_zone_modifier += 4
		//perfection, man
		if(HAS_TRAIT(user, TRAIT_PERFECT_ATTACKER))
			hit_modifier = 20
			hit_zone_modifier = 20
		//hitting yourself is easy, almost impossible to miss
		else if(user == target)
			hit_modifier = 20
			hit_zone_modifier = 20

	var/hit_area = parse_zone(user.zone_selected)
	var/def_zone = user.zone_selected
	var/intended_zone = user.zone_selected
	if(affecting)
		hit_area = affecting.name
		def_zone = affecting.body_zone
	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)
	//future-proofing for species that have 0 damage/weird cases where no zone is targeted
	var/diceroll = user.diceroll(skill_modifier+hit_modifier+attack_skill_modifier)
	if(!affecting)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], but that limb is missing!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], limb missing")
		return FALSE
	else if(diceroll <= DICE_FAILURE)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], but misses!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], but misses!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], but miss!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], but misses!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], but miss!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], missed")
		return FALSE

	// hit the wrong body zone
	if(user.diceroll(skill_modifier+hit_zone_modifier) <= DICE_FAILURE)
		affecting = target.get_bodypart(ran_zone(user.zone_selected, 0))

	var/armor_block = target.run_armor_check(affecting, MELEE, sharpness = attack_sharpness)
	var/armor_reduce = target.run_subarmor_check(affecting, MELEE, sharpness = attack_sharpness)
	var/subarmor_flags = target.get_subarmor_flags(affecting)
	var/edge_protection = target.get_edge_protection(affecting)

	var/real_attack_sound = user.dna.species.attack_sound
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			real_attack_sound = user.dna.species.bite_sound
		if(SPECIAL_ATK_KICK)
			real_attack_sound = user.dna.species.kick_sound

	playsound(target.loc, real_attack_sound, 60, TRUE, -1)
	target.sound_hint()
	if(attack_damage < 0)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], with no effect!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], with no effect!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], with no effect!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], no effect")
		return FALSE

	target.lastattacker = user.real_name
	target.lastattackerckey = user.ckey
	user.dna.species.spec_unarmedattacked(user, target)

	if(user.limb_destroyer)
		target.dismembering_strike(user, def_zone)

	target.apply_damage(attack_damage, \
						user.dna.species.attack_type, \
						affecting, \
						armor_block, \
						sharpness = attack_sharpness, \
						reduced = armor_reduce, \
						edge_protection = edge_protection, \
						subarmor_flags = subarmor_flags)
	target.apply_damage(attack_damage*1.5, STAMINA, affecting)
	target.damage_armor(attack_damage+attack_armor_damage, MELEE, user.dna.species.attack_type, attack_sharpness, affecting)
	post_hit_effects(target, user, affecting, attack_effect, attack_damage, MELEE, user.dna.species.attack_type, NONE, def_zone, intended_zone, modifiers)
	if(def_zone == intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> [attack_verb_continuous] <b>[target]</b>'s [hit_area]![target.wound_message]"), \
							span_userdanger("<b>[user]</b> [attack_verb_continuous] my [hit_area]![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("I [attack_verb] <b>[target]</b>'s [hit_area]![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> [attack_verb_continuous] [user.p_themselves()] on \the [hit_area]![target.wound_message]"), \
							span_userdanger("I [attack_verb] myself on \the [hit_area]![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	else
		var/parsed_intended_zone = parse_zone(intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> aims for \the [parsed_intended_zone], but [attack_verb_continuous] <b>[target]</b>'s [hit_area] instead![target.wound_message]"), \
							span_userdanger("<b>[user]</b> aims for \the [parsed_intended_zone], but [attack_verb_continuous] my [hit_area] instead![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("I aim for the [parsed_intended_zone], but [attack_verb] <b>[target]</b>'s [hit_area] instead![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> aims for \the [parsed_intended_zone], but [attack_verb_continuous] [user.p_themselves()] on \the [hit_area] instead![target.wound_message]"), \
							span_userdanger("I aim for \the [parsed_intended_zone], but [attack_verb] myself on \the [hit_area] instead![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
	log_combat(user, target, "[attack_verb]")
	SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	return TRUE

/datum/species/grab(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers, \
					biting_grab = FALSE)
	if(target.check_block())
		target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s [biting_grab ? "bite" : "grab"]!"), \
						span_userdanger("I block <b>[user]</b>'s [biting_grab ? "bite" : "grab"]!"), \
						span_hear("I hear a swoosh!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = user)
		to_chat(user, span_warning("My [biting_grab ? "bite" : "grab"] at [target] was blocked!"))
		log_combat(user, target, "attempted to [biting_grab ? "bite" : "grab"], was blocked by")
		return FALSE
	if(attacker_style?.grab_act(user, target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	target.grabbedby(user, FALSE, biting_grab)
	return TRUE

/datum/species/proc/spec_attack_foot(mob/living/carbon/human/user, \
									mob/living/carbon/human/victim, \
									datum/martial_art/attacker_style, \
									list/modifiers)
	if(!istype(user))
		return
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_FOOT, user, victim, attacker_style)

	return harm(user, victim, attacker_style, modifiers, SPECIAL_ATK_KICK)

/datum/species/proc/spec_attack_jaw(mob/living/carbon/human/user, \
									mob/living/carbon/human/victim, \
									datum/martial_art/attacker_style, \
									list/modifiers)
	if(!istype(user))
		return
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_JAW, user, victim, attacker_style)
	return grab(user, victim, attacker_style, modifiers, biting_grab = TRUE)

//Weapon can be an attack effect instead
/datum/species/proc/post_hit_effects(mob/living/carbon/human/victim, \
									mob/living/carbon/human/user, \
									obj/item/bodypart/affected, \
									obj/item/weapon, \
									damage = 0, \
									damage_flag = MELEE, \
									damage_type = BRUTE, \
									sharpness = NONE,
									def_zone = BODY_ZONE_CHEST, \
									intended_zone = BODY_ZONE_CHEST, \
									list/modifiers)
	var/victim_end = GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE)
	if(!sharpness)
		var/knockback_tiles = 0
		if(victim_end >= 3)
			knockback_tiles = FLOOR(damage/((victim_end - 2) * 2.5), 1)
		// I HATE DIVISION BY ZERO! I HATE DIVISION BY ZERO!
		else
			knockback_tiles = FLOOR(damage/2, 1)
		if(knockback_tiles >= 1)
			var/turf/edge_target_turf = get_edge_target_turf(victim, get_dir(user, victim))
			if(istype(edge_target_turf))
				victim.safe_throw_at(edge_target_turf, \
									knockback_tiles, \
									knockback_tiles, \
									user, \
									spin = FALSE, \
									force = victim.move_force, \
									callback = CALLBACK(victim, /mob/living/carbon/proc/handle_knockback, get_turf(victim)))
	return TRUE
