/turf/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.client.Move(src, get_dir(living_user, src)))
			user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
								span_warning("I crawl on [src]."))
