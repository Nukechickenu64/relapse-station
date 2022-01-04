/mob/living/carbon/attempt_self_grab()
	var/obj/item/bodypart/hand = get_active_hand()
	if(hand && (zone_selected in list(hand.body_zone, hand.parent_body_zone)))
		to_chat(src, span_warning("I can't grab my [parse_zone(zone_selected)] with my [hand.name]!"))
		return
	return grippedby(src, TRUE)

/mob/living/carbon/grippedby(mob/living/carbon/user, instant = FALSE)
	// We need to be pulled man
	if(src != user)
		if(!user.pulling || user.pulling != src)
			return
	var/obj/item/grab/active_grab = user.get_active_held_item()
	if(active_grab)
		if(istype(active_grab))
			to_chat(user, span_warning("I'm already grabbing something!"))
		else
			to_chat(user, span_warning("My hand is busy!"))
		return
	var/obj/item/bodypart/affected = get_bodypart_nostump(check_zone(user.zone_selected))
	if(!affected)
		to_chat(user, span_warning("[p_they(TRUE)] do[p_es()]n't have a [parse_zone(user.zone_selected)]!"))
		return
	var/hit_modifier = affected.hit_modifier
	//easy to kick people when they are down
	if((body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
		hit_modifier += 4
	//very hard to miss when hidden by fov
	if(!(src in fov_viewers(2, user)))
		hit_modifier += 5
	//epic grab fail
	if((user != src) && !user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MELEE)-affected.hit_modifier))
		user.visible_message(span_warning("<b>[user]</b> tries to grab <b>[src]</b>!"), \
				span_userdanger("I fail to grab <b>[src]</b>!"), \
				blind_message = span_hear("I hear some loud shuffling!"), \
				ignored_mobs = src)
		to_chat(src, span_userdanger("<b>[user]</b> tries to grab me!"))
		user.changeNext_move(CLICK_CD_GRABBING)
		return FALSE
	active_grab = new()
	user.put_in_active_hand(active_grab, FALSE)
	if(QDELETED(active_grab))
		return
	user.changeNext_move(CLICK_CD_GRABBING)
	active_grab.registergrab(src, user, affected, instant)
	active_grab.create_hud_object()
	active_grab.update_grab_mode()
	active_grab.display_grab_message()

/mob/living/carbon/resist_grab(moving_resist)
	. = TRUE
	if((pulledby.grab_state >= GRAB_AGGRESSIVE) || (body_position == LYING_DOWN) || HAS_TRAIT(src, TRAIT_GRABWEAKNESS))
		var/mob/living/pulling_mob = pulledby
		var/grabber_strength = 0
		if(istype(pulling_mob))
			grabber_strength = GET_MOB_ATTRIBUTE_VALUE(pulling_mob, STAT_STRENGTH)
		var/resist_diceroll = diceroll(CEILING(GET_MOB_SKILL_VALUE(src, SKILL_MELEE)*1.5, 1)-grabber_strength)
		if(resist_diceroll >= DICE_SUCCESS)
			adjustFatigueLoss(5)
			visible_message(span_danger("<b>[src]</b> breaks free from <b>[pulledby]</b>'s grip!"), \
							span_userdanger("I break free from <b>[pulledby]</b>'s grip!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_danger("<b>[src]</b> breaks free from my grip!"))
			log_combat(pulledby, src, "broke grab")
			pulledby.stop_pulling()
			return FALSE
		else
			adjustFatigueLoss(5)//failure to escape still imparts a pretty serious penalty
			visible_message(span_danger("<b>[src]</b> struggles to break free from [pulledby]'s grip!"), \
							span_userdanger("I struggle to break free from [pulledby]'s grip!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_userdanger("<b>[src]</b> struggles to break free from my grip!"))
		if(moving_resist && client) //we resisted by trying to move
			client.move_delay = world.time + CLICK_CD_RESIST * 2
		return TRUE
	pulledby.stop_pulling()
	return FALSE
