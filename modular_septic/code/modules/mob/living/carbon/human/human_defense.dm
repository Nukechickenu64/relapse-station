/mob/living/carbon/human/attacked_by(obj/item/I, mob/living/user)
	if(!I || !user)
		return FALSE

	var/obj/item/bodypart/affecting
	if(user == src)
		affecting = get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target
	else
		affecting = get_bodypart(check_zone(user.zone_selected))
		var/hit_modifier = 0
		var/hit_zone_modifier = 0
		if(affecting)
			hit_modifier = affecting.hit_modifier
			hit_zone_modifier = affecting.hit_zone_modifier
			//very hard to miss when hidden by fov
			if(!(src in fov_viewers(2, user)))
				hit_modifier += 5
				hit_zone_modifier += 5
			//easy to kick people when they are down
			if((body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
				hit_modifier += 4
				hit_zone_modifier += 4
		var/diceroll = DICE_FAILURE
		var/skill_modifier = 0
		var/attributes_used = 0
		if(I.skill_melee)
			skill_modifier += GET_MOB_SKILL_VALUE(user, I.skill_melee)
			attributes_used += 1
		if(user.diceroll(skill_modifier+hit_modifier) <= DICE_FAILURE)
			affecting = null
		else
			diceroll = user.diceroll(skill_modifier+hit_zone_modifier, 10*attributes_used, 3*attributes_used, 6)
			if(diceroll <= DICE_FAILURE)
				affecting = get_bodypart(ran_zone(user.zone_selected, 0))
			else
				affecting = get_bodypart(check_zone(user.zone_selected))
	var/target_area = parse_zone(check_zone(user.zone_selected)) //our intended target

	SEND_SIGNAL(I, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)

	SSblackbox.record_feedback("nested tally", "item_used_for_combat", 1, list("[I.force]", "[I.type]"))
	SSblackbox.record_feedback("tally", "zone_targeted", 1, target_area)

	//No bodypart? That means we missed
	if(!affecting)
		var/attack_message = "attack"
		if(LAZYLEN(I.attack_verb_simple))
			attack_message = pick(I.attack_verb_simple)
		visible_message(span_danger("<b>[user]</b> tries to [attack_message] <b>[src]</b>'s [target_area] with [I], but misses!"), \
			span_userdanger("<b>[user]</b> tries to [attack_message] my [target_area] with [I], but misses!"), \
			span_hear("I hear a swoosh!"), \
			vision_distance = COMBAT_MESSAGE_RANGE, \
			ignored_mobs = user)
		if(user != src)
			to_chat(user, span_userdanger("I try to [attack_message] <b>[src]</b>'s [target_area] with my [I], but miss!"))
		playsound(user, 'modular_septic/sound/attack/punchmiss.ogg', I.get_clamped_volume(), extrarange = I.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
		return FALSE

	if(!(I.item_flags & NOBLUDGEON))
		playsound(user, I.hitsound, I.get_clamped_volume(), TRUE, extrarange = I.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
	else
		playsound(user, 'sound/weapons/tap.ogg', I.get_clamped_volume(), TRUE, -1)
	// the attacked_by code varies among species
	return dna.species.spec_attacked_by(I, user, affecting, src)

/mob/living/carbon/human/check_shields(atom/AM, \
									damage = 0, \
									attack_text = "the attack", \
									attack_type = MELEE_ATTACK)
	for(var/obj/item/held_item in held_items)
		//Parrying with clothing would be bad
		if(!isclothing(held_item))
			var/signal_return = held_item.hit_reaction(src, AM, attack_text, damage, attack_type)
			if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
				return signal_return
	if(wear_suit)
		var/signal_return = wear_suit.hit_reaction(src, AM, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(w_uniform)
		var/signal_return = w_uniform.hit_reaction(src, AM, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_neck)
		var/signal_return = wear_neck.hit_reaction(src, AM, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(head)
		var/signal_return = head.hit_reaction(src, AM, attack_text, damage, attack_type)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	return FALSE

/mob/living/carbon/human/do_cpr(mob/living/carbon/target, cpr_type = CPR_CHEST)
	if(target == src)
		return

	CHECK_DNA_AND_SPECIES(target)

	var/obj/item/bodypart/mouth/jaw = target.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
	var/obj/item/bodypart/chest/chest = target.get_bodypart(BODY_ZONE_CHEST)
	var/medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_MEDICINE)
	switch(cpr_type)
		if(CPR_CHEST)
			if(chest?.is_robotic_limb())
				medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_ELECTRONICS)
		if(CPR_MOUTH)
			if(jaw?.is_robotic_limb())
				medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_ELECTRONICS)

	if(DOING_INTERACTION_WITH_TARGET(src, target))
		return FALSE

	target.add_fingerprint(src)
	switch(cpr_type)
		if(CPR_MOUTH)
			if(is_mouth_covered())
				to_chat(src, span_warning("I need to remove my mask first!"))
				return FALSE

			if(target.is_mouth_covered())
				to_chat(src, span_warning("I need to remove [p_their()] mask first!"))
				return FALSE

			if(!jaw)
				to_chat(src, span_warning("I have no mouth!"))
				return FALSE

			if(HAS_TRAIT(src, TRAIT_NOBREATH))
				to_chat(src, span_warning("I can't breathe!"))
				return FALSE

			if(!getorganslot(ORGAN_SLOT_LUNGS))
				to_chat(src, span_warning("I have no lungs!"))
				return FALSE

			if(world.time >= target.last_mtom + M2M_COOLDOWN)
				var/they_breathe = !HAS_TRAIT(target, TRAIT_NOBREATH)
				var/obj/item/organ/lungs/they_lung = target.getorganslot(ORGAN_SLOT_LUNGS)
				visible_message(span_notice("<b>[src]</b> performs mouth to mouth on <b>[target]</b>!"), \
								span_notice("I perform mouth to mouth on <b>[target]</b>."),
								span_hear("I hear loud breathing."),
								vision_distance = COMBAT_MESSAGE_RANGE,
								ignored_mobs = target)
				target.last_mtom = world.time
				log_combat(src, target, "M2Med")
				if(they_breathe && they_lung)
					var/epinephrine_mod = 0
					if(target.reagents?.get_reagent_amount(/datum/reagent/medicine/epinephrine) >= 1)
						epinephrine_mod += 5
					target.adjustOxyLoss(-(medical_skill + epinephrine_mod))
					target.updatehealth()
					to_chat(target, span_unconscious("I feel a breath of fresh air enter my lungs... It feels good..."))
				else if(they_breathe && !they_lung)
					to_chat(target, span_unconscious("I feel a breath of fresh air... But i don't feel any better..."))
				else
					to_chat(target, span_unconscious("I feel a breath of fresh air... Which is a sensation i don't recognise..."))
		if(CPR_CHEST)
			var/mob/living/carbon/human/humie = target
			if(istype(humie))
				var/obj/item/clothing/suit = humie.wear_suit
				var/obj/item/clothing/under = humie.w_uniform
				if(istype(under) && CHECK_BITFIELD(under.clothing_flags, THICKMATERIAL))
					to_chat(src, span_warning("I need to take [humie.p_their()] [under] off!"))
					return
				else if(istype(suit) && CHECK_BITFIELD(suit.clothing_flags, THICKMATERIAL))
					to_chat(src, span_warning("I need to take [humie.p_their()] [suit] off!"))
					return

			if(world.time >= target.last_cpr + CPR_COOLDOWN)
				var/they_beat = !HAS_TRAIT(target, TRAIT_STABLEHEART)
				var/obj/item/organ/heart/they_heart = target.getorganslot(ORGAN_SLOT_HEART)
				var/heart_exposed_mod = 0
				if(CHECK_MULTIPLE_BITFIELDS(chest.how_open(), SURGERY_INCISED|SURGERY_RETRACTED|SURGERY_BROKEN) && istype(they_heart))
					heart_exposed_mod += 5
					visible_message(span_notice("<b>[src]</b> massages <b>[target]</b>'s [they_heart]!"), \
								span_notice("I massage <b>[target]</b>'s [they_heart]."), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = target)
				else
					visible_message(span_notice("<b>[src]</b> performs CPR on <b>[target]</b>!"), \
								span_notice("I perform CPR on <b>[target]</b>."), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = target)
				if(target.stat >= DEAD || target.undergoing_cardiac_arrest())
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "cpr", /datum/mood_event/saved_life)
				target.last_cpr = world.time
				log_combat(src, target, "CPRed")
				if(they_beat && they_heart)
					to_chat(target, span_unconscious("I feel my heart being pumped..."))
				else if(they_beat && !they_heart)
					to_chat(target, span_unconscious("I feel my chest being pumped... But i don't feel any better..."))
				else
					to_chat(target, span_unconscious("I feel my chest being pushed on..."))
				var/epinephrine_mod = 0
				if(target.reagents?.get_reagent_amount(/datum/reagent/medicine/epinephrine) >= 1)
					epinephrine_mod +=  3

				var/diceroll = diceroll(medical_skill+heart_exposed_mod+epinephrine_mod)
				if((diceroll >= DICE_SUCCESS) || !attributes)
					if(prob(35) || (diceroll >= DICE_CRIT_SUCCESS))
						target?.pump_heart(src)
						target.set_heartattack(FALSE)
						if(GETBRAINLOSS(target) >= 100)
							SETBRAINLOSS(target, 99)
						if(target.revive())
							target.grab_ghost(TRUE)
							target.visible_message(span_warning("<b>[target]</b> limply spasms their muscles."), \
											span_userdanger("My muscles spasm as i am brought back to life!"))
				else
					if(diceroll <= DICE_CRIT_FAILURE)
						var/obj/item/organ/bone/ribs = chest.getorganslot(ORGAN_SLOT_BONE)
						if(ribs)
							if(!ribs.dislocate() && !ribs.fracture())
								ribs.compound_fracture()
							visible_message(span_danger("<b>[src]</b> botches the CPR, cracking <b>[target]</b>'s [ribs.name]!"), \
										span_danger("I botch the CPR, cracking <b>[target]</b>'s [ribs.name]!"),
										span_hear("I hear a loud crack!"),
										ignored_mobs = target)
							to_chat(target, span_userdanger("<b>[src]</b> botches the CPR and cracks my [ribs.name]!"))
							SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)

/mob/living/carbon/human/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	if(damage_type != BRUTE && damage_type != BURN)
		return

	damage_amount *= 0.5 //0.5 multiplier for balance reason, we don't want clothes to be too easily destroyed
	var/list/torn_items = list()

	//HEAD//
	if(!def_zone || (def_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)))
		var/obj/item/clothing/head_clothes = null
		if(wear_neck && (wear_neck.body_parts_covered & HEAD))
			head_clothes = wear_neck
		if(wear_mask && (wear_mask.body_parts_covered & HEAD))
			head_clothes = wear_mask
		if(head && (head.body_parts_covered & HEAD))
			head_clothes = head
		if(head_clothes)
			torn_items |= head_clothes
		else if(ears && (ears.body_parts_covered & HEAD))
			torn_items |= ears

	//NECK//
	if(!def_zone || (def_zone == BODY_ZONE_PRECISE_NECK))
		if(wear_neck && (wear_neck.body_parts_covered & NECK))
			torn_items |= wear_neck

	//EYES//
	if(!def_zone || (def_zone in list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)))
		if(wear_mask && (wear_mask.body_parts_covered & EYES))
			torn_items |= wear_mask
		else if(glasses)
			torn_items |= glasses

	//CHEST//
	if(!def_zone || (def_zone == BODY_ZONE_CHEST))
		var/obj/item/clothing/chest_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & CHEST))
			chest_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & CHEST))
			chest_clothes = wear_suit
		if(chest_clothes)
			torn_items |= chest_clothes

	//GROIN//
	if(!def_zone || (def_zone == BODY_ZONE_PRECISE_GROIN))
		var/obj/item/clothing/groin_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & GROIN))
			groin_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & GROIN))
			groin_clothes = wear_suit
		if(groin_clothes)
			torn_items |= groin_clothes

	//ARMS//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)))
		var/obj/item/clothing/arm_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & ARMS))
			arm_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & ARMS))
			arm_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & ARMS))
			arm_clothes = wear_suit
		if(arm_clothes)
			torn_items |= arm_clothes

	//HANDS//
	if(!def_zone || (def_zone in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		var/obj/item/clothing/hand_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & HANDS))
			hand_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & HANDS))
			hand_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & HANDS))
			hand_clothes = wear_suit
		if(hand_clothes)
			torn_items |= hand_clothes

	//LEGS//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/leg_clothes = null
		if(shoes && (shoes.body_parts_covered & LEGS))
			leg_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & LEGS))
			leg_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & LEGS))
			leg_clothes = wear_suit
		if(leg_clothes)
			torn_items |= leg_clothes

	//FEET//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/feet_clothes = null
		if(shoes && (shoes.body_parts_covered & FEET))
			feet_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & FEET))
			feet_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & FEET))
			feet_clothes = wear_suit
		if(feet_clothes)
			torn_items |= feet_clothes

	for(var/thing in torn_items)
		var/obj/item/item = thing
		item.take_damage(damage_amount, damage_type, damage_flag, 0)

/mob/living/carbon/human/acid_act(acidpwr, acid_volume, bodyzone_hit) //todo: update this to utilize check_obscured_slots() //and make sure it's check_obscured_slots(TRUE) to stop aciding through visors etc
	var/list/damaged_bodyparts = list()
	var/list/inventory_items_to_kill = list()
	var/acidity = acidpwr * min(acid_volume*0.005, 0.1)

	//HEAD//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)))
		var/obj/item/clothing/head_clothes = null
		if(wear_neck && (wear_neck.body_parts_covered & HEAD))
			head_clothes = wear_neck
		if(wear_mask && (wear_mask.body_parts_covered & HEAD))
			head_clothes = wear_mask
		if(head && (head.body_parts_covered & HEAD))
			head_clothes = head
		if(head_clothes)
			inventory_items_to_kill |= head_clothes
		else
			var/obj/item/bodypart/shoeonhead = get_bodypart(BODY_ZONE_PRECISE_FACE)
			if(!shoeonhead)
				shoeonhead = get_bodypart(BODY_ZONE_HEAD)
			if(shoeonhead)
				damaged_bodyparts |= shoeonhead
			if(ears && (ears.body_parts_covered & HEAD))
				inventory_items_to_kill |= ears

	//NECK//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_PRECISE_NECK))
		if(wear_neck && (wear_neck.body_parts_covered & NECK))
			inventory_items_to_kill |= wear_neck
		else
			var/obj/item/bodypart/shoeonneck = get_bodypart(BODY_ZONE_PRECISE_NECK)
			if(shoeonneck)
				damaged_bodyparts |= shoeonneck

	//EYES//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)))
		if(wear_mask && (wear_mask.body_parts_covered & EYES))
			inventory_items_to_kill |= wear_mask
		else if(glasses)
			inventory_items_to_kill |= glasses
		else
			var/obj/item/bodypart/sightless = get_bodypart(BODY_ZONE_PRECISE_R_EYE)
			if(sightless)
				damaged_bodyparts |= sightless
			sightless = get_bodypart(BODY_ZONE_PRECISE_L_EYE)
			if(sightless)
				damaged_bodyparts |= sightless

	//CHEST//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_CHEST))
		var/obj/item/clothing/chest_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & CHEST))
			chest_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & CHEST))
			chest_clothes = wear_suit
		if(chest_clothes)
			inventory_items_to_kill |= chest_clothes
		else
			var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
			if(chest)
				damaged_bodyparts |= chest

	//GROIN//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_PRECISE_GROIN))
		var/obj/item/clothing/groin_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & GROIN))
			groin_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & GROIN))
			groin_clothes = wear_suit
		if(groin_clothes)
			inventory_items_to_kill |= groin_clothes
		else
			var/obj/item/bodypart/groin = get_bodypart(BODY_ZONE_PRECISE_GROIN)
			if(groin)
				damaged_bodyparts |= groin

	//ARMS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)))
		var/obj/item/clothing/arm_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & ARMS))
			arm_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & ARMS))
			arm_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & ARMS))
			arm_clothes = wear_suit
		if(arm_clothes)
			inventory_items_to_kill |= arm_clothes
		else
			var/obj/item/bodypart/arm = get_bodypart(BODY_ZONE_R_ARM)
			if(arm)
				damaged_bodyparts |= arm
			arm = get_bodypart(BODY_ZONE_L_ARM)
			if(arm)
				damaged_bodyparts |= arm

	//HANDS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		var/obj/item/clothing/hand_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & HANDS))
			hand_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & HANDS))
			hand_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & HANDS))
			hand_clothes = wear_suit
		if(hand_clothes)
			inventory_items_to_kill |= hand_clothes
		else
			var/obj/item/bodypart/hand = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(hand)
				damaged_bodyparts |= hand
			hand = get_bodypart(BODY_ZONE_PRECISE_L_HAND)
			if(hand)
				damaged_bodyparts |= hand

	//LEGS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/leg_clothes = null
		if(shoes && (shoes.body_parts_covered & LEGS))
			leg_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & LEGS))
			leg_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & LEGS))
			leg_clothes = wear_suit
		if(leg_clothes)
			inventory_items_to_kill |= leg_clothes
		else
			var/obj/item/bodypart/leg = get_bodypart(BODY_ZONE_R_LEG)
			if(leg)
				damaged_bodyparts |= leg
			leg = get_bodypart(BODY_ZONE_L_LEG)
			if(leg)
				damaged_bodyparts |= leg

	//FEET//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/feet_clothes = null
		if(shoes && (shoes.body_parts_covered & FEET))
			feet_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & FEET))
			feet_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & FEET))
			feet_clothes = wear_suit
		if(feet_clothes)
			inventory_items_to_kill |= feet_clothes
		else
			var/obj/item/bodypart/foot = get_bodypart(BODY_ZONE_PRECISE_R_EYE)
			if(foot)
				damaged_bodyparts |= foot
			foot = get_bodypart(BODY_ZONE_PRECISE_L_FOOT)
			if(foot)
				damaged_bodyparts |= foot

	//DAMAGE//
	for(var/obj/item/bodypart/affecting as anything in damaged_bodyparts)
		affecting.receive_damage(burn = 2*acidity)
		if(affecting.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH))
			if(prob(min(acidpwr*acid_volume/10, 90))) //Applies disfigurement
				affecting.receive_damage(burn = 2*acidity)
				death_scream()
				facial_hairstyle = "Shaved"
				hairstyle = "Bald"
				update_hair()
				ADD_TRAIT(src, TRAIT_DISFIGURED, ACID)

		update_damage_overlays()

	//MELTING INVENTORY ITEMS//
	//these items are all outside of armour visually, so melt regardless.
	if(!bodyzone_hit)
		if(back)
			inventory_items_to_kill |= back
		if(belt)
			inventory_items_to_kill |= belt

		for(var/thing in held_items)
			if(!thing)
				continue
			inventory_items_to_kill |= held_items
	for(var/obj/item/inventory_item in inventory_items_to_kill)
		inventory_item.acid_act(acidpwr, acid_volume)

	return TRUE

/mob/living/carbon/human/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_hand(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/attack_foot(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_foot(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/attack_jaw(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_jaw(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		if(src == attack_target)
			check_self_for_injuries()
		return

	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		switch(special_attack)
			if(SPECIAL_ATK_BITE)
				UnarmedJaw(attack_target, proximity_flag, modifiers)
			if(SPECIAL_ATK_KICK)
				UnarmedFoot(attack_target, proximity_flag, modifiers)
			else
				UnarmedHand(attack_target, proximity_flag, modifiers)
	else
		UnarmedHand(attack_target, proximity_flag, modifiers)

/mob/living/carbon/human/UnarmedHand(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_hand = get_active_hand()
	if(!check_hand)
		to_chat(src, span_notice("I look at my phantom hand and sigh."))
		return
	else if(check_hand?.bodypart_disabled)
		to_chat(src, span_warning("My [check_hand.name] is in no condition to be used."))
		return
	else if(proximity_flag)
		for(var/thing in check_hand.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_hand(src, check_hand, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	// Special glove functions:
	// If the gloves do anything, have them return 1 to stop
	// normal attack_hand() here.
	var/obj/item/clothing/gloves/our_gloves = gloves // not typecast specifically enough in defines
	if(proximity_flag && istype(our_gloves) && our_gloves.Touch(attack_target, proximity_flag, modifiers))
		return

	//This signal is needed to prevent gloves of the north star + hulk.
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers)) //Because species like monkeys dont use attack hand
		return

	if(!right_click_attack_chain(attack_target, modifiers))
		attack_target.attack_hand(src, modifiers)

/mob/living/carbon/human/UnarmedFoot(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_foot = get_active_foot()
	if(!check_foot)
		to_chat(src, span_notice("I look at my phantom foot and sigh."))
		return
	else if(check_foot?.bodypart_disabled)
		to_chat(src, span_warning("My [check_foot.name] is in no condition to be used."))
		return
	else if(attack_target == src)
		to_chat(src, span_warning("I can't kick myself."))
		return
	else if(proximity_flag)
		for(var/thing in check_foot.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_foot(src, check_foot, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	//This signal is needed to prevent gloves of the north star + hulk
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	//Because species like monkeys dont use attack hand
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers))
		return

	attack_target.attack_foot(src, modifiers)

/mob/living/carbon/human/UnarmedJaw(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_jaw = get_bodypart(BODY_ZONE_PRECISE_MOUTH)
	if(!check_jaw)
		to_chat(src, span_notice("I look at my phantom jaw and sigh."))
		return
	else if(check_jaw?.bodypart_disabled)
		to_chat(src, span_warning("My [check_jaw.name] is in no condition to be used."))
		return
	else if(proximity_flag)
		for(var/thing in check_jaw.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_jaw(src, check_jaw, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	if(is_mouth_covered())
		to_chat(src, span_warning("My mouth is covered."))
		return
	if(attack_target == src)
		var/static/list/unacceptable_limbs = list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE, \
										BODY_ZONE_PRECISE_NECK, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
		if(check_zone(zone_selected) in unacceptable_limbs)
			to_chat(src, span_warning("I can't bite myself there."))
			return

	//This signal is needed to prevent gloves of the north star + hulk
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	//Because species like monkeys dont use attack hand
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers))
		return

	attack_target.attack_jaw(src, modifiers)

/mob/living/carbon/human/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	//SPECIES STUFF
	if(dna?.species)
		var/spec_return = dna.species.bullet_act(hitting_projectile, src)
		if(spec_return)
			return spec_return

	//MARTIAL ART STUFF
	if(mind)
		if(mind.martial_art && mind.martial_art.can_use(src)) //Some martial arts users can deflect projectiles!
			var/martial_art_result = mind.martial_art.on_projectile_hit(src, hitting_projectile, def_zone)
			if(!(martial_art_result == BULLET_ACT_HIT))
				return martial_art_result

	//Can't shoot missing limbs or stumps
	var/obj/item/bodypart/affecting = get_bodypart_nostump(check_zone(def_zone))
	if(!affecting)
		return BULLET_ACT_FORCE_PIERCE

	//Can't block or reflect when shooting yourself
	if(!(hitting_projectile.original == src && hitting_projectile.firer == src))
		if(hitting_projectile.reflectable & REFLECT_NORMAL)
			if(check_reflect(def_zone)) // Checks if you've passed a reflection% check
				visible_message(span_danger("The [hitting_projectile.name] gets reflected by <b>[src]</b>!"), \
								span_userdanger("I deflect \the <b>[hitting_projectile.name]</b>!"))
				// Find a turf near or on the original location to bounce to
				if(!isturf(loc)) //Open canopy mech (ripley) check. if we're inside something and still got hit
					hitting_projectile.force_hit = TRUE //The thing we're in passed the bullet to us. Pass it back, and tell it to take the damage.
					loc.bullet_act(hitting_projectile, def_zone, piercing_hit)
					return BULLET_ACT_HIT
				if(hitting_projectile.starting)
					var/new_x = hitting_projectile.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/new_y = hitting_projectile.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/turf/curloc = get_turf(src)

					// redirect the projectile
					hitting_projectile.original = locate(new_x, new_y, hitting_projectile.z)
					hitting_projectile.starting = curloc
					hitting_projectile.firer = src
					hitting_projectile.yo = new_y - curloc.y
					hitting_projectile.xo = new_x - curloc.x
					var/new_angle_s = hitting_projectile.Angle + rand(120,240)
					while(new_angle_s > 180) // Translate to regular projectile degrees
						new_angle_s -= 360
					hitting_projectile.set_angle(new_angle_s)
				//Complete projectile permutation
				return BULLET_ACT_FORCE_PIERCE
		//Skill issue
		if(!QDELETED(hitting_projectile.firer) && ishuman(hitting_projectile.firer))
			var/mob/living/carbon/firer = hitting_projectile.firer
			var/dist = get_dist(hitting_projectile.starting, src)
			var/skill_modifier = 0
			if(hitting_projectile.skill_ranged)
				skill_modifier += GET_MOB_SKILL_VALUE(firer, hitting_projectile.skill_ranged)
			var/modifier = 0
			modifier += hitting_projectile.diceroll_modifier
			if(LAZYACCESS(hitting_projectile.target_specific_diceroll, src))
				modifier += hitting_projectile.target_specific_diceroll[src]
			//Point blank, very hard to miss
			if(dist <= 1)
				modifier +=  10
			//There is some distance between us
			else
				//Source for this calculation: I made it up
				modifier -= FLOOR(max(0, dist-3) ** PROJECTILE_DICEROLL_DISTANCE_EXPONENT, 1)
			modifier = round_to_nearest(modifier, 1)
			if(firer.diceroll((skill_modifier+modifier)*PROJECTILE_DICEROLL_ATTRIBUTE_MULTIPLIER) <= DICE_FAILURE)
				return BULLET_ACT_FORCE_PIERCE
		if(check_shields(hitting_projectile, hitting_projectile.damage, "\the [hitting_projectile]", BLOCK_FLAG_PROJECTILE))
			hitting_projectile.on_hit(src, 100, def_zone, piercing_hit)
			return BULLET_ACT_HIT

	return ..()
