//Mostly used by Shibu species
/datum/quirk/congenial
	name = "Congenial"
	desc = "You hate being alone."
	icon = "users"
	value = -4
	medical_record_text = "Patient is congenial, and does not enjoy being alone."
	hardcore_value = 5
	processing_quirk = TRUE
	var/loneliness = 0

/datum/quirk/congenial/process(delta_time)
	. = ..()
	if(world.time % 30)
		return
	if(check_lonely())
		loneliness++
		if(loneliness >= 5)
			SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "loneliness", /datum/mood_event/congenial)
		return
	loneliness = 0
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "loneliness")

/datum/quirk/congenial/proc/check_lonely()
	. = TRUE
	var/friend_range = world.view
	if(quirk_holder.is_blind())
		friend_range = 1
	for(var/mob/living/friend in fov_view(friend_range, quirk_holder))
		if((friend.stat < DEAD) && (friend.ai_controller || friend.mind))
			return FALSE

//Mostly used by perluni species
/datum/quirk/uncongenial
	name = "Uncongenial"
	desc = "You hate having company."
	icon = "users-slash"
	value = -4
	medical_record_text = "Patient is uncongenial, and does not enjoy having company."
	hardcore_value = 5
	processing_quirk = TRUE
	var/company = 0

/datum/quirk/uncongenial/process(delta_time)
	. = ..()
	if(world.time % 30)
		return
	if(check_company())
		company++
		if(company >= 5)
			SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "loneliness", /datum/mood_event/uncongenial)
		return
	company = 0
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "loneliness")

/datum/quirk/uncongenial/proc/check_company()
	. = FALSE
	var/enemy_range = world.view
	if(quirk_holder.is_blind())
		enemy_range = 1
	for(var/mob/living/enemy in fov_view(enemy_range, quirk_holder))
		if((enemy.stat < DEAD) && (enemy.ai_controller || enemy.mind))
			return TRUE

//Mostly used by parotin species
/datum/quirk/glass_bones
	name = "Glass Bones"
	desc = "Your bones are brittle and easily fractured."
	icon = "bone"
	value = -6
	medical_record_text = "Patient has porous bones that are especially prone to damage."
	hardcore_value = 5

/datum/quirk/glass_bones/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	for(var/obj/item/organ/bone/bone in human_holder.internal_organs)
		if(bone.status != ORGAN_ORGANIC)
			continue
		bone.name = "brittle [bone.name]"
		bone.wound_resistance = -5
