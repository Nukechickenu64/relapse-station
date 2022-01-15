/obj/item/grab/proc/strangle()
	//Wtf?
	if(!grasped_part)
		return FALSE
	//You can't strangle yourself!
	if(owner == victim)
		return FALSE
	//You can't double strangle, sorry!
	var/obj/item/grab/other_grab = owner.get_inactive_held_item()
	if(istype(other_grab) && (other_grab.grab_mode == GM_STRANGLE) && other_grab.active)
		to_chat(owner, span_danger("I'm already strangling [victim.p_them()]!"))
		return FALSE
	//Due to shitcode reasons, i cannot support strangling and taking down simultaneously
	else if(istype(other_grab) && (other_grab.grab_mode == GM_TAKEDOWN) && other_grab.active)
		to_chat(owner, span_danger("I'm too focused on taking [victim.p_them()] down!"))
		return FALSE
	active = !active
	if(!active)
		owner.setGrabState(GRAB_AGGRESSIVE)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> stops strangling <b>[victim]</b>!"), \
						span_userdanger("<b>[owner]</b> stops strangling me!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
	else
		to_chat(owner, span_danger("I stop strangling <b>[victim]</b>!"))
		owner.setGrabState(GRAB_KILL)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> starts strangling <b>[victim]</b>!"), \
						span_userdanger("<b>[owner]</b> starts strangling me!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I start strangling <b>[victim]</b>!"))
		victim.adjustOxyLoss(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH))
		actions_done++
	grab_hud?.update_appearance()
	owner.changeNext_move(CLICK_CD_STRANGLE)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/takedown()
	//Wtf?
	if(!grasped_part)
		return FALSE
	//You can't takedown yourself!
	if(owner == victim)
		return FALSE
	//Only one hand can be the master of puppets!
	var/obj/item/grab/other_grab = owner.get_inactive_held_item()
	if(istype(other_grab) && (other_grab.grab_mode == GM_TAKEDOWN) && other_grab.active)
		to_chat(owner, span_danger("I'm already taking [victim.p_them()] down!"))
		return FALSE
	//Due to shitcode reasons, i cannot support strangling and taking down simultaneously
	else if(istype(other_grab) && (other_grab.grab_mode == GM_STRANGLE) && other_grab.active)
		to_chat(owner, span_danger("I'm too focused on strangling [victim.p_them()]!"))
		return FALSE
	if(active)
		active = FALSE
		owner.setGrabState(GRAB_AGGRESSIVE)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> stops pinning <b>[victim]</b> down!"), \
						span_userdanger("<b>[owner]</b> stops pinning me down!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I stop pinning <b>[victim]</b> down!"))
	else
		//We need to do a lil' wrenching first! (Or the guy must be lying down)
		if((!istype(other_grab) || (other_grab.actions_done <= 0)) && (victim.body_position != LYING_DOWN))
			to_chat(owner, span_danger("I need to subdue them more first!"))
			return FALSE
		active = TRUE
		owner.setGrabState(GRAB_NECK) //don't take GRAB_NECK literally
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> starts pinning <b>[victim]</b> down!"), \
						span_userdanger("<b>[owner]</b> starts pinning me down!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I start pinning <b>[victim]</b> down!"))
		victim.CombatKnockdown((GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)/2) SECONDS)
		actions_done++
	grab_hud?.update_appearance()
	owner.changeNext_move(CLICK_CD_TAKEDOWN)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/wrench_limb()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	if(IS_HELP_INTENT(owner, null) && grasped_part.is_dislocated())
		if(DOING_INTERACTION_WITH_TARGET(owner, victim))
			return FALSE
		return relocate_limb()
	var/mob/living/carbon/carbon_victim = victim
	var/nonlethal = (!owner.combat_mode && (actions_done <= 0))
	var/epic_success = DICE_FAILURE
	var/modifier = 0
	if(victim.combat_mode && (GET_MOB_ATTRIBUTE_VALUE(victim, STAT_STRENGTH) >= GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)))
		modifier -= 5
	if(nonlethal)
		epic_success = owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_DEXTERITY)+modifier)
	else
		epic_success = owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)+modifier)
	if(epic_success >= DICE_SUCCESS)
		var/wrench_verb = "wrenches"
		if(nonlethal)
			wrench_verb = "twists"
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)
		var/deal_wound_bonus = 5
		if(epic_success >= DICE_CRIT_SUCCESS)
			deal_wound_bonus += 10
		if(!nonlethal)
			grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = NONE)
		victim.visible_message(span_danger("<b>[owner]</b> [wrench_verb] <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
						span_userdanger("<b>[owner]</b> [wrench_verb] my [grasped_part.name]![carbon_victim.wound_message]"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I [wrench_verb] <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
		actions_done++
	else
		var/wrench_verb = "wrench"
		if(nonlethal)
			wrench_verb = "twist"
		victim.visible_message(span_danger("<b>[owner]</b> tries to [wrench_verb] <b>[victim]</b>'s [grasped_part.name]!"), \
						span_userdanger("<b>[owner]</b> tries to [wrench_verb] my [grasped_part.name]!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I try to [wrench_verb] <b>[victim]</b>'s [grasped_part.name]!"))
	owner.changeNext_move(CLICK_CD_WRENCH)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/relocate_limb()
	var/mob/living/carbon/carbon_victim = victim
	victim.visible_message(span_danger("<b>[owner]</b> tries to relocate <b>[victim]</b>'s [grasped_part.name]!"), \
					span_userdanger("<b>[owner]</b> tries to relocate my [grasped_part.name]!"), \
					vision_distance = COMBAT_MESSAGE_RANGE, \
					ignored_mobs = owner)
	to_chat(owner, span_userdanger("I try to relocate <b>[victim]</b>'s [grasped_part.name]!"))
	var/time = 12 SECONDS //Worst case scenario
	time -= (GET_MOB_SKILL_VALUE(owner, SKILL_MEDICINE)/2 SECONDS)
	if(!do_mob(owner, carbon_victim, time))
		to_chat(owner, span_userdanger("I must stand still!"))
		return
	var/epic_success = DICE_FAILURE
	if(grasped_part.status == BODYPART_ORGANIC)
		epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_MEDICINE))
	else
		epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_ELECTRONICS))
	if(epic_success >= DICE_SUCCESS)
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)/2
		grasped_part.receive_damage(brute = damage, sharpness = NONE)
		for(var/obj/item/organ/bone/bone as anything in grasped_part.getorganslotlist(ORGAN_SLOT_BONE))
			if(bone.bone_flags & BONE_JOINTED)
				bone.relocate()
		victim.agony_scream()
		victim.visible_message(span_danger("<b>[owner]</b> relocates <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
						span_userdanger("<b>[owner]</b> relocates my [grasped_part.name]![carbon_victim.wound_message]"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I relocate <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	else
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)/2
		var/deal_wound_bonus = 5
		if(epic_success <= DICE_CRIT_FAILURE)
			deal_wound_bonus += 10
		grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = NONE)
		victim.visible_message(span_danger("<b>[owner]</b> painfully twists <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
						span_userdanger("<b>[owner]</b> painfully twists my [grasped_part.name]![carbon_victim.wound_message]"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I painfully twist <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	owner.changeNext_move(CLICK_CD_WRENCH)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/tear_off_limb()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	for(var/obj/item/organ/bone/bone in grasped_part)
		if(!(bone.damage >= bone.medium_threshold))
			return FALSE
	var/epic_success = owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH))
	if(epic_success >= DICE_SUCCESS)
		victim.visible_message(span_danger("<b>[owner]</b> tears <b>[victim]</b>'s [grasped_part.name] off!"), \
						span_userdanger("<b>[owner]</b> tears my [grasped_part.name] off!"), \
						span_hear("I hear a disgusting sound of flesh being torn apart."), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I tear <b>[victim]</b>'s [grasped_part.name] off!"))
		var/mob/living/victim_will_get_nulled = victim
		var/mob/living/carbon/owner_will_get_nulled = owner
		var/obj/item/bodypart/part_will_get_nulled = grasped_part
		grasped_part.drop_limb(FALSE, TRUE, FALSE, FALSE, WOUND_SLASH)
		//If nothing went bad, we should be qdeleted by now
		owner_will_get_nulled.changeNext_move(CLICK_CD_WRENCH)
		playsound(victim_will_get_nulled, 'modular_septic/sound/gore/tear.ogg', 100, FALSE)
		if(QDELETED(part_will_get_nulled))
			return TRUE
		owner_will_get_nulled.put_in_hands(part_will_get_nulled)
		return TRUE
	else
		return wrench_limb()

/obj/item/grab/proc/twist_embedded()
	//Wtf?
	if(!grasped_part || !LAZYACCESS(grasped_part.embedded_objects, 1))
		return FALSE
	return TRUE

/obj/item/grab/proc/pull_embedded()
	//Wtf?
	if(!grasped_part || !LAZYACCESS(grasped_part.embedded_objects, 1))
		return FALSE
	SEND_SIGNAL(victim, COMSIG_CARBON_EMBED_RIP, grasped_part.embedded_objects[1], grasped_part, owner)
	return TRUE
