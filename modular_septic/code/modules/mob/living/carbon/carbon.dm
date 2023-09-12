/mob/living/carbon
	var/vomitsound = 'modular_septic/sound/emotes/vomit.wav'

// Carbon mobs always have an organ storage component - it just becomes accessible when necessary.
/mob/living/carbon/Initialize(mapload)
	. = ..()
	LoadComponent(/datum/component/storage/concrete/organ)

/mob/living/carbon/Destroy()
	UnregisterSignal(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	UnregisterSignal(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE)
	QDEL_LIST_ASSOC_VAL(chem_effects)
	if(speech_modifiers)
		for(var/thing in speech_modifiers)
			qdel(thing) // Lazylist
	return ..()

//Each hands saves a specific zone and intent etc
/mob/living/carbon/swap_hand(held_index)
	. = ..()
	if(!.)
		return
	//Update intent and zone selected according to the zone saved
	var/index = min(length(hand_index_to_intent), active_hand_index)
	a_intent_change(hand_index_to_intent[index])
	index = min(length(hand_index_to_throw), active_hand_index)
	if(hand_index_to_throw[index])
		throw_mode_on()
	else
		throw_mode_off()
	index = min(length(hand_index_to_zone), active_hand_index)
	if(hud_used)
		var/atom/movable/screen/zone_sel/zone_sel = hud_used.zone_select
		if(istype(zone_sel))
			zone_sel.set_selected_zone(hand_index_to_zone[index], user = src)
	//Action speed modifiers depending on efficiency
	var/obj/item/bodypart/active_hand = get_active_hand()
	if(active_hand)
		add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/limb_efficiency, (1 - (active_hand.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)) * LIMB_EFFICIENCY_ACTIONSPEED_MULTIPLIER)
	else
		add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/limb_efficiency,  LIMB_EFFICIENCY_ACTIONSPEED_MULTIPLIER)
	update_handedness(active_hand_index)

/mob/living/carbon/throw_mode_off()
	. = ..()
	hand_index_to_throw[active_hand_index] = throw_mode ? TRUE : FALSE

/mob/living/carbon/throw_mode_on()
	. = ..()
	hand_index_to_throw[active_hand_index] = throw_mode ? TRUE : FALSE

//Can't sprint on walk mode
/mob/living/update_move_intent_slowdown()
	. = ..()
	if(m_intent != MOVE_INTENT_RUN)
		disable_sprint()

//Suicide stuff
/mob/living/carbon/revive(full_heal = FALSE, admin_revive = FALSE, excess_healing = 0)
	. = ..()
	var/obj/item/organ/brain/BR = getorgan(/obj/item/organ/brain)
	if(BR.suicided)
		to_chat(src, span_boldwarning("NO! PLEASE, LET ME GO!"))
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "letmedie", /datum/mood_event/letmedie)

//Heal stuff
/mob/living/carbon/fully_heal(admin_revive)
	. = ..()
	var/datum/component/irradiated/uranium_fever = GetComponent(/datum/component/irradiated)
	if(uranium_fever)
		qdel(uranium_fever)
	slurring = 0
	cultslurring = 0
	stuttering = 0
	set_germ_level(GERM_LEVEL_STERILE)
	setFatigueLoss(0)
	setPainLoss(0)
	setShockStage(0)
	for(var/obj/item/organ/organ in internal_organs)
		organ.set_germ_level(GERM_LEVEL_STERILE)
		organ.organ_flags &= ~(ORGAN_DEAD|ORGAN_DESTROYED|ORGAN_CUT_AWAY|ORGAN_SYNTHETIC_EMP)
		organ.applyOrganDamage(-organ.maxHealth)
	for(var/obj/item/bodypart/bodypart in bodyparts)
		REMOVE_TRAIT(bodypart, TRAIT_ROTTEN, GERM_LEVEL_TRAIT)
		REMOVE_TRAIT(bodypart, TRAIT_DEFORMED, CLONE)
		REMOVE_TRAIT(bodypart, TRAIT_DISFIGURED, TRAIT_GENERIC)
		REMOVE_TRAIT(bodypart, TRAIT_DISFIGURED, ACID)
		REMOVE_TRAIT(bodypart, TRAIT_DISFIGURED, BRUTE)
		REMOVE_TRAIT(bodypart, TRAIT_DISFIGURED, BURN)
		REMOVE_TRAIT(bodypart, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)
		bodypart.set_germ_level(GERM_LEVEL_STERILE)
		bodypart.limb_flags &= ~(BODYPART_DEAD|BODYPART_DEFORMED|BODYPART_CUT_AWAY|BODYPART_SYNTHETIC_EMP)
		bodypart.spilled = FALSE
		bodypart.heal_damage(INFINITY, INFINITY, INFINITY)
		bodypart.update_limb_efficiency()
	REMOVE_TRAIT(src, TRAIT_DISFIGURED, TRAIT_GENERIC)
	REMOVE_TRAIT(src, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)
	REMOVE_TRAIT(src, TRAIT_DISFIGURED, BRUTE)
	REMOVE_TRAIT(src, TRAIT_DISFIGURED, BURN)
	REMOVE_TRAIT(src, TRAIT_DISFIGURED, ACID)
	update_gore_overlays()
	update_eyes()
	update_sight()
	update_tint()
	eye_blind = 0
	update_blindness()

/mob/living/carbon/update_equipment_speed_mods()
	. = ..()
	update_carry_weight()

/mob/living/carbon/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(LAZYACCESS(modifiers, MIDDLE_CLICK) && (user.zone_selected in list(BODY_ZONE_PRECISE_NECK, \
														BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, \
														BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND)))
		check_pulse(user)
		return TRUE
	return ..()

/mob/living/carbon/throw_mode_off(method)
	if(throw_mode > method) //A toggle doesnt affect a hold
		return
	throw_mode = THROW_MODE_DISABLED
	if(hud_used)
		hud_used.throw_icon.icon_state = "act_throw"
		hud_used.throw_icon.name = "throw/catch"

/mob/living/carbon/throw_mode_on(mode = THROW_MODE_TOGGLE)
	throw_mode = mode
	if(hud_used)
		hud_used.throw_icon.icon_state = "act_throw_on"
		hud_used.throw_icon.name = "stop throwing/catching"

/mob/living/carbon/set_health(new_value)
	. = health
	health = new_value
	if(. > hardcrit_threshold)
		if(health <= hardcrit_threshold && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
			ADD_TRAIT(src, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	else if(health > hardcrit_threshold)
		REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, CRIT_HEALTH_TRAIT)
	if(CONFIG_GET(flag/near_death_experience))
		if(. > HEALTH_THRESHOLD_NEARDEATH)
			if(health <= HEALTH_THRESHOLD_NEARDEATH && !HAS_TRAIT(src, TRAIT_NODEATH))
				ADD_TRAIT(src, TRAIT_SIXTHSENSE, "near-death")
		else if(health > HEALTH_THRESHOLD_NEARDEATH)
			REMOVE_TRAIT(src, TRAIT_SIXTHSENSE, "near-death")

/mob/living/carbon/update_stat()
	. = ..()
	med_hud_set_status()

/mob/living/carbon/update_stamina()
	var/stamina = getStaminaLoss()
	if(stamina >= SPRINT_MAX_STAMLOSS)
		ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, STAMINA)
	else if(HAS_TRAIT_FROM(src, TRAIT_SPRINT_LOCKED, STAMINA))
		REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, STAMINA)
	if(stamina > DAMAGE_PRECISION && ((maxHealth - stamina) <= crit_threshold))
		enter_stamcrit()
	else if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA))
		REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, STAMINA)
		REMOVE_TRAIT(src, TRAIT_FLOORED, STAMINA)
	update_fatigue()
	update_stamina_hud()
	update_health_hud()

/mob/living/carbon/create_bodyparts()
	var/list/bodypart_paths = bodyparts.Copy()
	bodyparts = list()
	for(var/bodypart_type in bodypart_paths)
		var/obj/item/bodypart/bodypart = new bodypart_type()
		bodypart.attach_limb(src, FALSE, TRUE)

/mob/living/carbon/adjust_germ_level(add_germs, minimum_germs, maximum_germs)
	. = ..()
	update_smelly()

/mob/living/carbon/proc/update_stamina_hud(shown_stamina_amount)
	if(!client || !hud_used)
		return
	if(hud_used.fatigue)
		hud_used.fatigue.update_appearance()

/mob/living/carbon/proc/virus_immunity()
	var/antibiotic_boost = max(0, get_antibiotics()/100)
	. = max(immunity/100 * (1+antibiotic_boost), antibiotic_boost)
	if(HAS_TRAIT(src, TRAIT_IMMUNITY_CRIPPLED))
		. = max(. - 50, antibiotic_boost)

/mob/living/carbon/proc/immunity_weakness()
	return max(2-virus_immunity(), 0)

/mob/living/carbon/proc/get_antibiotics()
	. = 0
	. += get_chem_effect(CE_ANTIBIOTIC)

/mob/living/carbon/proc/needs_lungs()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return FALSE
	if(NOLUNGS in dna?.species?.species_traits)
		return FALSE
	return TRUE

// bleedout checks
/mob/living/carbon/proc/in_bleedout()
	return (CHECK_BITFIELD(status_flags, BLEEDOUT))

/mob/living/carbon/proc/update_handedness(held_index = 0)
	var/check_flag = RIGHT_HANDED
	if(held_index % RIGHT_HANDS)
		check_flag = LEFT_HANDED
	if(!(handed_flags & check_flag))
		if(handed_flags & AMBIDEXTROUS)
			remove_actionspeed_modifier(/datum/actionspeed_modifier/nondominant_hand, FALSE)
			add_actionspeed_modifier(/datum/actionspeed_modifier/ambidextrous_hand, FALSE)
			update_actionspeed()
			if(istype(attributes))
				attributes.remove_diceroll_modifier(/datum/diceroll_modifier/nondominant_hand, FALSE)
				attributes.add_diceroll_modifier(/datum/diceroll_modifier/poorly_ambidextrous, FALSE)
				attributes.update_attributes()
				attributes.update_diceroll()
		else
			remove_actionspeed_modifier(/datum/actionspeed_modifier/ambidextrous_hand, FALSE)
			add_actionspeed_modifier(/datum/actionspeed_modifier/nondominant_hand, FALSE)
			update_actionspeed()
			if(istype(attributes))
				attributes.remove_diceroll_modifier(/datum/diceroll_modifier/poorly_ambidextrous, FALSE)
				attributes.add_diceroll_modifier(/datum/diceroll_modifier/nondominant_hand, FALSE)
				attributes.update_attributes()
				attributes.update_diceroll()
	else
		remove_actionspeed_modifier(/datum/actionspeed_modifier/ambidextrous_hand, FALSE)
		remove_actionspeed_modifier(/datum/actionspeed_modifier/nondominant_hand, FALSE)
		update_actionspeed()
		if(istype(attributes))
			attributes.remove_diceroll_modifier(/datum/diceroll_modifier/poorly_ambidextrous, FALSE)
			attributes.remove_diceroll_modifier(/datum/diceroll_modifier/nondominant_hand, FALSE)
			attributes.update_attributes()
			attributes.update_diceroll()

/mob/living/carbon/vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = 1, message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1)
	if((HAS_TRAIT(src, TRAIT_NOHUNGER) || HAS_TRAIT(src, TRAIT_TOXINLOVER)) && !force)
		return TRUE

	if(nutrition < 100 && !blood && !force)
		if(message)
			visible_message(span_warning("[src] dry heaves!"), \
							span_userdanger("You try to throw up, but there's nothing in your stomach!"))
		if(stun)
			Paralyze(200)
		return TRUE

	if(is_mouth_covered()) //make this add a blood/vomit overlay later it'll be hilarious
		if(message)
			visible_message(span_danger("[src] throws up all over [p_them()]self!"), \
							span_userdanger("You throw up all over yourself!"))
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "vomit", /datum/mood_event/vomitself)
		distance = 0
	else
		if(message)
			visible_message(span_danger("[src] throws up!"), span_userdanger("You throw up!"))
			if(!isflyperson(src))
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "vomit", /datum/mood_event/vomit)

	if(stun)
		Paralyze(80)

	playsound(get_turf(src), vomitsound, 50, TRUE)
	var/turf/T = get_turf(src)
	if(!blood)
		adjust_nutrition(-lost_nutrition)
		adjustToxLoss(-3)

	for(var/i=0 to distance)
		if(blood)
			if(T)
				add_splatter_floor(T)
			if(harm)
				adjustBruteLoss(3)
		else
			if(T)
				T.add_vomit_floor(src, vomit_type, purge_ratio) //toxic barf looks different || call purge when doing detoxicfication to pump more chems out of the stomach.
		T = get_step(T, dir)
		if (T?.is_blocked_turf())
			break
