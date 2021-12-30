/datum/organ_process/ears
	slot = ORGAN_SLOT_EARS
	mob_types = list(/mob/living/carbon/human)
	var/static/sound/ringing = sound('sound/weapons/flash_ring.ogg', FALSE, 0, CHANNEL_EAR_RING, 75)

/datum/organ_process/ears/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/ear_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_EARS)
	if(ear_efficiency < failing_threshold)
		ADD_TRAIT(owner, TRAIT_DEAF, EAR_DAMAGE)
	else
		REMOVE_TRAIT(owner, TRAIT_DEAF, EAR_DAMAGE)
	if((ear_efficiency < bruised_threshold) && DT_PROB((optimal_threshold - ear_efficiency)/bruised_threshold, delta_time))
		var/obj/item/organ/ears/ear = owner.getorganslot(ORGAN_SLOT_EARS)
		ear?.adjustEarDamage(0, 4)
		SEND_SOUND(owner, ringing)
	return TRUE
