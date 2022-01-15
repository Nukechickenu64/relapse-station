/obj/item/bodypart/chest
	name = "upper body"
	desc = "It's impolite to stare at someone's chest."
	icon_state = "default_human_chest"
	max_damage = 100
	max_stamina_damage = 100
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	maxdam_wound_penalty = 20 //hard to hit this cap
	dismemberable = FALSE
	limb_flags = (BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY)
	children_zones = list(BODY_ZONE_PRECISE_NECK, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
	gender_rendering = TRUE

	max_cavity_item_size = WEIGHT_CLASS_BULKY
	max_cavity_volume = 8

	//No modifier, hard to miss
	hit_modifier = 0
	//Positive modifier, hard to miss
	hit_zone_modifier = 4

	cavity_name = "thoracic cavity"
	amputation_point_name = "spine"
	bone_type = BONE_CHEST
	tendon_type = TENDON_CHEST
	artery_type = ARTERY_CHEST
	nerve_type = NERVE_CHEST

/obj/item/bodypart/chest/can_dismember(obj/item/I)
	return FALSE

/obj/item/bodypart/chest/drop_limb(special, ignore_children = FALSE, dismembered = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	if(special)
		return ..()
