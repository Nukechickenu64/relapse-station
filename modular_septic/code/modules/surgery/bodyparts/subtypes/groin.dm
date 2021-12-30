/obj/item/bodypart/groin
	name = "lower body"
	desc = "Some say groin came from grynde, which is middle-ages speak for depression. Makes sense for the situation."
	icon_state = "default_human_groin"
	max_damage = 100
	max_stamina_damage = 100
	parent_body_zone = BODY_ZONE_CHEST
	body_zone = BODY_ZONE_PRECISE_GROIN
	body_part = GROIN
	px_x = 0
	px_y = 4
	stam_damage_coeff = 1
	maxdam_wound_penalty = 20 //hard to hit this cap
	limb_flags = (BODYPART_EDIBLE|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY)
	children_zones = list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	gender_rendering = TRUE

	max_cavity_item_size = WEIGHT_CLASS_NORMAL
	max_cavity_volume = 7

	//Positive modifier, hard to miss
	hit_zone_modifier = 1

	cavity_name = "abdominal cavity"
	amputation_point_name = "lumbar"
	bone_type = BONE_GROIN
	tendon_type = TENDON_GROIN
	artery_type = ARTERY_GROIN
	nerve_type = NERVE_GROIN
