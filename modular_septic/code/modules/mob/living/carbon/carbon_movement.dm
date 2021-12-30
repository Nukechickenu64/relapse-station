/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(.)
		for(var/thing in all_injuries)
			var/datum/injury/injury = thing
			injury.movement_infect(src)
		for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.movement_jostle(src))
				break
		// Floating is easy
		if(!(movement_type & FLOATING))
			var/is_sprinting = (combat_flags & COMBAT_FLAG_SPRINTING)
			var/germ_level_increase = GERM_LEVEL_MOVEMENT_INCREASE
			//sprinting makes you sweaty faster
			if(is_sprinting)
				germ_level_increase *= 2
				if(prob(75))
					sound_hint()
			else
				switch(m_intent)
					if(MOVE_INTENT_RUN)
						if(prob(50))
							sound_hint()
					if(MOVE_INTENT_WALK)
						if(prob(10))
							sound_hint()
			adjust_germ_level(germ_level_increase)
			if(!pulledby)
				if(is_sprinting)
					sprint_loss_tiles(1)
				if(HAS_TRAIT(src, TRAIT_NOHUNGER))
					set_nutrition(NUTRITION_LEVEL_FED - 1) //just less than feeling vigorous
				else if(nutrition && stat != DEAD)
					adjust_nutrition(-(total_nutriment_req/10))
					if(combat_flags & COMBAT_FLAG_SPRINTING)
						adjust_nutrition(-(total_nutriment_req/10))
				if(HAS_TRAIT(src, TRAIT_NOTHIRST))
					set_hydration(HYDRATION_LEVEL_HYDRATED - 1)
				else if(hydration && stat != DEAD)
					adjust_hydration(-(total_hydration_req/10))
					if(combat_flags & COMBAT_FLAG_SPRINTING)
						adjust_hydration(-(total_hydration_req/10))
				switch(encumbrance)
					if(ENCUMBRANCE_EXTREME)
						adjustFatigueLoss(5)
					if(ENCUMBRANCE_HEAVY)
						adjustFatigueLoss(1)

/mob/living/carbon/update_move_intent_slowdown()
	. = ..()
	update_basic_speed_modifier()

/mob/living/carbon/set_usable_legs(new_value)
	. = ..()
	if(isnull(.))
		return

	if(. < 3 && usable_legs >= 3)
		REMOVE_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else if(usable_legs < 3 && !(movement_type & (FLYING | FLOATING))) //From having enough usable legs to no longer having them
		ADD_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		if(!usable_hands)
			ADD_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

	if(usable_legs < default_num_legs)
		ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

/mob/living/carbon/on_lying_down(new_lying_angle)
	. = ..()
	movement_locked = TRUE
	ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, LYING_DOWN_TRAIT)

/mob/living/carbon/on_standing_up()
	. = ..()
	movement_locked = FALSE
	REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, LYING_DOWN_TRAIT)

/mob/living/carbon/Bump(atom/A)
	. = ..()
	if(((combat_flags & COMBAT_FLAG_SPRINTING) || HAS_TRAIT(src, TRAIT_STUMBLE)) && !CanPass(src, get_turf(A)))
		A.on_rammed(src)

/mob/living/carbon/proc/ram_stun()
	//Deal with knockdown
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)))
		if(DICE_SUCCESS)
			Immobilize(2 SECONDS)
		if(DICE_FAILURE)
			Immobilize(2 SECONDS)
			CombatKnockdown(rand(50, 75))
		if(DICE_CRIT_FAILURE)
			drop_all_held_items()
			Immobilize(5 SECONDS)
			CombatKnockdown(rand(75, 100))
	//Deal with damage
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)))
		if(DICE_SUCCESS)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))/2)
			else
				take_bodypart_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))/2)
		if(DICE_FAILURE)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage(ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))
			else
				take_bodypart_damage(ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))
		if(DICE_CRIT_FAILURE)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 2)
			else
				take_bodypart_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 2)
	SEND_SIGNAL(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)

/// Proc to get a movespeed mod from stance limb efficiency
/mob/living/carbon/proc/update_stance_efficiency()
	var/datum/movespeed_modifier/base_speed
	switch(m_intent)
		if(MOVE_INTENT_RUN)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_WALK)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
	var/stance_efficiency = 0
	for(var/thing in bodyparts)
		var/obj/item/bodypart/leg = thing
		if(leg.stance_index)
			stance_efficiency += (leg.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)/default_num_legs
	var/final_speed_modifier = 2*((1-stance_efficiency)*(get_basic_speed()-base_speed.multiplicative_slowdown))
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/limb_efficiency, TRUE, -final_speed_modifier)
