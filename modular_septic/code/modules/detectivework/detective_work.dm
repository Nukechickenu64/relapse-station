//SHIT
/atom/proc/return_shit_DNA()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = D.shit_DNA

/atom/proc/shit_DNA_length()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = length(D.shit_DNA)

/atom/proc/add_shit_DNA(list/dna)
	return FALSE

/atom/proc/transfer_mob_shit_dna(mob/living/L)
	// Returns 0 if we have that blood already
	var/new_blood_dna = L.get_blood_dna_list()
	if(!new_blood_dna)
		return FALSE
	var/old_length = shit_DNA_length()
	add_shit_DNA(new_blood_dna)
	if(shit_DNA_length() == old_length)
		return FALSE
	return TRUE

/atom/proc/add_mob_shit(mob/living/M)
	var/list/blood_dna = M.get_blood_dna_list()
	if(!blood_dna)
		return FALSE
	return add_shit_DNA(blood_dna)

/obj/add_shit_DNA(list/dna)
	. = ..()
	if(length(dna))
		. = AddComponent(/datum/component/forensics, null, null, null, null, dna)

/obj/add_shit_DNA(list/dna)
	if(!QDELETED(src))
		return ..()

/turf/add_shit_DNA(list/blood_dna, list/datum/disease/diseases)
	var/obj/effect/decal/cleanable/shit = locate() in src
	if(!shit)
		shit = new /obj/effect/decal/cleanable/blood/shit(src, diseases)
	if(!QDELETED(shit))
		shit.add_blood_DNA(blood_dna) //give blood info to the blood decal.
		return TRUE //we bloodied the floor

/mob/living/carbon/human/add_shit_DNA(list/blood_dna, list/datum/disease/diseases)
	if(QDELETED(src))
		return
	if(head)
		head.add_shit_DNA(blood_dna)
		update_inv_head()
	else if(wear_mask)
		wear_mask.add_shit_DNA(blood_dna)
		update_inv_wear_mask()
	else if(glasses)
		glasses.add_shit_DNA(blood_dna)
		update_inv_glasses()
	if(wear_suit)
		wear_suit.add_shit_DNA(blood_dna)
		update_inv_wear_suit()
	else if(w_uniform)
		w_uniform.add_shit_DNA(blood_dna)
		update_inv_w_uniform()
	if(gloves)
		gloves.add_shit_DNA(blood_dna)
		update_inv_gloves()
	else if(LAZYLEN(blood_dna))
		AddComponent(/datum/component/forensics, null, null, null, null, blood_dna)
		shit_in_hands += rand(2, 4)
		update_inv_gloves()
	return TRUE

//CUM
/atom/proc/return_cum_DNA()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = D.cum_DNA

/atom/proc/cum_DNA_length()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = length(D.cum_DNA)

/atom/proc/add_cum_DNA(list/dna)
	return FALSE

/atom/proc/transfer_mob_cum_dna(mob/living/L)
	// Returns 0 if we have that blood already
	var/new_blood_dna = L.get_blood_dna_list()
	if(!new_blood_dna)
		return FALSE
	var/old_length = cum_DNA_length()
	add_cum_DNA(new_blood_dna)
	if(cum_DNA_length() == old_length)
		return FALSE
	return TRUE

/atom/proc/add_mob_cum(mob/living/M)
	var/list/blood_dna = M.get_blood_dna_list()
	if(!blood_dna)
		return FALSE
	return add_cum_DNA(blood_dna)

/obj/add_cum_DNA(list/dna)
	. = ..()
	if(length(dna))
		. = AddComponent(/datum/component/forensics, null, null, null, null, null, dna)

/obj/add_cum_DNA(list/dna)
	if(!QDELETED(src))
		return ..()

/turf/add_cum_DNA(list/blood_dna, list/datum/disease/diseases)
	var/obj/effect/decal/cleanable/cum = locate() in src
	if(!cum)
		cum = new /obj/effect/decal/cleanable/blood/cum(src, diseases)
	if(!QDELETED(cum))
		cum.add_blood_DNA(blood_dna) //give blood info to the blood decal.
		return TRUE //we bloodied the floor

/mob/living/carbon/human/add_cum_DNA(list/blood_dna, list/datum/disease/diseases)
	if(!QDELETED(src))
		return ..()

/mob/living/carbon/human/add_cum_DNA(list/blood_dna, list/datum/disease/diseases)
	if(QDELETED(src))
		return
	if(head)
		head.add_cum_DNA(blood_dna)
		update_inv_head()
	else if(wear_mask)
		wear_mask.add_cum_DNA(blood_dna)
		update_inv_wear_mask()
	else if(glasses)
		glasses.add_cum_DNA(blood_dna)
		update_inv_glasses()
	if(wear_suit)
		wear_suit.add_cum_DNA(blood_dna)
		update_inv_wear_suit()
	else if(w_uniform)
		w_uniform.add_cum_DNA(blood_dna)
		update_inv_w_uniform()
	if(gloves)
		gloves.add_cum_DNA(blood_dna)
		update_inv_gloves()
	else if(LAZYLEN(blood_dna))
		AddComponent(/datum/component/forensics, null, null, null, null, null, blood_dna)
		cum_in_hands += rand(2, 4)
		update_inv_gloves()
	return TRUE

//FEMCUM
/atom/proc/return_femcum_DNA()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = D.femcum_DNA

/atom/proc/femcum_DNA_length()
	var/datum/component/forensics/D = GetComponent(/datum/component/forensics)
	if(D)
		. = length(D.femcum_DNA)

/atom/proc/add_femcum_DNA(list/dna)
	return FALSE

/atom/proc/transfer_mob_femcum_dna(mob/living/L)
	// Returns 0 if we have that blood already
	var/new_blood_dna = L.get_blood_dna_list()
	if(!new_blood_dna)
		return FALSE
	var/old_length = femcum_DNA_length()
	add_cum_DNA(new_blood_dna)
	if(femcum_DNA_length() == old_length)
		return FALSE
	return TRUE

/atom/proc/add_mob_femcum(mob/living/M)
	var/list/blood_dna = M.get_blood_dna_list()
	if(!blood_dna)
		return FALSE
	return add_femcum_DNA(blood_dna)

/obj/add_femcum_DNA(list/dna)
	. = ..()
	if(length(dna))
		. = AddComponent(/datum/component/forensics, null, null, null, null, null, null, dna)

/obj/add_femcum_DNA(list/dna)
	if(!QDELETED(src))
		return ..()

/turf/add_femcum_DNA(list/blood_dna, list/datum/disease/diseases)
	var/obj/effect/decal/cleanable/blood/femcum = locate() in src
	if(!femcum)
		femcum = new /obj/effect/decal/cleanable/blood/femcum(src, diseases)
	if(!QDELETED(femcum))
		femcum.add_blood_DNA(blood_dna) //give blood info to the blood decal.
		return TRUE //we bloodied the floor

/mob/living/carbon/human/add_femcum_DNA(list/blood_dna, list/datum/disease/diseases)
	if(!QDELETED(src))
		return ..()

/mob/living/carbon/human/add_femcum_DNA(list/blood_dna, list/datum/disease/diseases)
	if(QDELETED(src))
		return
	if(head)
		head.add_femcum_DNA(blood_dna)
		update_inv_head()
	else if(wear_mask)
		wear_mask.add_femcum_DNA(blood_dna)
		update_inv_wear_mask()
	else if(glasses)
		glasses.add_femcum_DNA(blood_dna)
		update_inv_glasses()
	if(wear_suit)
		wear_suit.add_femcum_DNA(blood_dna)
		update_inv_wear_suit()
	else if(w_uniform)
		w_uniform.add_femcum_DNA(blood_dna)
		update_inv_w_uniform()
	if(gloves)
		gloves.add_femcum_DNA(blood_dna)
		update_inv_gloves()
	else if(LAZYLEN(blood_dna))
		AddComponent(/datum/component/forensics, null, null, null, null, null, null, blood_dna)
		femcum_in_hands += rand(2, 4)
		update_inv_gloves()
	return TRUE

//BLOOD
/obj/add_blood_DNA(list/dna)
	if(!QDELETED(src))
		return ..()

/turf/add_blood_DNA(list/blood_dna, list/datum/disease/diseases)
	var/obj/effect/decal/cleanable/blood/blood = locate() in src
	if(!blood)
		blood = new /obj/effect/decal/cleanable/blood/splatter(src, diseases)
	if(!QDELETED(blood))
		blood.add_blood_DNA(blood_dna) //give blood info to the blood decal.
		return TRUE //we bloodied the floor

/mob/living/carbon/human/add_blood_DNA(list/blood_dna, list/datum/disease/diseases)
	if(QDELETED(src))
		return
	if(head)
		head.add_blood_DNA(blood_dna)
		update_inv_head()
	else if(wear_mask)
		wear_mask.add_blood_DNA(blood_dna)
		update_inv_wear_mask()
	else if(glasses)
		glasses.add_blood_DNA(blood_dna)
		update_inv_glasses()
	if(wear_suit)
		wear_suit.add_blood_DNA(blood_dna)
		update_inv_wear_suit()
	else if(w_uniform)
		w_uniform.add_blood_DNA(blood_dna)
		update_inv_w_uniform()
	if(gloves)
		gloves.add_blood_DNA(blood_dna)
		update_inv_gloves()
	else if(length(blood_dna))
		AddComponent(/datum/component/forensics, null, null, blood_dna)
		blood_in_hands += rand(2, 4)
		update_inv_gloves()
	return TRUE
