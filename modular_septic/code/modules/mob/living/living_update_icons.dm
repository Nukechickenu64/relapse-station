/mob/living/update_transform()
	. = ..()
	update_shadow()

/mob/living/update_shadow()
	vis_contents |= get_mob_shadow(NORMAL_MOB_SHADOW, src.plane)
