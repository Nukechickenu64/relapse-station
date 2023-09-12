/obj/item/bodypart/r_eyesocket
	name = "right eyesocket"
	desc = "Sightless, until the eyes reappear."
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "eyelid"
	base_icon_state = "eyelid"
	attack_verb_continuous = list("looks at", "sees")
	attack_verb_simple = list("look at", "see")
	parent_body_zone = BODY_ZONE_HEAD
	body_zone = BODY_ZONE_PRECISE_R_EYE
	body_part = EYE_RIGHT
	limb_flags = BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_EASY_MAJOR_WOUND|BODYPART_HAS_TENDON|BODYPART_HAS_ARTERY|BODYPART_HAS_NERVE
	w_class = WEIGHT_CLASS_TINY
	max_damage = 30
	max_stamina_damage = 30
	wound_resistance = -10
	maxdam_wound_penalty = 5
	stam_heal_tick = 1

	melee_hit_modifier = -5
	melee_hit_zone_modifier = -3

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2

	throw_range = 7
	scars_covered_by_clothes = FALSE
	dismemberment_sounds = list('modular_septic/sound/gore/severed.ogg')

	cavity_name = "orbital cavity"
	amputation_point_name = "orbit"
	tendon_type = TENDON_R_EYE
	artery_type = ARTERY_R_EYE
	nerve_type = NERVE_R_EYE

/obj/item/bodypart/r_eyesocket/get_limb_icon(dropped)
	if(dropped && !isbodypart(loc))
		. = list()
		var/image/funky_anus = image('modular_septic/icons/obj/items/surgery.dmi', src, base_icon_state, BELOW_MOB_LAYER)
		funky_anus.plane = plane
		. += funky_anus
		for(var/obj/item/organ/eyes/eye in src)
			var/image/eye_under
			var/image/iris
			eye_under = image(eye.icon, src, eye.icon_state, BELOW_MOB_LAYER-0.02)
			if(eye.iris_icon_state)
				iris = image(eye.icon, src, "eye-iris", BELOW_MOB_LAYER-0.01)
				iris.color = eye.eye_color || eye.old_eye_color
			. += eye_under
			if(iris)
				. += iris
			break

/obj/item/bodypart/r_eyesocket/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	. = ..()
	if(istype(new_limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = new_limb
		head.right_eye = src
