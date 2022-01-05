/datum/species
	punchdamagelow = 6
	punchdamagehigh = 8
	punchstunthreshold = 16
	attack_sound = list('modular_septic/sound/effects/punch1.wav',
						'modular_septic/sound/effects/punch2.wav',
						'modular_septic/sound/effects/punch3.wav')
	miss_sound = list('modular_septic/sound/effects/punchmiss.ogg')
	attack_effect = ATTACK_EFFECT_PUNCH
	attack_verb = "punch"
	var/attack_verb_continuous = "punches"
	var/kick_effect = ATTACK_EFFECT_KICK
	var/kick_verb = "kick"
	var/kick_verb_continuous = "kicks"
	var/bite_effect = ATTACK_EFFECT_BITE
	var/bite_verb = "bite"
	var/bite_verb_continuous = "bites"

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
			I.fire_act((H.fire_stacks * 50)) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = H.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			H.adjust_bodytemperature(5.5 * delta_time)
		else
			H.adjust_bodytemperature((BODYTEMP_HEATING_MAX + (H.fire_stacks * 12)) * 0.5 * delta_time)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/H, list/modifiers)
	// Allows you to put in item-specific reactions based on species
	var/damage = I.force
	if(user.attributes)
		damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)
	var/weakness = check_species_weakness(I, user)
	if(weakness)
		damage *= weakness
	if((user != H) && damage)
		if(H.check_shields(I, damage, "the [I.name]", MELEE_ATTACK, I.armour_penetration))
			return FALSE
	if((user != H) && H.check_block())
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

	var/armor_block = H.run_armor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					I.armour_penetration, \
					weak_against_armour = I.weak_against_armour, \
					sharpness = I.get_sharpness())
	armor_block = min(95, armor_block) //cap damage reduction at 95%
	var/Iwound_bonus = I.wound_bonus
	var/Iorgan_bonus = I.organ_bonus

	if(damage && !(I.item_flags & NOBLUDGEON))
		apply_damage(damage, \
					I.damtype, \
					def_zone, \
					armor_block, \
					H, \
					wound_bonus = Iwound_bonus, \
					bare_wound_bonus = I.bare_wound_bonus, \
					sharpness = I.get_sharpness(), \
					organ_bonus = Iorgan_bonus, \
					bare_organ_bonus = I.bare_organ_bonus)

	H.send_item_attack_message(I, user, hit_area, affecting)

	if(!(I.item_flags & NOBLUDGEON))
		if((I.damtype == BRUTE) && damage && prob(25 + (damage * 2)))
			if(affecting.is_organic_limb())
				I.add_mob_blood(H) //Make the weapon bloody, not the person.
				if(prob(damage * 2)) //blood spatter!
					var/turf/location = H.loc
					if(istype(location))
						H.do_hitsplatter(get_dir(user, H), min_range = 0, max_range = 2, splatter_loc = pick(FALSE, TRUE))
					if(get_dist(user, H) <= 1) //people with TK won't get smeared with blood
						user.add_mob_blood(H)
					switch(def_zone)
						if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
							/* TODO: Move this into its own proc and add other stuff
							if(!I.get_sharpness() && armor_block < 50)
								if(prob(damage))
									if(H.stat <= SOFT_CRIT)
										H.visible_message(span_danger("<b>[H]</b> is knocked senseless!"), \
														span_userdanger("I am knocked senseless!"))
										H.set_confusion(max(H.get_confusion(), 20))
										H.adjust_blurriness(10)
									if(prob(25))
										H.gain_trauma(/datum/brain_trauma/mild/concussion)

								//rev deconversion through blunt trauma.
								var/datum/antagonist/rev/rev = H.mind?.has_antag_datum(/datum/antagonist/rev)
								if(rev && H.stat == CONSCIOUS && H != user && prob(I.force + H.getBruteLoss() * 0.5)))
									rev.remove_revolutionary(FALSE, user)
							*/
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
		post_hit_effects(H, user, affecting, I, damage, def_zone, intended_zone, modifiers)
	return TRUE

/datum/species/spec_attack_hand(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, list/modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	if((M != H) && !IS_HELP_INTENT(M, modifiers) && H.check_shields(M, 0, M.name, attack_type = UNARMED_ATTACK))
		H.visible_message(span_warning("<b>[M]</b> attempts to touch <b>[H]</b>!"), \
						span_danger("<b>[M]</b> attempts to touch me!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						M)
		to_chat(M, span_warning("I attempt to touch <b>[H]</b>!"))
		log_combat(M, H, "attempted to touch")
		return

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_HAND, M, H, attacker_style)

	switch(M.a_intent)
		if(INTENT_HELP)
			help(M, H, attacker_style, modifiers)
		if(INTENT_DISARM)
			disarm(M, H, attacker_style, modifiers)
		if(INTENT_GRAB)
			grab(M, H, attacker_style, modifiers)
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
	var/atk_delay = CLICK_CD_MELEE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_AIMED)
				atk_delay *= 2
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm <b>[target]</b>!"))
		user.changeNext_move(atk_delay)
		return FALSE
	if((user != target) && target.check_block())
		target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s attack!"), \
						span_userdanger("I block <b>[user]</b>'s attack!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						user)
		if(user != target)
			to_chat(user, span_userdanger("My attack at <b>[target]</b> was blocked!"))
		log_combat(user, target, "attempted to punch, was blocked by")
		user.changeNext_move(atk_delay)
		return FALSE
	if(attacker_style?.harm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE

	var/damage = rand(user.dna.species.punchdamagelow, user.dna.species.punchdamagehigh)
	if(user.attributes)
		damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)

	var/atk_verb
	var/atk_verb_continuous
	var/atk_effect
	var/atk_sharpness = NONE
	var/atk_cost = 3
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			atk_verb = pick(user.dna.species.bite_verb)
			atk_verb_continuous = pick(user.dna.species.bite_verb_continuous)
			atk_effect = pick(user.dna.species.bite_effect)
			atk_sharpness = SHARP_POINTY
			atk_cost *= 1.5
		if(SPECIAL_ATK_KICK)
			atk_verb = pick(user.dna.species.kick_verb)
			atk_verb_continuous = pick(user.dna.species.kick_verb_continuous)
			atk_effect = pick(user.dna.species.kick_effect)
			damage *= 2
			atk_cost *= 2
		else
			atk_verb = pick(user.dna.species.attack_verb)
			atk_verb_continuous = pick(user.dna.species.attack_verb_continuous)
			atk_effect = pick(user.dna.species.attack_effect)

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
		damage = 0
	else
		damage *= (attacking_part.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))

	///melee skill
	var/skill_modifier = GET_MOB_SKILL_VALUE(user, SKILL_MELEE)
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
		if(HAS_TRAIT(user, TRAIT_PERFECT_ATTACKER))
			hit_modifier = 20
			hit_zone_modifier = 20
		//hitting yourself is easy
		if(user == target)
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
				//token amount of fatigue loss since the attack sux
				user.adjustFatigueLoss(1)
			if(CS_STRONG)
				//double damage, double stamina cost
				damage *= 2
				user.adjustFatigueLoss(atk_cost*2)
			if(CS_AIMED)
				//slightly increased stamina cost
				user.adjustFatigueLoss(atk_cost*1.2)
				if(hit_modifier > 0)
					hit_modifier *= 1.4
				if(hit_zone_modifier > 0)
					hit_zone_modifier *= 1.4
				if(skill_modifier > 0)
					skill_modifier *= 1.4
			else
				user.adjustFatigueLoss(atk_cost)
	else
		if(user.combat_style == CS_WEAK)
			//token amount of fatigue loss since the attack sux
			user.adjustFatigueLoss(1)
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

	var/armor_block = target.run_armor_check(affecting, MELEE)

	playsound(target.loc, user.dna.species.attack_sound, 60, TRUE, -1)

	if(damage < 0)
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

	target.apply_damage(damage, user.dna.species.attack_type, affecting, armor_block, sharpness = atk_sharpness)
	target.apply_damage(damage*1.5, STAMINA, affecting)
	if(def_zone == intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> [atk_verb_continuous] <b>[target]</b>'s [hit_area]![target.wound_message]"), \
							span_userdanger("<b>[user]</b> [atk_verb_continuous] my [hit_area]![target.wound_message]"), \
							span_hear("I hear a sickening sound of flesh hitting flesh!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("I [atk_verb] <b>[target]</b>'s [hit_area]!"))
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
	post_hit_effects(target, user, affecting, atk_effect, damage, def_zone, intended_zone, modifiers)

/datum/species/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style, list/modifiers)
	if(target.check_block())
		target.visible_message(span_warning("[target] blocks [user]'s grab!"), \
						span_userdanger("I block [user]'s grab!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						user)
		to_chat(user, span_warning("My grab at [target] was blocked!"))
		log_combat(user, target, "attempted to grab, was blocked by")
		return FALSE
	if(attacker_style?.grab_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	else
		target.grabbedby(user)
		return TRUE

/datum/species/proc/spec_attack_foot(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	if(H.check_shields(M, 0, M.name, attack_type = UNARMED_ATTACK))
		H.visible_message(span_warning("<b>[M]</b> attempts to touch <b>[H]</b>!"), \
						span_danger("<b>[M]</b> attempts to touch me!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						M)
		to_chat(M, span_warning("I attempt to touch <b>[H]</b>!"))
		log_combat(M, H, "attempted to kick")
		return

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_FOOT, M, H, attacker_style)

	harm(M, H, attacker_style, modifiers, SPECIAL_ATK_KICK)

/datum/species/proc/spec_attack_jaw(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style, modifiers)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!attacker_style && M.mind)
		attacker_style = M.mind.martial_art

	if(H.check_shields(M, 0, M.name, attack_type = UNARMED_ATTACK))
		log_combat(M, H, "attempted to touch")
		H.visible_message(span_warning("<b>[M]</b> attempts to touch <b>[H]</b>!"), \
						span_danger("<b>[M]</b> attempts to touch me!"), \
						span_hear("I hear a swoosh!"), \
						COMBAT_MESSAGE_RANGE, \
						M)
		to_chat(M, span_warning("I attempt to touch <b>[H]</b>!"))
		return

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_JAW, M, H, attacker_style)

	harm(M, H, attacker_style, modifiers, SPECIAL_ATK_BITE)

//Weapon can be an attack effect instead
/datum/species/proc/post_hit_effects(mob/living/carbon/human/victim, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage, def_zone, intended_zone, list/modifiers)
	if(!istype(weapon))
		var/atk_verb
		var/atk_effect = weapon
		switch(atk_effect)
			if(ATTACK_EFFECT_KICK)
				atk_verb = pick(user.dna.species.kick_verb)
			if(ATTACK_EFFECT_BITE)
				atk_verb = pick(user.dna.species.bite_verb)
			else
				atk_verb = pick(user.dna.species.attack_verb)
		if((atk_effect != ATTACK_EFFECT_BITE) && (victim.stat != DEAD) && damage >= user.dna.species.punchstunthreshold)
			victim.visible_message(span_danger("<b>[user]</b> knocks <b>[victim]</b> down!"), \
							span_userdanger("I am knocked down by <b>[user]</b>!"), \
							span_hear("I hear aggressive shuffling followed by a loud thud!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			if(user != victim)
				to_chat(user, span_userdanger("I knock <b>[victim]</b> down!"))
			//50 total damage = 40 base stun + 40 stun modifier = 80 stun duration, which is the old base duration
			var/knockdown_duration = 40 + (victim.getStaminaLoss() + (victim.getBruteLoss()*0.5))*0.8
			victim.CombatKnockdown(knockdown_duration/4, knockdown_duration)
			log_combat(user, victim, "got a stun [atk_verb] with their previous [atk_verb]")
