/obj/item/bodypart/l_eyelid
	name = "left eyelid"
	desc = "Sightless, until the eyes reappear."
	icon = 'modular_septic/icons/obj/items/surgery/bodyparts.dmi'
	icon_state = "eyelid"
	base_icon_state = "eyelid"
	attack_verb_continuous = list("looks at", "sees")
	attack_verb_simple = list("look at", "see")
	parent_body_zone = BODY_ZONE_HEAD
	body_zone = BODY_ZONE_PRECISE_L_EYE
	body_part = EYE_LEFT
	limb_flags = BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY
	w_class = WEIGHT_CLASS_TINY
	max_damage = 30
	max_stamina_damage = 30
	wound_resistance = -10
	maxdam_wound_penalty = 5
	stam_heal_tick = 1
	px_x = 0
	px_y = 0

	melee_hit_modifier = -5
	melee_hit_zone_modifier = -3

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2

	throw_range = 7
	scars_covered_by_clothes = FALSE
	dismemberment_sounds = list('modular_septic/sound/gore/severed.ogg')

	cavity_name = "orbital cavity"
	amputation_point_name = "orbit"
	tendon_type = TENDON_L_EYE
	artery_type = ARTERY_L_EYE
	nerve_type = NERVE_L_EYE

/obj/item/bodypart/l_eyelid/get_limb_icon(dropped)
	if(dropped && !isbodypart(loc))
		. = list()
		for(var/obj/item/organ/eyes/eye in src)
			var/image/eye_underlay
			eye_underlay = image(eye.icon, eye.icon_state)
			eye_underlay.transform = matrix(-1, 0, 0, 0, 1, 0) //mirroring
			. += eye_underlay
			if(eye.iris_icon_state)
				var/image/iris = image(eye.icon, "eye-iris")
				iris.transform = matrix(-1, 0, 0, 0, 1, 0) //mirroring
				iris.color = sanitize_hexcolor(eye.eye_color || eye.old_eye_color)
				. += iris
			break
		var/image/main_overlay = image(icon, base_icon_state)
		main_overlay.transform = matrix(-1, 0, 0, 0, 1, 0) //mirroring
		. += main_overlay
		if(should_draw_greyscale)
			var/draw_color = mutation_color || species_color || skintone2hex(skin_tone)
			if(draw_color)
				var/image/greyscale_overlay = image(icon, "[base_icon_state]-greyscale")
				greyscale_overlay.transform = matrix(-1, 0, 0, 0, 1, 0) //mirroring
				greyscale_overlay.color = sanitize_hexcolor(draw_color)
				. += greyscale_overlay

/obj/item/bodypart/l_eyelid/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	. = ..()
	if(istype(new_limb, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/head = new_limb
		head.left_eye = src
