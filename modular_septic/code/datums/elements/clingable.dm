/datum/element/clingable
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH

	/// Skill used to cling to this
	var/clinging_skill = SKILL_ACROBATICS
	/// Skill level required to cling to this
	var/clinging_requirement = 10
	/// Sound we play when the parent is clinged to by a mob
	var/clinging_sound = 'modular_septic/sound/effects/clung.wav'

/datum/element/clingable/Attach(datum/target, clinging_skill = SKILL_ACROBATICS, clinging_requirement = 10, clinging_sound = 'modular_septic/sound/effects/clung.wav')
	if(!isatom(target) || isarea(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.clinging_skill = clinging_skill
	src.clinging_requirement = clinging_requirement
	src.clinging_sound = clinging_sound
	RegisterSignal(target, COMSIG_ATOM_ATTACK_HAND_TERTIARY, .proc/on_attack_hand)
	RegisterSignal(target, COMSIG_CLINGABLE_CHECK, .proc/clingable_check)
	RegisterSignal(target, COMSIG_CLINGABLE_CLING_SOUNDING, .proc/play_clinging_sound)

/datum/element/clingable/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ATTACK_HAND_TERTIARY)
	UnregisterSignal(source, COMSIG_CLINGABLE_CHECK)
	UnregisterSignal(source, COMSIG_CLINGABLE_CLING_SOUNDING)

/datum/element/clingable/proc/clingable_check(atom/source, mob/user)
	SIGNAL_HANDLER

	if(GET_MOB_SKILL_VALUE(user, clinging_skill) >= clinging_requirement)
		return TRUE
	return FALSE

/datum/element/clingable/proc/on_attack_hand(atom/source, mob/living/carbon/user, list/modifiers)
	SIGNAL_HANDLER

	if(GET_MOB_SKILL_VALUE(user, clinging_skill) < clinging_requirement)
		to_chat(user, span_warning("I don't know how to cling to that."))
		return
	else if(user.usable_hands < user.default_num_hands)
		to_chat(user, span_warning("I need [user.default_num_hands] hands to cling to [source]."))
		return
	else if(user.get_active_held_item() || user.get_inactive_held_item())
		to_chat(user, span_warning("I need all of my hands free."))
		return
	else if(user.body_position == LYING_DOWN)
		to_chat(user, span_warning("I need to stand up."))
		return
	else if(HAS_TRAIT(user, TRAIT_MOVE_VENTCRAWLING))
		to_chat(user, span_warning("Not while ventcrawling."))
		return
	source.add_fingerprint(user)
	user.changeNext_move(CLICK_CD_CLING)
	user.face_atom(source)
	user.AddComponent(/datum/component/clinging, source)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/element/clingable/proc/play_clinging_sound(atom/source)
	SIGNAL_HANDLER

	if(!clinging_sound)
		return

	playsound(source, clinging_sound, 75, FALSE)
