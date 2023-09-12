/obj/item/bodypart/r_hand
	name = "right hand"
	desc = "It probably wasn't the right hand."
	icon_state = "default_human_r_hand"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	parent_body_zone = BODY_ZONE_R_ARM
	body_zone = BODY_ZONE_PRECISE_R_HAND
	body_part = HAND_RIGHT
	render_layer = HANDS_PART_LAYER
	max_damage = 30
	max_stamina_damage = 30
	held_index = RIGHT_HANDS
	px_x = 6
	px_y = -3
	stam_heal_tick = 1

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2.5

	melee_hit_modifier = -2
	melee_hit_zone_modifier = -1

	amputation_point_name = "right wrist"
	bone_type = BONE_R_HAND
	tendon_type = TENDON_R_HAND
	artery_type = ARTERY_R_HAND
	nerve_type = NERVE_R_HAND

/obj/item/bodypart/r_hand/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.set_handcuffed(null)
			C.update_handcuffed()
		if(C.gloves)
			C.dropItemToGround(C.gloves, TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay
