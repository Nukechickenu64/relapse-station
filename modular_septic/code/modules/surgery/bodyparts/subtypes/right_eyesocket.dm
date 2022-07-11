/obj/item/bodypart/r_eyesocket
	name = "right eyesocket"
	desc = "Sightless, until the eyes reappear."
	icon = 'modular_septic/icons/obj/items/surgery/organs.dmi'
	icon_state = "eyelid"
	base_icon_state = "eyelid"
	attack_verb_continuous = list("looks at", "sees")
	attack_verb_simple = list("look at", "see")
	parent_body_zone = BODY_ZONE_HEAD
	body_zone = BODY_ZONE_PRECISE_R_EYE
	body_part = EYE_RIGHT
	limb_flags = BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_HAS_TENDON|BODYPART_HAS_ARTERY|BODYPART_HAS_NERVE
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
		for(var/obj/item/organ/eyes/eye in src)
			var/image/eye_underlay
			eye_underlay = image(eye.icon, eye.icon_state)
			. += eye_underlay
			if(eye.iris_icon_state)
				var/image/iris = image(eye.icon, "eye-iris")
				iris.color = eye.eye_color || eye.old_eye_color
				. += iris
			break
		var/image/main_overlay = image(icon, base_icon_state)
		. += main_overlay
		if(should_draw_greyscale)
			var/draw_color = mutation_color || species_color || skintone2hex(skin_tone)
			if(draw_color)
				var/image/greyscale_overlay = image(icon, "[base_icon_state]-greyscale")
				greyscale_overlay.color = draw_color
				. += greyscale_overlay

/obj/item/bodypart/r_eyesocket/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	. = ..()
	if(istype(new_limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = new_limb
		head.right_eye = src
