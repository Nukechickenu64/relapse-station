/datum/species
	///Replaces bodypart icons
	var/limbs_icon
	///What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/list/default_mutant_bodyparts = list()
	///What accessories we are currently using
	var/list/list/mutant_bodyparts = list()
	///A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA.
	var/list/list/body_markings = list()
	///Override for the alpha of bodyparts and mutant parts.
	var/bodypart_alpha = 255
	///Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	///Whether a species can use augmentations in preferences
	var/can_augmentation = TRUE
	///If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE

/datum/species/can_wag_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!length(tails))
		return FALSE
	for(var/thing in tails)
		var/obj/item/organ/tail/tail = thing
		if(tail.can_wag)
			return TRUE
	return FALSE

/datum/species/is_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!LAZYLEN(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		if(tail.can_wag && tail.wagging)
			return TRUE
	return FALSE

/datum/species/start_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!length(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		if(tail.can_wag)
			tail.wagging = TRUE
	return FALSE

/datum/species/stop_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!LAZYLEN(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		tail.wagging = FALSE
	H.update_body()

/datum/species/spec_death(gibbed, mob/living/carbon/human/H)
	. = ..()
	if(is_wagging_tail(H))
		stop_wagging_tail(H)

/datum/species/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
	var/obj/item/bodypart/head/head = H.get_bodypart_nostump(BODY_ZONE_HEAD)
	if(!head) //Decapitated
		return

	if(HAS_TRAIT(H, TRAIT_HUSK))
		return
	var/datum/sprite_accessory/S
	var/list/standing = list()

	var/hair_hidden = FALSE //ignored if the matching dynamic_X_suffix is non-empty
	var/facialhair_hidden = FALSE // ^

	var/dynamic_hair_suffix = "" //if this is non-null, and hair+suffix matches an iconstate, then we render that hair instead
	var/dynamic_fhair_suffix = ""

	//for augmented heads
	if(head.status == BODYPART_ROBOTIC)
		return

	//we check if our hat or helmet hides our facial hair.
	if(H.head)
		var/obj/item/I = H.head
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_fhair_suffix = C.dynamic_fhair_suffix
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/I = H.wear_mask
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_fhair_suffix = C.dynamic_fhair_suffix //mask > head in terms of facial hair
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.facial_hairstyle && (FACEHAIR in species_traits) && (!facialhair_hidden || dynamic_fhair_suffix))
		S = GLOB.facial_hairstyles_list[H.facial_hairstyle]
		if(S)

			//List of all valid dynamic_fhair_suffixes
			var/static/list/fextensions
			if(!fextensions)
				var/icon/fhair_extensions = icon('icons/mob/facialhair_extensions.dmi')
				fextensions = list()
				for(var/s in fhair_extensions.IconStates(1))
					fextensions[s] = TRUE
				qdel(fhair_extensions)

			//Is hair+dynamic_fhair_suffix a valid iconstate?
			var/fhair_state = S.icon_state
			var/fhair_file = S.icon
			if(fextensions[fhair_state+dynamic_fhair_suffix])
				fhair_state += dynamic_fhair_suffix
				fhair_file = 'icons/mob/facialhair_extensions.dmi'

			var/mutable_appearance/facial_overlay = mutable_appearance(fhair_file, fhair_state, -HAIR_LAYER)

			if(!forced_colour)
				if(hair_color)
					if(hair_color == "mutcolor")
						facial_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					else if(hair_color == "fixedmutcolor")
						facial_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
					else
						facial_overlay.color = sanitize_hexcolor(hair_color, 6, TRUE)
				else
					facial_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
			else
				facial_overlay.color = sanitize_hexcolor(forced_colour, 6, TRUE)

			facial_overlay.alpha = hair_alpha

			standing += facial_overlay

	if(H.head)
		var/obj/item/I = H.head
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_hair_suffix = C.dynamic_hair_suffix
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/I = H.wear_mask
		if(!dynamic_hair_suffix && isclothing(I)) //head > mask in terms of head hair
			var/obj/item/clothing/C = I
			dynamic_hair_suffix = C.dynamic_hair_suffix
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(!hair_hidden || dynamic_hair_suffix)
		var/mutable_appearance/hair_overlay = mutable_appearance(layer = -HAIR_LAYER)
		var/mutable_appearance/gradient_overlay = mutable_appearance(layer = -HAIR_LAYER)
		if(H.hairstyle && (HAIR in species_traits))
			S = GLOB.hairstyles_list[H.hairstyle]
			if(S)

				//List of all valid dynamic_hair_suffixes
				var/static/list/extensions
				if(!extensions)
					var/icon/hair_extensions = icon('icons/mob/hair_extensions.dmi') //hehe
					extensions = list()
					for(var/s in hair_extensions.IconStates(1))
						extensions[s] = TRUE
					qdel(hair_extensions)

				//Is hair+dynamic_hair_suffix a valid iconstate?
				var/hair_state = S.icon_state
				var/hair_file = S.icon
				if(extensions[hair_state+dynamic_hair_suffix])
					hair_state += dynamic_hair_suffix
					hair_file = 'icons/mob/hair_extensions.dmi'

				hair_overlay.icon = hair_file
				hair_overlay.icon_state = hair_state

				if(!forced_colour)
					if(hair_color)
						if(hair_color == "mutcolor")
							hair_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						else if(hair_color == "fixedmutcolor")
							hair_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							hair_overlay.color = sanitize_hexcolor(hair_color, 6, TRUE)
					else
						hair_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)

					//Gradients
					grad_style = H.grad_style
					grad_color = H.grad_color
					if(grad_style)
						var/datum/sprite_accessory/gradient = GLOB.hair_gradients_list[grad_style]
						var/icon/temp = icon(gradient.icon, gradient.icon_state)
						var/icon/temp_hair = icon(hair_file, hair_state)
						temp.Blend(temp_hair, ICON_ADD)
						gradient_overlay.icon = temp
						gradient_overlay.color = grad_color

				else
					hair_overlay.color = sanitize_hexcolor(forced_colour, 6, TRUE)
				hair_overlay.alpha = hair_alpha
				if(OFFSET_FACE in H.dna.species.offset_features)
					hair_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FACE][1]
					hair_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FACE][2]
		if(hair_overlay.icon)
			standing += hair_overlay
			standing += gradient_overlay

	if(standing.len)
		H.overlays_standing[HAIR_LAYER] = standing

	H.apply_overlay(HAIR_LAYER)

/datum/species/handle_body(mob/living/carbon/human/species_human)
	species_human.remove_overlay(BODY_LAYER)

	var/list/standing = list()

	var/obj/item/bodypart/head/head = species_human.get_bodypart_nostump(BODY_ZONE_HEAD)
	if(head && !(HAS_TRAIT(species_human, TRAIT_HUSK)))
		var/obj/item/bodypart/face/face = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
		var/obj/item/bodypart/mouth/jaw = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		// face
		if(!face)
			var/mutable_appearance/face_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "face_missing", -BODY_LAYER)
			if(OFFSET_FACE in offset_features)
				face_overlay.pixel_x += offset_features[OFFSET_FACE][1]
				face_overlay.pixel_y += offset_features[OFFSET_FACE][2]
			standing += face_overlay
		// jaw
		if(jaw)
			// lipstick
			if(species_human.lip_style && (LIPS in species_traits))
				var/mutable_appearance/lip_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "lips_[species_human.lip_style]", -BODY_LAYER)
				lip_overlay.color = sanitize_hexcolor(species_human.lip_color, 6, TRUE)
				if(OFFSET_FACE in species_human.dna.species.offset_features)
					lip_overlay.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
					lip_overlay.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
				standing += lip_overlay
		else
			var/mutable_appearance/lip_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "lips_missing", -BODY_LAYER)
			if(OFFSET_FACE in species_human.dna.species.offset_features)
				lip_overlay.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
			standing += lip_overlay
		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/bodypart/left_eyesocket = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_L_EYE)
			var/obj/item/bodypart/right_eyesocket = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_R_EYE)
			var/obj/item/organ/eyes/LE
			var/obj/item/organ/eyes/RE
			for(var/obj/item/organ/eyes/eye in left_eyesocket?.get_organs())
				LE = eye
				break
			for(var/obj/item/organ/eyes/eye in right_eyesocket?.get_organs())
				RE = eye
				break
			var/obscured = species_human.check_obscured_slots(TRUE) //eyes that shine in the dark shouldn't show when you have glasses
			//cut any possible vis overlays
			if(length(body_vis_overlays))
				SSvis_overlays.remove_vis_overlay(species_human, body_vis_overlays)
			var/mutable_appearance/right_overlay
			var/mutable_appearance/right_emissive
			if(RE)
				right_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', RE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in species_traits)
					right_overlay.color = sanitize_hexcolor(species_human.right_eye_color, 6, TRUE)
				if(RE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					right_emissive = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', RE.eye_icon_state)
					right_emissive.plane = EMISSIVE_PLANE
			else
				right_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "eye-right-missing", -BODY_LAYER)
			var/mutable_appearance/left_overlay
			var/mutable_appearance/left_emissive
			if(LE)
				left_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', LE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in species_traits)
					left_overlay.color = sanitize_hexcolor(species_human.left_eye_color, 6, TRUE)
				if(LE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					left_emissive = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', LE.eye_icon_state)
					left_emissive.plane = EMISSIVE_PLANE
			else
				left_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "eye-left-missing", -BODY_LAYER)
			if(OFFSET_FACE in offset_features)
				if(right_overlay)
					right_overlay.pixel_x += offset_features[OFFSET_FACE][1]
					right_overlay.pixel_y += offset_features[OFFSET_FACE][2]
				if(right_emissive)
					right_emissive.pixel_x += offset_features[OFFSET_FACE][1]
					right_emissive.pixel_y += offset_features[OFFSET_FACE][2]
				if(left_overlay)
					left_overlay.pixel_x += offset_features[OFFSET_FACE][1]
					left_overlay.pixel_y += offset_features[OFFSET_FACE][2]
				if(left_emissive)
					left_emissive.pixel_x += offset_features[OFFSET_FACE][1]
					left_emissive.pixel_y += offset_features[OFFSET_FACE][2]
			if(right_overlay)
				standing += right_overlay
			if(right_emissive)
				standing += right_emissive
			if(left_overlay)
				standing += left_overlay
			if(left_emissive)
				standing += left_emissive

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(species_human.underwear && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[species_human.underwear]
			var/mutable_appearance/underwear_overlay
			if(underwear)
				if(species_human.dna.species.sexes && species_human.body_type == FEMALE && (underwear.gender == MALE))
					underwear_overlay = wear_female_version(underwear.icon_state, underwear.icon, -BODY_LAYER, FEMALE_UNIFORM_FULL)
				else
					underwear_overlay = mutable_appearance(underwear.icon, underwear.icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = sanitize_hexcolor(species_human.left_eye_color, 6, TRUE)
				standing += underwear_overlay

		if(species_human.undershirt && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[species_human.undershirt]
			if(undershirt)
				if(species_human.dna.species.sexes && species_human.body_type == FEMALE)
					standing += wear_female_version(undershirt.icon_state, undershirt.icon, -BODY_LAYER)
				else
					standing += mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)

		if(species_human.socks && species_human.num_legs >= species_human.default_num_legs && !(DIGITIGRADE in species_traits) && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[species_human.socks]
			if(socks)
				standing += mutable_appearance(socks.icon, socks.icon_state, -BODY_LAYER)

	if(length(standing))
		species_human.overlays_standing[BODY_LAYER] = standing

	species_human.apply_overlay(BODY_LAYER)

	handle_mutant_bodyparts(species_human)

/datum/species/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour, force_update = FALSE)
	var/list/standing	= list()

	//Digitigrade legs are stuck in the phantom zone between true limbs and mutant bodyparts. Mainly it just needs more agressive updating than most limbs.
	var/update_needed = FALSE
	var/not_digitigrade = TRUE
	for(var/X in H.bodyparts)
		var/obj/item/bodypart/bodypart = X
		if(!bodypart.use_digitigrade)
			continue
		not_digitigrade = FALSE
		if(!(DIGITIGRADE in species_traits)) //Someone cut off a digitigrade leg and tacked it on
			species_traits += DIGITIGRADE
		var/should_be_squished = FALSE
		if((H.wear_suit && H.wear_suit.flags_inv & HIDEJUMPSUIT && !(H.wear_suit.mutant_variants & STYLE_DIGITIGRADE) && (H.wear_suit.body_parts_covered & LEGS)) || (H.w_uniform && (H.w_uniform.body_parts_covered & LEGS|FEET) && !(H.w_uniform.mutant_variants & STYLE_DIGITIGRADE)))
			should_be_squished = TRUE
		if(bodypart.use_digitigrade == FULL_DIGITIGRADE && should_be_squished)
			bodypart.use_digitigrade = SQUISHED_DIGITIGRADE
			update_needed = TRUE
		else if(bodypart.use_digitigrade == SQUISHED_DIGITIGRADE && !should_be_squished)
			bodypart.use_digitigrade = FULL_DIGITIGRADE
			update_needed = TRUE
	if(update_needed)
		H.update_body_parts()
	//Curse is lifted
	if(not_digitigrade && (DIGITIGRADE in species_traits))
		species_traits -= DIGITIGRADE

	if(!length(mutant_bodyparts) || HAS_TRAIT(src, TRAIT_INVISIBLE_MAN))
		H.remove_overlay(BODY_BEHIND_LAYER)
		H.remove_overlay(BODY_ADJ_LAYER)
		H.remove_overlay(BODY_FRONT_LAYER)
		return

	var/list/bodyparts_to_add = list()
	var/new_renderkey = "[id]"
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/S
		var/name = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_NAME)
		var/colors = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_COLOR)
		if(name)
			S = LAZYACCESSASSOC(GLOB.sprite_accessories, key, name)
		if(!S || isnull(S.icon_state))
			continue
		var/obj/item/bodypart/associated_part = H.get_bodypart_nostump(S.body_zone)
		if(S.is_hidden(H, associated_part))
			continue
		var/render_state
		if(S.special_render_case)
			render_state = S.get_special_render_state(H)
		else
			render_state = S.icon_state
		new_renderkey += "-[key]-[render_state]"
		if(colors)
			if(islist(colors))
				for(var/this_color in colors)
					var/final_color = sanitize_hexcolor(this_color, 6, FALSE)
					new_renderkey += "-[final_color]"
			else
				var/final_color = sanitize_hexcolor(colors, 6, FALSE)
				new_renderkey += "-[final_color]"
		bodyparts_to_add[S] = render_state

	if(new_renderkey == H.mutant_renderkey && !force_update)
		return

	H.mutant_renderkey = new_renderkey

	H.remove_overlay(BODY_BEHIND_LAYER)
	H.remove_overlay(BODY_ADJ_LAYER)
	H.remove_overlay(BODY_FRONT_LAYER)

	var/gender = (H.body_type == FEMALE) ? "f" : "m"
	for(var/bodypart in bodyparts_to_add)
		var/datum/sprite_accessory/S = bodypart
		var/key = S.key

		var/icon_to_use
		var/x_shift
		var/render_state = bodyparts_to_add[S]

		var/override_color = forced_colour
		if(!override_color && S.special_colorize)
			override_color = S.get_special_render_colour(H, render_state)

		if(S.special_icon_case)
			icon_to_use = S.get_special_icon(H, render_state)
		else
			icon_to_use = S.icon

		if(S.special_x_dimension)
			x_shift = S.get_special_x_dimension(H, render_state)
		else
			x_shift = S.dimension_x

		if(S.gender_specific)
			render_state = "[gender]_[key]_[render_state]"
		else
			render_state = "m_[key]_[render_state]"

		for(var/layer in S.relevant_layers)
			var/layertext = mutant_bodyparts_layertext(layer)

			var/mutable_appearance/accessory_overlay = mutable_appearance(icon_to_use, layer = -layer)

			accessory_overlay.icon_state = "[render_state]_[layertext]"

			if(S.center)
				accessory_overlay = center_image(accessory_overlay, x_shift, S.dimension_y)

			if(!override_color)
				if(HAS_TRAIT(H, TRAIT_HUSK))
					if(S.color_src == USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
						accessory_overlay.color = HUSK_COLOR_LIST
					else
						accessory_overlay.color = "#AAAAAA" //The gray husk color
				else
					switch(S.color_src)
						if(USE_ONE_COLOR)
							///Matrix
							if(islist(mutant_bodyparts[key][MUTANT_INDEX_COLOR]))
								accessory_overlay.color = sanitize_hexcolor(mutant_bodyparts[key][MUTANT_INDEX_COLOR][1], 6, TRUE)
							///Hex
							else
								accessory_overlay.color = sanitize_hexcolor(mutant_bodyparts[key][MUTANT_INDEX_COLOR], 6, TRUE)
						if(USE_MATRIXED_COLORS)
							var/list/color_list = mutant_bodyparts[key][MUTANT_INDEX_COLOR]
							//this is here and not with the alpha setting code below as setting the alpha on a matrix color mutable appearance breaks it (at least in this case)
							var/alpha_value = bodypart_alpha
							var/list/finished_list = list()
							if(length(color_list) == 1)
								color_list = color_list[1]
							//Matrix
							if(istype(color_list))
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(1, length(color_list))], 6, FALSE)]00")
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(2, length(color_list))], 6, FALSE)]00")
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(3, length(color_list))], 6, FALSE)]00")
								finished_list += list(0,0,0,alpha_value)
							//Hex
							else
								var/color = ReadRGB("[sanitize_hexcolor(color_list, 6, FALSE)]00")
								var/list/final_color = ReadRGB(color)
								finished_list = list(final_color, final_color, final_color)
								finished_list += list(0,0,0,alpha_value)
							for(var/index in 1 to length(finished_list))
								finished_list[index] /= 255
							accessory_overlay.color = finished_list
						if(MUTCOLORS)
							if(fixed_mut_color)
								accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
							else
								accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						if(HAIR)
							if(hair_color == "mutcolor")
								accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
							else if(hair_color == "fixedmutcolor")
								accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
							else
								accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)
						if(FACEHAIR)
							accessory_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
						if(EYECOLOR)
							accessory_overlay.color = sanitize_hexcolor(H.left_eye_color, 6, TRUE)
			else
				accessory_overlay.color = sanitize_hexcolor(override_color, 6, TRUE)
			standing += accessory_overlay

			if(S.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(S.icon, layer = -layer)
				if(S.gender_specific)
					inner_accessory_overlay.icon_state = "[gender]_[key]inner_[S.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[key]inner_[S.icon_state]_[layertext]"

				if(S.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, S.dimension_x, S.dimension_y)

				standing += inner_accessory_overlay

			//Here's EXTRA parts of accessories which I should get rid of sometime TODO i guess
			if(S.extra) //apply the extra overlay, if there is one
				var/mutable_appearance/extra_accessory_overlay = mutable_appearance(S.icon, layer = -layer)
				if(S.gender_specific)
					extra_accessory_overlay.icon_state = "[gender]_[key]_extra_[S.icon_state]_[layertext]"
				else
					extra_accessory_overlay.icon_state = "m_[key]_extra_[S.icon_state]_[layertext]"
				if(S.center)
					extra_accessory_overlay = center_image(extra_accessory_overlay, S.dimension_x, S.dimension_y)

				switch(S.extra_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra_accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					if(MUTCOLORS2)
						extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor2"], 6, TRUE)
					if(MUTCOLORS3)
						extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
					if(HAIR)
						if(hair_color == "mutcolor")
							extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
						else
							extra_accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)
					if(FACEHAIR)
						extra_accessory_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
					if(EYECOLOR)
						extra_accessory_overlay.color = sanitize_hexcolor(H.left_eye_color, 6, TRUE)

				standing += extra_accessory_overlay

			if(S.extra2) //apply the extra overlay, if there is one
				var/mutable_appearance/extra2_accessory_overlay = mutable_appearance(S.icon, layer = -layer)
				if(S.gender_specific)
					extra2_accessory_overlay.icon_state = "[gender]_[key]_extra2_[S.icon_state]_[layertext]"
				else
					extra2_accessory_overlay.icon_state = "m_[key]_extra2_[S.icon_state]_[layertext]"
				if(S.center)
					extra2_accessory_overlay = center_image(extra2_accessory_overlay, S.dimension_x, S.dimension_y)

				switch(S.extra2_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra2_accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					if(MUTCOLORS2)
						extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor2"], 6, TRUE)
					if(MUTCOLORS3)
						extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
					if(HAIR)
						if(hair_color == "mutcolor3")
							extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						else
							extra2_accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)

				standing += extra2_accessory_overlay
			if (bodypart_alpha != 255 && !override_color)
				for(var/ov in standing)
					var/image/overlay = ov
					if(!istype(overlay.color, /list)) //check for a list because setting the alpha of the matrix colors breaks the color (the matrix alpha is set above inside the matrix)
						overlay.alpha = bodypart_alpha

			if(!H.overlays_standing[layer])
				H.overlays_standing[layer] = list()
			H.overlays_standing[layer] += standing
			standing = list()

	H.apply_overlay(BODY_BEHIND_LAYER)
	H.apply_overlay(BODY_ADJ_LAYER)
	H.apply_overlay(BODY_FRONT_LAYER)

/datum/species/proc/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = random_color()
	returned["mcolor2"] = random_color()
	returned["mcolor3"] = random_color()
	return returned

/datum/species/proc/get_random_mutant_bodyparts(list/features) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	var/list/bodyparts_to_add = default_mutant_bodyparts.Copy()
	for(var/key in bodyparts_to_add)
		var/datum/sprite_accessory/SP
		if(bodyparts_to_add[key] == ACC_RANDOM)
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = LAZYACCESSASSOC(GLOB.sprite_accessories, key, bodyparts_to_add[key])
			if(!SP)
				continue
		var/list/color_list = SP.get_default_color(features, src)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = SP.name
		final_list[MUTANT_INDEX_COLOR] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()
