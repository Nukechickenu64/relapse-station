/datum/element/clingable
	id_arg_index = 3
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH

	///Skill used to cling to this
	var/clinging_skill = SKILL_ACROBATICS
	///Skill level required to cling to this
	var/clinging_requirement = 3

/datum/element/clingable/Attach(datum/target, _clinging_skill, _clinging_requirement)
	. = ..()
	if(!ismovable(target) && !isturf(target))
		return ELEMENT_INCOMPATIBLE
	clinging_skill = _clinging_skill
	clinging_requirement = _clinging_requirement
	RegisterSignal(target, COMSIG_ATOM_ATTACK_HAND_TERTIARY, .proc/on_attack_hand)
	RegisterSignal(target, COMSIG_CLINGABLE_CHECK, .proc/clingable_check)

/datum/element/clingable/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_ATTACK_HAND_TERTIARY)
	UnregisterSignal(source, COMSIG_CLINGABLE_CHECK)

/datum/element/clingable/proc/clingable_check(atom/source, mob/user)
	if(GET_MOB_SKILL_VALUE(user, clinging_skill) >= clinging_requirement)
		return TRUE

/datum/element/clingable/proc/on_attack_hand(atom/source, mob/living/carbon/user, list/modifiers)
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
