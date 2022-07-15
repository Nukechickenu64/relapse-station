/datum/interaction
	var/name = ""
	var/desc = "FUCK FUCK FUCK"
	var/category = "SHIT"
	var/message
	var/target_message
	var/user_message
	var/blind_message
	var/button_icon = "exclamation-circle" //fontawesome icon shown on the interface

	var/message_range = DEFAULT_MESSAGE_RANGE

	var/sounds
	var/sound_volume = 65
	var/sound_extrarange = 0
	var/sound_vary = 0

	var/usage = INTERACT_OTHER
	var/interaction_flags = INTERACTION_RESPECT_COOLDOWN

	var/user_cooldown_duration = 0
	var/target_cooldown_duraction = 0

	var/maximum_distance = 1
	var/maximum_tk_distance = 7
	var/user_hands_required = 0
	var/target_hands_required = 0
	var/list/user_types_allowed = list(/mob/living/carbon/human)
	var/list/target_types_allowed = list(/mob/living/carbon/human)

/datum/interaction/proc/allow_interaction(datum/component/interactable/user, datum/component/interactable/target, silent = TRUE, check_cooldown = TRUE)
	. = FALSE
	if(!user || !target)
		return FALSE
	switch(usage)
		if(INTERACT_SELF)
			if(user.parent != target.parent)
				if(!silent)
					to_chat(user.parent, span_warning("I can only do that to myself."))
				return FALSE
		if(INTERACT_OTHER)
			if(user.parent == target.parent)
				if(!silent)
					to_chat(user.parent, span_warning("I can only do that on other people."))
				return FALSE
	if(check_cooldown && !cooldown_checks(user, target))
		return FALSE
	var/mob/mob_user = user.parent
	var/mob/living/carbon/human/human_user = user.parent
	var/atom/atom_target = target.parent
	if(user != target)
		//Adjacency check
		if((interaction_flags & INTERACTION_NEEDS_PHYSICAL_CONTACT) && !mob_user.Adjacent(atom_target) && !(istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need physical contact to do this."))
			return FALSE
		//TK or distance check
		if((get_dist(atom_target, mob_user) > maximum_distance) && !(istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need to get closer."))
			return FALSE
		else if((get_dist(atom_target, mob_user) > maximum_tk_distance) && (istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need to get closer"))
			return FALSE
		//Checks that are target specific
		if(!evaluate_target(user, target, silent))
			return FALSE
	//Checks that are user specific
	if(!evaluate_user(user, target, silent))
		return FALSE
	return TRUE

/datum/interaction/proc/cooldown_checks(datum/component/interactable/user, datum/component/interactable/target)
	return (COOLDOWN_FINISHED(user, next_interaction) && COOLDOWN_FINISHED(target, next_interaction))

/datum/interaction/proc/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent = FALSE)
	. = TRUE
	//Type check
	if(!is_type_in_list(user.parent, user_types_allowed))
		if(!silent)
			to_chat(user.parent, span_warning("Not possible with me."))
		return FALSE
	//Hand check
	var/mob/living/living_user = user.parent
	if(user_hands_required && (!istype(living_user) || (living_user.num_hands < user_hands_required)))
		if(!silent)
			to_chat(living_user, span_warning("I don't have enough hands."))
		return FALSE

/datum/interaction/proc/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent = FALSE)
	. = TRUE
	//Type check
	if(!is_type_in_list(target.parent, target_types_allowed))
		if(!silent)
			to_chat(user.parent, span_warning("Not possible with them."))
		return FALSE
	//Hand check
	var/mob/living/living_target = target.parent
	if(target_hands_required && !(istype(living_target) || (living_target.num_hands < target_hands_required)))
		if(!silent)
			to_chat(user.parent, span_warning("They don't have enough hands"))
		return FALSE

/datum/interaction/proc/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/mob_user = user.parent
	var/message_index = 0
	if(islist(message))
		message_index = rand(1, length(message))
	var/msg
	if(message)
		if(message_index)
			msg = message[message_index]
		else
			msg = message
		msg = replacetext(msg, "%USER", "<b>[user.parent]</b>")
		msg = replacetext(msg, "%TARGET", "<b>[target.parent]</b>")
	var/target_msg
	if(target_message && ismob(target.parent))
		if(message_index)
			target_msg = target_message[message_index]
		else
			target_msg = target_message
		target_msg = replacetext(target_msg, "%USER", "<b>[user.parent]</b>")
		target_msg = replacetext(target_msg, "%TARGET", "<b>[target.parent]</b>")
	var/user_msg
	if(user_message)
		if(message_index)
			user_msg = user_message[message_index]
		else
			user_msg = user_message
		user_msg = replacetext(user_msg, "%USER", "<b>[user.parent]</b>")
		user_msg = replacetext(user_msg, "%TARGET", "<b>[target.parent]</b>")
	var/blind_msg
	if(blind_message)
		if(message_index)
			blind_msg = blind_message[message_index]
		else
			blind_msg = blind_message
		blind_msg = replacetext(blind_msg, "%USER", "<b>[user.parent]</b>")
		blind_msg = replacetext(blind_msg, "%TARGET", "<b>[target.parent]</b>")
	mob_user.face_atom(target.parent)
	if(!(interaction_flags & INTERACTION_AUDIBLE))
		mob_user.visible_message(message = msg, \
					self_message = user_msg, \
					blind_message = blind_msg, \
					ignored_mobs = (target_msg ? target.parent : null))
		if(target_msg)
			to_chat(target.parent, target_msg)
	else
		mob_user.audible_message(message = msg, self_message = user_msg, deaf_message = blind_msg, hearing_distance = message_range)
	if(sounds)
		playsound(mob_user, pick(sounds), sound_volume, sound_vary, sound_extrarange)
	return TRUE

/datum/interaction/proc/after_interact(datum/component/interactable/user, datum/component/interactable/target)
	if(user_cooldown_duration)
		COOLDOWN_START(user, next_interaction, user_cooldown_duration)
	if(user != target)
		if(target_cooldown_duraction)
			COOLDOWN_START(target, next_interaction, target_cooldown_duraction)
	user.last_interaction_as_user = src
	user.last_interaction_as_user_time = world.time
	if(user.clear_user_interaction_timer)
		deltimer(user.clear_user_interaction_timer)
		user.clear_user_interaction_timer = null
	user.clear_user_interaction_timer = addtimer(CALLBACK(user, /datum/component/interactable/.proc/clear_user_interaction), 30 SECONDS, TIMER_STOPPABLE)
	target.last_interaction_as_target = src
	target.last_interaction_as_target_time = world.time
	if(target.clear_target_interaction_timer)
		deltimer(target.clear_target_interaction_timer)
		target.clear_target_interaction_timer = null
	target.clear_target_interaction_timer = addtimer(CALLBACK(user, /datum/component/interactable/.proc/clear_target_interaction), 30 SECONDS, TIMER_STOPPABLE)
	return TRUE
