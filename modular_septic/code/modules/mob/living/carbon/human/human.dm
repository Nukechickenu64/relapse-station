//Hygiene stuff
/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	//values are quite low due to the way dirty clothing dirtifies you
	set_germ_level(rand(GERM_LEVEL_START_MIN, GERM_LEVEL_START_MAX))
	add_verb(src, /mob/living/carbon/human/proc/hide_furry_shit)
	//hehe horny //FUCK YOURSELF RETARD
	AddComponent(/datum/component/fixeye)
	AddComponent(/datum/component/interactable)
	AddComponent(/datum/component/babble)

/mob/living/carbon/human/set_stat(new_stat)
	if(new_stat == stat)
		return
	SEND_SIGNAL(src, COMSIG_MOB_STATCHANGE, new_stat)
	. = stat
	stat = new_stat
	if(isnull(.))
		return

	//Previous stat
	switch(.)
		if(CONSCIOUS)
			if(stat >= UNCONSCIOUS)
				ADD_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
			ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
			ADD_TRAIT(src, TRAIT_INCAPACITATED, STAT_TRAIT)
			ADD_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
		if(SOFT_CRIT)
			if(stat >= UNCONSCIOUS)
				//adding trait sources should come before removing to avoid unnecessary updates
				ADD_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
		if(UNCONSCIOUS)
			if(stat < HARD_CRIT)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(HARD_CRIT)
			if(stat < UNCONSCIOUS)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(DEAD)
			remove_from_dead_mob_list()
			add_to_alive_mob_list()
	//Current stat
	switch(stat)
		if(CONSCIOUS)
			if(. >= UNCONSCIOUS)
				REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
				cure_blind(UNCONSCIOUS_TRAIT)
			REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_INCAPACITATED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_FLOORED, STAT_TRAIT)
			REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
		if(SOFT_CRIT)
			if(. >= UNCONSCIOUS)
				REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, TRAIT_KNOCKEDOUT)
				cure_blind(UNCONSCIOUS_TRAIT)
		if(UNCONSCIOUS)
			if(. < UNCONSCIOUS)
				become_blind(UNCONSCIOUS_TRAIT)
		if(HARD_CRIT)
			if(. < UNCONSCIOUS)
				become_blind(UNCONSCIOUS_TRAIT)
			ADD_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
		if(DEAD)
			REMOVE_TRAIT(src, TRAIT_CRITICAL_CONDITION, STAT_TRAIT)
			remove_from_alive_mob_list()
			add_to_dead_mob_list()

/mob/living/carbon/human/set_health(new_value)
	. = health
	health = new_value
	if(CONFIG_GET(flag/near_death_experience))
		if(. > HEALTH_THRESHOLD_NEARDEATH)
			if(health <= HEALTH_THRESHOLD_NEARDEATH && !HAS_TRAIT(src, TRAIT_NODEATH))
				ADD_TRAIT(src, TRAIT_SIXTHSENSE, NEAR_DEATH_TRAIT)
		else if(health > HEALTH_THRESHOLD_NEARDEATH)
			REMOVE_TRAIT(src, TRAIT_SIXTHSENSE, NEAR_DEATH_TRAIT)

/mob/living/carbon/human/update_stat()
	if(status_flags & GODMODE)
		return
	if(stat < DEAD)
		if(health <= HEALTH_THRESHOLD_DEAD && !HAS_TRAIT(src, TRAIT_NODEATH))
			death()
			return
		if(undergoing_nervous_system_failure() && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
			set_stat(HARD_CRIT)
		else if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
			set_stat(UNCONSCIOUS)
		else if(HAS_TRAIT(src, TRAIT_SOFT_CRITICAL_CONDITION) && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
			set_stat(SOFT_CRIT)
		else
			set_stat(CONSCIOUS)
	update_damage_hud()
	update_health_hud()
	update_sleeping_hud()
	med_hud_set_status()

//OVERRIDE IGNORING PARENT RETURN VALUE
/mob/living/carbon/human/updatehealth()
	if(status_flags & GODMODE)
		return
	var/total_brute = 0
	var/total_burn = 0
	var/total_stamina = 0
	for(var/X in bodyparts) //hardcoded to streamline things a bit
		var/obj/item/bodypart/bodypart = X
		total_brute += (bodypart.brute_dam * bodypart.body_damage_coeff)
		total_burn += (bodypart.burn_dam * bodypart.body_damage_coeff)
		total_stamina += (bodypart.stamina_dam * bodypart.stam_damage_coeff)
	bruteloss = round(total_brute, DAMAGE_PRECISION)
	fireloss = round(total_burn, DAMAGE_PRECISION)
	staminaloss = round(total_stamina, DAMAGE_PRECISION)
	set_health(maxHealth - GETBRAINLOSS(src))
	update_pain()
	update_shock()
	if((maxHealth - total_burn <= HEALTH_THRESHOLD_DEAD*2) && (stat == DEAD))
		become_husk(BURN)
	update_stat()
	med_hud_set_health()
	dna?.species?.spec_updatehealth(src)
	SEND_SIGNAL(src, COMSIG_CARBON_HEALTH_UPDATE)

/mob/living/carbon/human/getMaxHealth()
	var/obj/item/organ/brain = getorganslot(ORGAN_SLOT_BRAIN)
	if(brain)
		return brain.maxHealth
	return BRAIN_DAMAGE_DEATH

/mob/living/carbon/human/update_lips(new_style, new_colour, apply_trait)
	lip_style = new_style
	lip_color = new_colour
	update_body()

	var/obj/item/bodypart/mouth/hopefully_a_jaw = get_bodypart(check_zone(BODY_ZONE_PRECISE_MOUTH))
	REMOVE_TRAITS_IN(src, LIPSTICK_TRAIT)
	hopefully_a_jaw?.stored_lipstick_trait = null

	if(new_style && apply_trait)
		ADD_TRAIT(src, apply_trait, LIPSTICK_TRAIT)
		hopefully_a_jaw?.stored_lipstick_trait = apply_trait

///Get all the clothing on a specific body part
/mob/living/carbon/human/clothingonpart(obj/item/bodypart/def_zone)
	//body zone
	if(istext(def_zone))
		def_zone = GLOB.bodyzone_to_bitflag[def_zone]
	//bodypart
	else if(istype(def_zone))
		def_zone = def_zone.body_part
	//hopefully already a bitflag otherwise
	var/list/covering_part = list()
	//Everything but pockets. Pockets are l_store and r_store.
	//(if pockets were allowed, putting something armored, gloves or hats for example, would double up on the armor)
	var/list/clothings = list(head,
							wear_mask,
							wear_suit,
							w_uniform,
							back,
							gloves,
							shoes,
							belt,
							s_store,
							glasses,
							ears,
							ears_extra,
							wear_id,
							wear_neck)
	for(var/obj/item/item in clothings)
		if(item.body_parts_covered & def_zone)
			covering_part += item
	return covering_part

/mob/living/crbaon/human/is_literate()
	if(HAS_TRAIT(src, TRAIT_ILLITERATE))
		return FALSE
	return TRUE

/mob/living/carbon/human/can_read(obj/being_read)
	if(is_blind())
		to_chat(src, span_warning("I try to read [being_read], then realize it is not in braille..."))
		return
	if(!is_literate())
		to_chat(src, span_notice("I try to read [being_read], but can't comprehend any of it."))
		return
	return TRUE

/mob/living/carbon/human/proc/get_middle_status_tab()
	. = list()
	. += ""
	. += "Combat Mode: [combat_mode ? "On" : "Off"]"
	. += "Intent: [capitalize(a_intent)]"
	if(combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
		. += "Move Mode: Sprint"
	else
		. += "Move Mode: [capitalize(m_intent)]"
