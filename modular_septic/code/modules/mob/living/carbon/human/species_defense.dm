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
	var/kick_sound = 'modular_septic/sound/attack/kick.ogg'
	var/bite_effect = ATTACK_EFFECT_BITE
	var/bite_verb = "bite"
	var/bite_verb_continuous = "bites"
	var/bite_sharpness = NONE
	var/bite_sound = 'modular_septic/sound/attack/bite.ogg'
	var/bite_armor_damage_modifier = 0

/datum/species/handle_fire(mob/living/carbon/human/H, delta_time, times_fired, no_protection = FALSE)
	if(!CanIgniteMob(H))
		return TRUE
	if(H.on_fire)
		SEND_SIGNAL(H, COMSIG_HUMAN_BURNING)
		//the fire tries to damage the exposed clothes and items
		var/list/burning_items = list()
		var/obscured = H.check_obscured_slots(TRUE)
		//HEAD//
		if(H.glasses && !(obscured & ITEM_SLOT_EYES))
			burning_items += H.glasses
		if(H.wear_mask && !(obscured & ITEM_SLOT_MASK))
			burning_items += H.wear_mask
		if(H.wear_neck && !(obscured & ITEM_SLOT_NECK))
			burning_items += H.wear_neck
		if(H.ears && !(obscured & ITEM_SLOT_LEAR))
			burning_items += H.ears
		if(H.ears_extra && !(obscured & ITEM_SLOT_REAR))
			burning_items += H.ears_extra
		if(H.head)
			burning_items += H.head

		//CHEST//
		if(H.w_uniform && !(obscured & ITEM_SLOT_ICLOTHING))
			burning_items += H.w_uniform
		if(H.wear_suit)
			burning_items += H.wear_suit

		//ARMS & HANDS//
		var/obj/item/clothing/arm_clothes = null
		if(H.gloves && !(obscured & ITEM_SLOT_GLOVES))
			arm_clothes = H.gloves
		else if(H.wear_suit && ((H.wear_suit.body_parts_covered & HANDS) || (H.wear_suit.body_parts_covered & ARMS)))
			arm_clothes = H.wear_suit
		else if(H.w_uniform && ((H.w_uniform.body_parts_covered & HANDS) || (H.w_uniform.body_parts_covered & ARMS)))
			arm_clothes = H.w_uniform
		if(arm_clothes)
			burning_items |= arm_clothes

		//LEGS & FEET//
		var/obj/item/clothing/leg_clothes = null
		if(H.shoes && !(obscured & ITEM_SLOT_FEET))
			leg_clothes = H.shoes
		else if(H.wear_suit && ((H.wear_suit.body_parts_covered & FEET) || (H.wear_suit.body_parts_covered & LEGS)))
			leg_clothes = H.wear_suit
		else if(H.w_uniform && ((H.w_uniform.body_parts_covered & FEET) || (H.w_uniform.body_parts_covered & LEGS)))
			leg_clothes = H.w_uniform
		if(leg_clothes)
			burning_items |= leg_clothes

		for(var/X in burning_items)
			var/obj/item/I = X
			I.fire_act(H.fire_stacks * 50) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = H.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			H.adjust_bodytemperature(5.5 * delta_time)
		else
			H.adjust_bodytemperature((BODYTEMP_HEATING_MAX + (H.fire_stacks * 12)) * 0.5 * delta_time)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/spec_stun(mob/living/carbon/human/H, amount)
	if(H.movement_type & FLYING)
		for(var/obj/item/organ/external/wings/wings in H.getorganslot(ORGAN_SLOT_EXTERNAL_WINGS))
			wings.toggle_flight(H)
			wings.fly_slip(H)
	if(is_wagging_tail(H))
		stop_wagging_tail(H)
	return stunmod * H.physiology.stun_mod * amount

/datum/species/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/H, list/modifiers)
	// Allows you to put in item-specific reactions based on species
	var/damage = I.force
	if(user.attributes)
		damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)
	var/weakness = check_species_weakness(I, user)
	if(weakness)
		damage *= weakness
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(H.combat_style)
			if(CS_WEAK)
				damage *= 0.35
	if((user != H) && damage)
		if(H.check_shields(I, damage, "<b>[user]</b>'s [I.name]", "my [I.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(H, used_item = I, no_effect = TRUE)
			return FALSE
		if(H.check_parry(I, damage, "<b>[user]</b>'s [I.name]", "my [I.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(H, used_item = I, no_effect = TRUE)
			return FALSE
		if(H.check_dodge(I, damage, "<b>[user]</b>'s [I.name]", "my [I.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(H, used_item = I, no_effect = TRUE)
			return FALSE
	if((user != H) && H.check_block())
		user.do_attack_animation(H, used_item = I, no_effect = TRUE)
		var/attack_message = "attack"
		if(length(I.attack_verb_simple))
			attack_message = pick(I.attack_verb_simple)
		H.visible_message(span_warning("<b>[H]</b> blocks <b>[user]</b>'s [attack_message] with [user.p_their()] [I]!"), \
						span_userdanger("I block <b>[user]</b>'s [attack_message] with [user.p_their()] [I]!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						user)
		to_chat(user, span_userdanger("<b>[H]</b> blocks my [attack_message] with my [I]!"))
		return FALSE

	var/hit_area = affecting?.name
	var/def_zone = affecting?.body_zone
	var/intended_zone = user.zone_selected
	var/sharpness = I.get_sharpness()

	var/armor_block = H.run_armor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					I.armour_penetration, \
					weak_against_armour = I.weak_against_armour, \
					sharpness = sharpness)
	var/armor_reduce = H.run_subarmor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					I.subtractible_armour_penetration, \
					weak_against_armour = I.weak_against_subtractible_armour, \
					sharpness = sharpness)
	var/edge_protection = H.get_edge_protection(affecting)
	edge_protection = max(0, edge_protection - I.edge_protection_penetration)
	var/subarmor_flags = H.get_subarmor_flags(affecting)

	if(damage && !(I.item_flags & NOBLUDGEON))
		apply_damage(damage, \
					I.damtype, \
					def_zone, \
					armor_block, \
					H, \
					wound_bonus = I.wound_bonus, \
					bare_wound_bonus = I.bare_wound_bonus, \
					sharpness = sharpness, \
					organ_bonus = I.organ_bonus, \
					bare_organ_bonus = I.bare_organ_bonus, \
					reduced = armor_reduce, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		H.damage_armor(damage+I.armor_damage_modifier, MELEE, I.damtype, sharpness, def_zone)
		post_hit_effects(H, user, affecting, I, damage, MELEE, I.damtype, sharpness, def_zone, intended_zone, modifiers)

	H.send_item_attack_message(I, user, hit_area, affecting)
	SEND_SIGNAL(H, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	if(!(I.item_flags & NOBLUDGEON))
		if((I.damtype == BRUTE) && damage && prob(25 + (damage * 2)) && affecting.is_organic_limb())
			I.add_mob_blood(H) //Make the weapon bloody, not the person
			if(prob(damage * 2)) //blood spatter!
				var/turf/location = H.loc
				if(istype(location))
					H.do_hitsplatter(get_dir(user, H), min_range = 0, max_range = 2, splatter_loc = pick(FALSE, TRUE))
				//people with TK won't get smeared with blood
				if(get_dist(user, H) <= 1)
					user.add_mob_blood(H)
				switch(def_zone)
					if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
						//Apply blood
						if(H.head)
							H.head.add_mob_blood(H)
							H.update_inv_head()
						if(H.wear_mask)
							H.wear_mask.add_mob_blood(H)
							H.update_inv_wear_mask()
						if(H.glasses)
							H.glasses.add_mob_blood(H)
							H.update_inv_glasses()
					if(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT)
						if(H.shoes)
							H.shoes.add_mob_blood(H)
							H.update_inv_shoes()
					else
						if(H.wear_suit)
							H.wear_suit.add_mob_blood(H)
							H.update_inv_wear_suit()
						if(H.w_uniform)
							H.w_uniform.add_mob_blood(H)
							H.update_inv_w_uniform()
	return TRUE

/datum/species/spec_attack_hand(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, list/modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_HAND, M, H, attacker_style)

	switch(M.a_intent)
		if(INTENT_HELP)
			help(M, H, attacker_style, modifiers)
		if(INTENT_DISARM)
			disarm(M, H, attacker_style, modifiers)
		if(INTENT_GRAB)
			grab(M, H, attacker_style, modifiers, biting_grab = FALSE)
		if(INTENT_HARM)
			harm(M, H, attacker_style, modifiers, SPECIAL_ATK_NONE)
		else
			help(M, H, attacker_style, modifiers, SPECIAL_ATK_NONE)

/datum/species/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style, list/modifiers)
	if((target.body_position == STANDING_UP) || (user.zone_selected in list(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)))
		target.help_shake_act(user)
		if(target != user)
			log_combat(user, target, "shaken")
		return TRUE
	else if(user.zone_selected in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_MOUTH))
		user.do_cpr(target, user.zone_selected == BODY_ZONE_CHEST ? CPR_CHEST : CPR_MOUTH)
		return TRUE

/datum/species/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style, list/modifiers)
	if((user != target) && target.check_block())
		user.do_attack_animation(target, no_effect = TRUE)
		target.visible_message(span_warning("<b>[user]</b>'s shove is blocked by [target]!"), \
						span_userdanger("I block <b>[user]</b>'s shove!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						user)
		to_chat(user, span_userdanger("My shove at <b>[target]</b> was blocked!"))
		log_combat(user, target, "attempted to shove, was blocked by")
		return FALSE
	if(attacker_style?.disarm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	if(user == target)
		return FALSE
	user.disarm(target, modifiers)

/datum/species/harm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style, list/modifiers, special_attack = SPECIAL_ATK_NONE)
	var/atk_damage = rand(user.dna.species.punchdamagelow, user.dna.species.punchdamagehigh)
	var/atk_armor_damage = 0
	var/atk_verb
	var/atk_verb_continuous
	var/atk_effect
	var/atk_sharpness
	var/atk_cost = 3
	var/atk_delay = CLICK_CD_MELEE
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			atk_armor_damage = user.dna.species.bite_armor_damage_modifier
			atk_verb = pick(user.dna.species.bite_verb)
			atk_verb_continuous = pick(user.dna.species.bite_verb_continuous)
			atk_effect = pick(user.dna.species.bite_effect)
			atk_sharpness = user.dna.species.bite_sharpness
			atk_cost *= 1.5
			atk_delay *= 2
		if(SPECIAL_ATK_KICK)
			atk_damage *= 2
			atk_armor_damage = user.dna.species.kick_armor_damage_modifier
			atk_verb = pick(user.dna.species.kick_verb)
			atk_verb_continuous = pick(user.dna.species.kick_verb_continuous)
			atk_effect = pick(user.dna.species.kick_effect)
			atk_sharpness = user.dna.species.kick_sharpness
			atk_cost *= 2
			atk_delay *= 2
		else
			atk_armor_damage = user.dna.species.attack_armor_damage_modifier
			atk_verb = pick(user.dna.species.attack_verb)
			atk_verb_continuous = pick(user.dna.species.attack_verb_continuous)
			atk_effect = pick(user.dna.species.attack_effect)
			atk_sharpness = user.dna.species.attack_sharpness
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_AIMED)
				atk_delay *= 1.5
	if(user.attributes)
		atk_damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm <b>[target]</b>!"))
		user.changeNext_move(CLICK_CD_MELEE)
		return FALSE
	if((user != target) && target.check_block())
		user.do_attack_animation(target, no_effect = TRUE)
		target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s [attack_verb]!"), \
						span_userdanger("I block <b>[user]</b>'s [attack_verb]!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						user)
		if(user != target)
			to_chat(user, span_userdanger("My [atk_verb] at <b>[target]</b> was blocked!"))
		log_combat(user, target, "attempted to [attack_verb], was blocked by")
		user.changeNext_move(atk_delay)
		return FALSE
	if((user != target) && atk_damage)
		if(target.check_shields(user, atk_damage, "<b>[user]</b>'s [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(atk_delay)
			return FALSE
		if(target.check_parry(user, atk_damage, "<b>[user]</b>'s [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			return FALSE
		if(target.check_dodge(user, atk_damage, "<b>[user]</b>'s [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
			user.do_attack_animation(target, no_effect = TRUE)
			return FALSE
	if(attacker_style?.harm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE

	user.do_attack_animation(target, atk_effect, no_effect = TRUE)

	var/obj/item/bodypart/attacking_part
	switch(atk_effect)
		if(ATTACK_EFFECT_BITE)
			attacking_part = user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		if(ATTACK_EFFECT_KICK)
			attacking_part = user.get_active_foot()
		else
			attacking_part = user.get_active_hand()
	if(!attacking_part)
		atk_damage = 0
	else
		atk_damage *= (attacking_part.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))

	///melee skill
	var/skill_modifier = GET_MOB_ATTRIBUTE_VALUE(user, STAT_DEXTERITY)
	//kicking and biting are harder than punching
	if((atk_effect == ATTACK_EFFECT_BITE) == (atk_effect == ATTACK_EFFECT_KICK))
		skill_modifier = max(0, skill_modifier - 2)
	///calculate the odds that a punch misses entirely
	var/hit_modifier = 0
	///chance to hit the wrong zone
	var/hit_zone_modifier = 0
	if(affecting)
		hit_modifier = affecting.hit_modifier
		hit_zone_modifier = affecting.hit_zone_modifier
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
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_WEAK)
				atk_damage *= 0.35
				//token amount of fatigue loss since the attack sux
				user.adjustFatigueLoss(2)
			if(CS_STRONG)
				//more damage, more stamina cost
				atk_damage *= 2
				user.adjustFatigueLoss(atk_cost*1.5)
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN)
				user.update_dodging_cooldown(DODGING_COOLDOWN)
			if(CS_AIMED)
				user.adjustFatigueLoss(atk_cost)
				skill_modifier += 4
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN)
				user.update_dodging_cooldown(DODGING_COOLDOWN)
			else
				user.adjustFatigueLoss(atk_cost)
	else
		if(user.combat_style == CS_WEAK)
			//token amount of fatigue loss since the attack sux
			user.adjustFatigueLoss(2)
		else
			//normal attack cost
			user.adjustFatigueLoss(atk_cost)
	//future-proofing for species that have 0 damage/weird cases where no zone is targeted
	var/diceroll = user.diceroll(skill_modifier+hit_modifier)
	if(!affecting)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"), \
							span_userdanger("<b>[user]</b>'s tries to [atk_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [atk_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] [user.p_themselves()] on \the [hit_area], but that limb is missing!"), \
							span_userdanger("I try to [atk_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [atk_verb], limb missing")
		return FALSE
	else if(diceroll <= DICE_FAILURE)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] <b>[target]</b>'s [hit_area], but misses!"), \
							span_userdanger("<b>[user]</b>'s tries to [atk_verb] my [hit_area], but misses!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [atk_verb] <b>[target]</b>'s [hit_area], but miss!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] [user.p_themselves()] on \the [hit_area], but misses!"), \
							span_userdanger("I try to [atk_verb] my [hit_area], but miss!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [atk_verb], missed")
		return FALSE

	// hit the wrong body zone
	if(user.diceroll(skill_modifier+hit_zone_modifier) <= DICE_FAILURE)
		affecting = target.get_bodypart(ran_zone(user.zone_selected, 0))

	var/armor_block = target.run_armor_check(affecting, MELEE, sharpness = atk_sharpness)
	var/armor_reduce = target.run_subarmor_check(affecting, MELEE, sharpness = atk_sharpness)
	var/subarmor_flags = target.get_subarmor_flags(affecting)
	var/edge_protection = target.get_edge_protection(affecting)

	var/real_attack_sound = user.dna.species.attack_sound
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			real_attack_sound = user.dna.species.bite_sound
		if(SPECIAL_ATK_KICK)
			real_attack_sound = user.dna.species.kick_sound
	playsound(target.loc, real_attack_sound, 60, TRUE, -1)

	if(atk_damage < 0)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] <b>[target]</b>'s [hit_area], with no effect!"), \
							span_userdanger("<b>[user]</b>'s tries to [atk_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [atk_verb] <b>[target]</b>'s [hit_area], with no effect!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [atk_verb] [user.p_themselves()] on \the [hit_area], with no effect!"), \
							span_userdanger("I try to [atk_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [atk_verb], no effect")
		return FALSE

	target.lastattacker = user.real_name
	target.lastattackerckey = user.ckey
	user.dna.species.spec_unarmedattacked(user, target)

	if(user.limb_destroyer)
		target.dismembering_strike(user, def_zone)

	target.apply_damage(atk_damage, \
						user.dna.species.attack_type, \
						affecting, \
						armor_block, \
						sharpness = atk_sharpness, \
						reduced = armor_reduce, \
						edge_protection = edge_protection, \
						subarmor_flags = subarmor_flags)
	target.apply_damage(atk_damage*1.5, STAMINA, affecting)
	target.damage_armor(atk_damage+atk_armor_damage, MELEE, user.dna.species.attack_type, atk_sharpness, affecting)
	post_hit_effects(target, user, affecting, atk_effect, atk_damage, MELEE, user.dna.species.attack_type, NONE, def_zone, intended_zone, modifiers)
	if(def_zone == intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> [atk_verb_continuous] <b>[target]</b>'s [hit_area]![target.wound_message]"), \
							span_userdanger("<b>[user]</b> [atk_verb_continuous] my [hit_area]![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("I [atk_verb] <b>[target]</b>'s [hit_area]![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> [atk_verb_continuous] [user.p_themselves()] on \the [hit_area]![target.wound_message]"), \
							span_userdanger("I [atk_verb] myself on \the [hit_area]![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	else
		var/parsed_intended_zone = parse_zone(intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> aims for \the [parsed_intended_zone], but [atk_verb_continuous] <b>[target]</b>'s [hit_area] instead![target.wound_message]"), \
							span_userdanger("<b>[user]</b> aims for \the [parsed_intended_zone], but [atk_verb_continuous] my [hit_area] instead![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("I aim for the [parsed_intended_zone], but [atk_verb] <b>[target]</b>'s [hit_area] instead![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> aims for \the [parsed_intended_zone], but [atk_verb_continuous] [user.p_themselves()] on \the [hit_area] instead![target.wound_message]"), \
							span_userdanger("I aim for \the [parsed_intended_zone], but [atk_verb] myself on \the [hit_area] instead![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
	log_combat(user, target, "[atk_verb]")
	SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	return TRUE

/datum/species/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style, list/modifiers, biting_grab = FALSE)
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

/datum/species/proc/spec_attack_foot(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_FOOT, M, H, attacker_style)

	return harm(M, H, attacker_style, modifiers, SPECIAL_ATK_KICK)

/datum/species/proc/spec_attack_jaw(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, list/modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_JAW, M, H, attacker_style)
	return grab(M, H, attacker_style, modifiers, biting_grab = TRUE)

//Weapon can be an attack effect instead
/datum/species/proc/post_hit_effects(mob/living/carbon/human/victim, \
									mob/living/carbon/human/attacker, \
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
			var/turf/edge_target_turf = get_edge_target_turf(victim, get_dir(attacker, victim))
			if(istype(edge_target_turf))
				victim.safe_throw_at(edge_target_turf, \
									knockback_tiles, \
									knockback_tiles, \
									attacker, \
									spin = FALSE, \
									force = victim.move_force, \
									callback = CALLBACK(victim, /mob/living/carbon/proc/handle_knockback, get_turf(victim)))
	return TRUE
