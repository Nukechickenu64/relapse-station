/datum/element/multitool_emaggable

/datum/element/multitool_emaggable/Attach(datum/target)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_CLICK_MIDDLE, .proc/try_hacking)

/datum/element/multitool_emaggable/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_CLICK_MIDDLE)

/datum/element/multitool_emaggable/proc/try_hacking(atom/source, mob/user)
	var/mob/living/living_user = user
	if(!living_user || !living_user.mind || !living_user.canUseTopic(source))
		return FALSE
	var/obj/item/item = living_user.get_active_held_item()
	if(!item?.tool_behaviour == TOOL_MULTITOOL)
		return FALSE

	var/electronic_level = GET_MOB_SKILL_VALUE(living_user, SKILL_ELECTRONICS)
	if(electronic_level < 8)
		to_chat(living_user, span_warning("I don't know how to do this."))
		return

	source.audible_message(span_warning("\The [source] starts to beep sporadically!"))
	if(!item.use_tool(source, living_user, 50))
		to_chat(living_user, span_warning(fail_msg()))
		return
	if(living_user.diceroll(electronic_level) <= DICE_FAILURE)
		source.audible_message(span_warning("[source] pings successfully at defending the hack attempt!"))
		to_chat(living_user, fail_msg())
		return
	source.audible_message(span_warning("[source] starts to beep even more frantically!"))
	to_chat(living_user, span_notice("Almost there.."))
	if(!item.use_tool(source, living_user, 100))
		to_chat(living_user, span_warning(fail_msg()))
		return
	if(living_user.diceroll(electronic_level) <= DICE_FAILURE)
		source.audible_message(span_warning("[source] pings successfully at defending the hack attempt!"))
		to_chat(living_user, span_warning(fail_msg()))
		return
	source.audible_message(span_warning("[source] beeps one last time..."))
	to_chat(living_user, span_notice("Success."))
	source.emag_act(living_user)
	return COMPONENT_CANCEL_CLICK_MIDDLE
