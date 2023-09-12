/obj/item/bodypart/r_foot
	name = "right foot"
	desc = "Equals roughly 30.48 centimeters."
	icon_state = "default_human_r_foot"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	parent_body_zone = BODY_ZONE_R_LEG
	body_zone = BODY_ZONE_PRECISE_R_FOOT
	body_part = FOOT_RIGHT
	max_damage = 30
	max_stamina_damage = 30
	stance_index = 4
	px_x = -2
	px_y = 9
	stam_heal_tick = 1

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2.5

	melee_hit_modifier = -2
	melee_hit_zone_modifier = -1

	amputation_point_name = "left ankle"
	bone_type = BONE_R_FOOT
	tendon_type = TENDON_R_FOOT
	artery_type = ARTERY_R_FOOT
	nerve_type = NERVE_R_FOOT

/obj/item/bodypart/r_foot/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.drop_location())
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.dropItemToGround(owner.shoes, TRUE)
	return ..()
