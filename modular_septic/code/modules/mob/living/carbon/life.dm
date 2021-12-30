/mob/living/carbon/needs_heart()
	if(HAS_TRAIT(src, TRAIT_STABLEHEART))
		return FALSE
	if((NOBLOOD in dna?.species?.species_traits) || (NOHEART in dna?.species?.species_traits))
		return FALSE
	return TRUE

/// Handling organs
/mob/living/carbon/handle_organs(delta_time, times_fired)
	if(stat < DEAD)
		var/list/already_processed_life = list()
		for(var/organ_slot in GLOB.organ_process_order)
			var/list/organlist = getorganslotlist(organ_slot)
			for(var/thing in organlist)
				var/obj/item/organ/organ = thing
				// This exists mostly because reagent metabolization can cause organ shuffling
				if(!QDELETED(organ) && !(organ in already_processed_life) && (organ.owner == src))
					organ.on_life(delta_time, times_fired)
					already_processed_life |= organ
		for(var/thing in GLOB.organ_process_datum_order)
			if(QDELETED(src))
				break
			var/datum/organ_process/organ_process = GLOB.organ_processes_by_slot[thing]
			if(organ_process?.needs_process(src))
				organ_process.handle_process(src, delta_time, times_fired)
	else
		for(var/O in internal_organs)
			var/obj/item/organ/organ = O
			//Needed so organs decay while inside the body
			organ.on_death(delta_time, times_fired)

/// Handling bodyparts
/mob/living/carbon/handle_bodyparts(delta_time, times_fired)
	if(stat < DEAD)
		for(var/thing in bodyparts)
			var/obj/item/bodypart/living_part = thing
			if(living_part.needs_processing)
				. |= living_part.on_life(delta_time, times_fired, TRUE)
	else
		for(var/thing in bodyparts)
			var/obj/item/bodypart/rotting_part = thing
			//Needed so bodyparts decay while inside the body.
			rotting_part.on_death(delta_time, times_fired)

/// Sleeping
/mob/living/carbon/Life(delta_time = SSMOBS_DT, times_fired)
	. = ..()
	if(!.) // We're dead
		return

	if(HAS_TRAIT(src, TRAIT_TRYINGTOSLEEP))
		handle_trying_to_sleep()

/mob/living/carbon/proc/handle_trying_to_sleep()
	if(getShock() >= max(PAIN_NO_SLEEP * (GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)/ATTRIBUTE_MIDDLING), 1))
		REMOVE_TRAIT(src, TRAIT_TRYINGTOSLEEP, src)
		hud_used.sleeping.update_appearance()
	return Sleeping(8 SECONDS)

/// Immunity & disease
/mob/living/carbon/handle_diseases()
	. = ..()
	if(immunity >= 0.25 * default_immunity && immunity < default_immunity)
		immunity = min(immunity + 0.25, default_immunity)

/// Being burned to a crisp
/mob/living/carbon/proc/check_cremation(delta_time, times_fired)
	//Only cremate while actively on fire
	if(!on_fire)
		return

	//Only starts when the chest has taken full damage
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if(!(chest.get_damage() >= chest.max_damage))
		return

	//Burn off limbs one by one
	var/obj/item/bodypart/limb
	var/list/limb_list = LIMB_BODYPARTS
	var/still_has_limbs = FALSE
	for(var/zone in limb_list)
		limb = get_bodypart_nostump(zone)
		if(limb)
			still_has_limbs = TRUE
			if(limb.get_damage() >= limb.max_damage)
				limb.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
				if(limb.limb_integrity <= 0)
					if(limb.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
						limb.visible_message(span_warning("<b>[src]</b>'s [limb.name] crumbles into ash!"))
					else
						limb.visible_message(span_warning("<b>[src]</b>'s [limb.name] melts away!"))
					qdel(limb)

	if(still_has_limbs)
		return

	//Burn the head last
	var/obj/item/bodypart/head = get_bodypart_nostump(BODY_ZONE_HEAD)
	if(head)
		if(head.get_damage() >= head.max_damage)
			head.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
			if(head.limb_integrity <= 0)
				if(limb.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
					limb.visible_message(span_warning("<b>[src]</b>'s head crumbles into ash!"))
				else
					limb.visible_message(span_warning("<b>[src]</b>'s head melts away!"))
				qdel(limb)
		return

	//Nothing left: dust the body, drop the items (if they're flammable they'll burn on their own)
	chest.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
	if(chest.limb_integrity <= 0)
		visible_message(span_warning("<b>[src]</b>'s body crumbles into a pile of ash!"))
		dust(TRUE, TRUE)
