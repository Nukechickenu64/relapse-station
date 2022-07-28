/mob/living/carbon/human/regenerate_icons()
	if(notransform)
		return TRUE
	//invalidate mutant bodypart cache
	mutant_renderkey = null
	//invalidate bodyparts cache
	icon_render_key = null
	update_body()
	update_hair()
	update_inv_w_uniform()
	update_inv_wear_id()
	update_inv_gloves()
	update_inv_glasses()
	update_inv_ears()
	update_inv_shoes()
	update_inv_s_store()
	update_inv_wear_mask()
	update_inv_head()
	update_inv_belt()
	update_inv_back()
	update_inv_wear_suit()
	update_inv_pockets()
	update_inv_neck()
	update_inv_hands()
	update_inv_handcuffed()
	update_inv_legcuffed()
	update_fire()
	update_transform()
	//mutations
	update_mutations_overlay()
	//damage overlays
	update_damage_overlays()

//used when putting/removing clothes that hide certain mutant body parts to just update those and not update the whole body.
/mob/living/carbon/human/update_mutant_bodyparts(force_update = FALSE)
	return dna.species.handle_mutant_bodyparts(src, null, force_update)

/mob/living/carbon/human/update_body_parts()
	return dna.species.handle_bodyparts(src)

/mob/living/carbon/human/update_damage_overlays()
	return dna.species.handle_damage_overlays(src)

/mob/living/carbon/human/update_medicine_overlays()
	return dna.species.handle_medicine_overlays(src)

/mob/living/carbon/human/update_artery_overlays()
	return dna?.species?.handle_artery_overlays(src)

/mob/living/carbon/human/update_gore_overlays()
	return dna?.species?.handle_gore_overlays(src)

//produces a key based on the human's limbs
/mob/living/carbon/human/generate_icon_render_key()
	. = ""
	var/husked = FALSE
	if(dna?.species)
		. += "-markingalpha[dna.species.markings_alpha]"
	if(dna?.species?.mutant_bodyparts["taur"])
		. += "-taur[dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]"
	if(HAS_TRAIT(src, TRAIT_HUSK))
		husked = TRUE
		. += "-husk"
	if(dna.check_mutation(HULK))
		. += "-coloured-hulk"
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		. += "-[bodypart.body_zone]"
		if(bodypart.is_stump())
			. += "-stump"
		if(bodypart.animal_origin)
			. += "-[bodypart.animal_origin]"
		if(bodypart.status == BODYPART_ORGANIC)
			. += "-organic"
		else if(bodypart.status == BODYPART_ROBOTIC)
			. += "-robotic"
		if(bodypart.body_gender && bodypart.gender_rendering)
			. += "-gender[bodypart.body_gender]"
		if(bodypart.species_id)
			. += "-[bodypart.species_id]"
		if(bodypart.skin_tone)
			. += "-skintone[bodypart.skin_tone]"
		if(bodypart.species_color)
			. += "-speciescolor[bodypart.species_color]"
		if(bodypart.mutation_color)
			. += "-mutationcolor[bodypart.mutation_color]"
		if(bodypart.use_digitigrade)
			. += "-digitigrade[bodypart.use_digitigrade]"
		if(bodypart.dmg_overlay_type)
			. += "-[bodypart.dmg_overlay_type]"
		if(HAS_TRAIT(bodypart, TRAIT_ROTTEN))
			. += "-rotten"
		else if(HAS_TRAIT(bodypart, TRAIT_PLASMABURNT))
			. += "-plasmaburnt"
		else if(HAS_TRAIT(bodypart, TRAIT_HUSK))
			. += "-husk"
		if(bodypart.advanced_rendering)
			. += "-advanced_rendering"
		for(var/zone in bodypart.body_markings)
			. += "-[zone]_markings"
			for(var/key in bodypart.body_markings[zone])
				var/datum/body_marking/marking = GLOB.body_markings[key]
				var/marking_string = "-marking-[marking.icon_state]"
				if(husked || HAS_TRAIT(bodypart, TRAIT_HUSK))
					marking_string += "-color888888"
				else
					marking_string += "-color[bodypart.body_markings[zone][key]]"
				. += marking_string
		if(bodypart.is_stump())
			. += "-stump"

/mob/living/carbon/human/update_fire(fire_icon = "generic_mob_burning")
	remove_overlay(FIRE_LAYER)

	if(fire_stacks > (HUMAN_FIRE_STACK_ICON_NUM*2))
		fire_icon = "standing_bad"
	else if(fire_stacks > HUMAN_FIRE_STACK_ICON_NUM)
		fire_icon = "standing"
	if(ismonkey(src))
		fire_icon = "standing_monkey"
	if(on_fire || HAS_TRAIT(src, TRAIT_PERMANENTLY_ONFIRE))
		var/mutable_appearance/new_fire_overlay = mutable_appearance('modular_septic/icons/mob/human/overlays/onfire.dmi', fire_icon, -FIRE_LAYER)
		new_fire_overlay.appearance_flags = RESET_COLOR
		overlays_standing[FIRE_LAYER] = new_fire_overlay

	apply_overlay(FIRE_LAYER)

/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)

	if(!get_bodypart_nostump(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_LEAR) + 1]
		inv.update_appearance()
		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_REAR) + 1]
		inv.update_appearance()

	if(ears_extra)
		ears_extra.screen_loc = ui_ears_extra //move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.upper_inventory_shown) //if the inventory is open
				client.screen += ears_extra //add it to the client's screen
		update_observer_view(ears_extra,1)
		overlays_standing[EARS_LAYER] = ears_extra.build_worn_icon(default_layer = EARS_LAYER, default_icon_file = 'icons/mob/clothing/ears.dmi')
		var/mutable_appearance/ears_overlay = overlays_standing[EARS_LAYER]
		if(OFFSET_EARS in dna.species.offset_features)
			ears_overlay.pixel_x += dna.species.offset_features[OFFSET_EARS][1]
			ears_overlay.pixel_y += dna.species.offset_features[OFFSET_EARS][2]
		overlays_standing[EARS_LAYER] = ears_overlay
	if(ears)
		ears.screen_loc = ui_ears //move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.upper_inventory_shown) //if the inventory is open
				client.screen += ears //add it to the client's screen
		update_observer_view(ears,1)
		overlays_standing[EARS_LAYER] = ears.build_worn_icon(default_layer = EARS_LAYER, default_icon_file = 'icons/mob/clothing/ears.dmi')
		var/mutable_appearance/ears_overlay = overlays_standing[EARS_LAYER]
		if(OFFSET_EARS in dna.species.offset_features)
			ears_overlay.pixel_x += dna.species.offset_features[OFFSET_EARS][1]
			ears_overlay.pixel_y += dna.species.offset_features[OFFSET_EARS][2]
		overlays_standing[EARS_LAYER] = ears_overlay

	apply_overlay(EARS_LAYER)

/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_OCLOTHING) + 1]
		inv.update_icon()

	if(wear_suit)
		wear_suit.screen_loc = ui_oclothing
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += wear_suit
		update_observer_view(wear_suit, TRUE)
		var/icon_file = wear_suit.worn_icon
		var/applied_style = NONE
		if(dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
			if(wear_suit.mutant_variants & S.taur_mode)
				applied_style = S.taur_mode
			else if(wear_suit.mutant_variants & S.alt_taur_mode)
				applied_style = S.alt_taur_mode
		if(!applied_style)
			if((DIGITIGRADE in dna.species.species_traits) && (wear_suit.mutant_variants & STYLE_DIGITIGRADE))
				applied_style = STYLE_DIGITIGRADE

		var/x_override
		switch(applied_style)
			if(STYLE_DIGITIGRADE)
				icon_file = wear_suit.worn_icon_digi || 'modular_septic/icons/mob/clothing/suit_digi.dmi'
			if(STYLE_TAUR_SNAKE)
				icon_file = wear_suit.worn_icon_taur_snake || 'modular_septic/icons/mob/clothing/suit_taur_snake.dmi'
			if(STYLE_TAUR_HOOF)
				icon_file = wear_suit.worn_icon_taur_hoof || 'modular_septic/icons/mob/clothing/suit_taur_hoof.dmi'
			if(STYLE_TAUR_PAW)
				icon_file = wear_suit.worn_icon_taur_paw || 'modular_septic/icons/mob/clothing/suit_taur_paw.dmi'

		if(applied_style & STYLE_TAUR_ALL)
			x_override = 64

		overlays_standing[SUIT_LAYER] = wear_suit.build_worn_icon(default_layer = SUIT_LAYER, default_icon_file = 'icons/mob/clothing/suit.dmi', override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style)
		var/mutable_appearance/suit_overlay = overlays_standing[SUIT_LAYER]
		if(OFFSET_SUIT in dna.species.offset_features)
			suit_overlay.pixel_x += dna.species.offset_features[OFFSET_SUIT][1]
			suit_overlay.pixel_y += dna.species.offset_features[OFFSET_SUIT][2]
		overlays_standing[SUIT_LAYER] = suit_overlay

	update_hair()
	update_mutant_bodyparts()

	apply_overlay(SUIT_LAYER)

/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ICLOTHING) + 1]
		inv.update_icon()

	if(istype(w_uniform, /obj/item/clothing))
		var/obj/item/clothing/under/U = w_uniform
		U.screen_loc = ui_iclothing
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += w_uniform
		update_observer_view(w_uniform,1)

		if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
			return

		var/applied_style = NONE
		var/icon_file = w_uniform.worn_icon
		if(dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
			if(w_uniform.mutant_variants & S.taur_mode)
				applied_style = S.taur_mode
			else if(w_uniform.mutant_variants & S.alt_taur_mode)
				applied_style = S.alt_taur_mode
		if(!applied_style)
			if((DIGITIGRADE in dna.species.species_traits) && (w_uniform.mutant_variants & STYLE_DIGITIGRADE))
				applied_style = STYLE_DIGITIGRADE

		var/x_override
		switch(applied_style)
			if(STYLE_DIGITIGRADE)
				icon_file = w_uniform.worn_icon_digi || 'modular_septic/icons/mob/clothing/under/uniform_digi.dmi'
			if(STYLE_TAUR_SNAKE)
				icon_file = w_uniform.worn_icon_taur_snake || 'modular_septic/icons/mob/clothing/under/uniform_taur_snake.dmi'
			if(STYLE_TAUR_HOOF)
				icon_file = w_uniform.worn_icon_taur_hoof || 'modular_septic/icons/mob/clothing/under/uniform_taur_hoof.dmi'
			if(STYLE_TAUR_PAW)
				icon_file = w_uniform.worn_icon_taur_paw || 'modular_septic/icons/mob/clothing/under/uniform_taur_paw.dmi'

		if(applied_style & STYLE_TAUR_ALL)
			x_override = 64

		var/target_overlay = U.icon_state
		if(U.adjusted == ALT_STYLE)
			target_overlay = "[target_overlay]_d"


		var/mutable_appearance/uniform_overlay

		if(dna && dna.species.sexes && !applied_style)
			if((body_type in FEMININE_BODY_TYPES) && U.fitted != NO_FEMALE_UNIFORM)
				uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, femaleuniform = U.fitted, override_state = target_overlay, override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style)

		if(!uniform_overlay)
			uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_state = target_overlay, override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style)

		if(OFFSET_UNIFORM in dna.species.offset_features)
			uniform_overlay.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
			uniform_overlay.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
		overlays_standing[UNIFORM_LAYER] = uniform_overlay

	update_mutant_bodyparts()
	apply_overlay(UNIFORM_LAYER)

/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_appearance()

	if(!(NOBLOODOVERLAY in dna.species.species_traits) && (num_hands > 0))
		if(!gloves && blood_in_hands)
			var/mutable_appearance/bloody_overlay = mutable_appearance('modular_septic/icons/effects/blood.dmi', "bloodyhands", -GLOVES_LAYER)
			if(num_hands < 2)
				if(has_left_hand(FALSE))
					bloody_overlay.icon_state = "bloodyhands_left"
				else if(has_right_hand(FALSE))
					bloody_overlay.icon_state = "bloodyhands_right"

			overlays_standing[GLOVES_LAYER] = bloody_overlay

	var/mutable_appearance/gloves_overlay = overlays_standing[GLOVES_LAYER]
	if(gloves)
		gloves.screen_loc = ui_gloves
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += gloves
		update_observer_view(gloves,1)
		overlays_standing[GLOVES_LAYER] = gloves.build_worn_icon(default_layer = GLOVES_LAYER, default_icon_file = 'icons/mob/clothing/hands.dmi')
		gloves_overlay = overlays_standing[GLOVES_LAYER]
		if(OFFSET_GLOVES in dna.species.offset_features)
			gloves_overlay.pixel_x += dna.species.offset_features[OFFSET_GLOVES][1]
			gloves_overlay.pixel_y += dna.species.offset_features[OFFSET_GLOVES][2]
	overlays_standing[GLOVES_LAYER] = gloves_overlay

	apply_overlay(GLOVES_LAYER)

/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)

	if(dna.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			return

	if(!istype(src, /mob/living/carbon/human/dummy) && (num_legs < default_num_legs))
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
		inv.update_icon()

	if(shoes)
		shoes.screen_loc = ui_shoes					//move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open
				client.screen += shoes					//add it to client's screen
		update_observer_view(shoes,1)
		var/icon_file = shoes.worn_icon
		var/applied_styles = NONE
		if((DIGITIGRADE in dna.species.species_traits) && (shoes.mutant_variants & STYLE_DIGITIGRADE))
			applied_styles |= STYLE_DIGITIGRADE
			icon_file = shoes.worn_icon_digi || 'modular_septic/icons/mob/clothing/feet_digi.dmi'

		overlays_standing[SHOES_LAYER] = shoes.build_worn_icon(default_layer = SHOES_LAYER, default_icon_file = 'icons/mob/clothing/feet.dmi', override_icon = icon_file, mutant_styles = applied_styles)
		var/mutable_appearance/shoes_overlay = overlays_standing[SHOES_LAYER]
		if(OFFSET_SHOES in dna.species.offset_features)
			shoes_overlay.pixel_x += dna.species.offset_features[OFFSET_SHOES][1]
			shoes_overlay.pixel_y += dna.species.offset_features[OFFSET_SHOES][2]
		overlays_standing[SHOES_LAYER] = shoes_overlay

	apply_overlay(SHOES_LAYER)

/mob/living/carbon/human/update_inv_s_store()
	remove_overlay(SUIT_STORE_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SUITSTORE) + 1]
		inv.update_appearance()

	if(s_store)
		s_store.screen_loc = ui_sstore1
		if(client && hud_used?.hud_shown)
			client.screen += s_store
		update_observer_view(s_store)
		var/list/worn_icon_states = icon_states(s_store.worn_icon)
		var/static/list/back_icon_states = icon_states('icons/mob/clothing/back.dmi')
		var/static/list/also_back_icon_states = icon_states('modular_septic/icons/mob/clothing/back.dmi')
		if((s_store.worn_icon_state in worn_icon_states) || (s_store.worn_icon_state in back_icon_states) || (s_store.worn_icon_state in also_back_icon_states))
			if(s_store.worn_icon_state in worn_icon_states)
				overlays_standing[SUIT_STORE_LAYER] = s_store.build_worn_icon(default_layer = SUIT_STORE_LAYER, default_icon_file = 'icons/mob/clothing/back.dmi')
			else if(s_store.worn_icon_state in back_icon_states)
				overlays_standing[SUIT_STORE_LAYER] = s_store.build_worn_icon(default_layer = SUIT_STORE_LAYER, default_icon_file = 'icons/mob/clothing/back.dmi', override_icon = 'icons/mob/clothing/back.dmi')
			else
				overlays_standing[SUIT_STORE_LAYER] = s_store.build_worn_icon(default_layer = SUIT_STORE_LAYER, default_icon_file = 'modular_septic/icons/mob/clothing/back.dmi', override_icon = 'modular_septic/icons/mob/clothing/back.dmi')
			var/mutable_appearance/s_store_overlay = overlays_standing[SUIT_STORE_LAYER]
			if(OFFSET_S_STORE in dna.species.offset_features)
				s_store_overlay.pixel_x += dna.species.offset_features[OFFSET_S_STORE][1]
				s_store_overlay.pixel_y += dna.species.offset_features[OFFSET_S_STORE][2]
			overlays_standing[SUIT_STORE_LAYER] = s_store_overlay

	apply_overlay(SUIT_STORE_LAYER)

//update whether our head item appears on our hud.
/mob/living/carbon/human/update_hud_head(obj/item/equipped_item)
	equipped_item.screen_loc = ui_head
	if(client && hud_used?.hud_shown)
		client.screen += equipped_item
	update_observer_view(equipped_item, TRUE)

//update whether our mask item appears on our hud.
/mob/living/carbon/human/update_hud_wear_mask(obj/item/equipped_item)
	equipped_item.screen_loc = ui_mask
	if(client && hud_used?.hud_shown)
		client.screen += equipped_item
	update_observer_view(equipped_item, TRUE)

// Only renders the head of the human
/mob/living/carbon/human/update_body_parts_head_only()
	if (!dna)
		return

	if (!dna.species)
		return

	var/obj/item/bodypart/head = get_bodypart_nostump(BODY_ZONE_HEAD)
	if(!istype(head))
		return

	head.update_limb()

	add_overlay(head.get_limb_icon())
	update_damage_overlays()
	if(head && !(HAS_TRAIT(src, TRAIT_HUSK)))
		// lipstick
		if(lip_style && (LIPS in dna.species.species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[lip_style]", -BODY_LAYER)
			lip_overlay.color = lip_color
			if(OFFSET_FACE in dna.species.offset_features)
				lip_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(lip_overlay)

		// eyes
		if(!(NOEYESPRITES in dna.species.species_traits))
			var/obj/item/bodypart/left_eyelid = get_bodypart_nostump(BODY_ZONE_PRECISE_L_EYE)
			var/obj/item/bodypart/right_eyelid = get_bodypart_nostump(BODY_ZONE_PRECISE_R_EYE)
			var/obj/item/organ/eyes/LE
			var/obj/item/organ/eyes/RE
			for(var/obj/item/organ/eyes/eye in left_eyelid?.get_organs())
				LE = eye
				break
			for(var/obj/item/organ/eyes/eye in right_eyelid?.get_organs())
				RE = eye
				break
			var/mutable_appearance/eye_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "blank", -BODY_LAYER)
			var/obscured = check_obscured_slots(TRUE) //eyes that shine in the dark shouldn't show when you have glasses
			if(RE)
				var/image/right_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, RE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in dna.species.species_traits)
					right_overlay.color = sanitize_hexcolor(right_eye_color, 6, TRUE)
				eye_overlay.add_overlay(right_overlay)
				if(RE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					var/image/right_emissive = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, RE.eye_icon_state, -BODY_LAYER)
					right_emissive.plane = EMISSIVE_PLANE
					eye_overlay.add_overlay(right_emissive)
			else
				eye_overlay.add_overlay(image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "eye-right-missing", -BODY_LAYER))
			if(LE)
				var/image/left_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, LE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in dna.species.species_traits)
					left_overlay.color = sanitize_hexcolor(left_eye_color, 6, TRUE)
				eye_overlay.add_overlay(left_overlay)
				if(LE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					var/image/left_emissive = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, LE.eye_icon_state, -BODY_LAYER)
					left_emissive.plane = EMISSIVE_PLANE
					eye_overlay.add_overlay(left_emissive)
			else
				eye_overlay.add_overlay(image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "eye-left-missing", -BODY_LAYER))
			if(OFFSET_FACE in dna.species.offset_features)
				eye_overlay.pixel_x += dna.species.offset_features[OFFSET_FACE][1]
				eye_overlay.pixel_y += dna.species.offset_features[OFFSET_FACE][2]
			add_overlay(eye_overlay)

	dna.species.handle_hair(src)

	update_inv_head()
	update_inv_wear_mask()
	update_inv_glasses()
	update_inv_ears()

/obj/item/build_worn_icon(default_layer = 0, default_icon_file = null, isinhands = FALSE, femaleuniform = NO_FEMALE_UNIFORM, override_state = null, override_icon = null, override_x_center = null, override_y_center = null, mutant_styles = NONE)
	//Find a valid icon_state from variables+arguments
	var/t_state
	if(override_state)
		t_state = override_state
	else
		t_state = !isinhands ? (worn_icon_state ? worn_icon_state : icon_state) : (inhand_icon_state ? inhand_icon_state : icon_state)

	//Find a valid icon file from variables+arguments
	var/file2use
	if(override_icon)
		file2use = override_icon
	else
		file2use = !isinhands ? (worn_icon ? worn_icon : default_icon_file) : default_icon_file

	//Find a valid layer from variables+arguments
	var/layer2use = alternate_worn_layer ? alternate_worn_layer : default_layer

	var/mutable_appearance/standing
	if(femaleuniform)
		standing = wear_female_version(t_state,file2use,layer2use,femaleuniform) //should layer2use be in sync with the adjusted value below? needs testing - shiz
	if(!standing)
		standing = mutable_appearance(file2use, t_state, -layer2use)

	//Get the overlays for this item when it's being worn
	//eg: ammo counters, primed grenade flashes, etc.
	var/list/worn_overlays = worn_overlays(standing, isinhands, file2use)
	if(LAZYLEN(worn_overlays))
		standing.overlays.Add(worn_overlays)

	var/x_center
	var/y_center
	if(override_x_center)
		x_center = override_x_center
	else
		x_center = isinhands ? inhand_x_dimension : worn_x_dimension
	if(override_y_center)
		y_center = override_y_center
	else
		y_center = isinhands ? inhand_y_dimension : worn_y_dimension
	standing = center_image(standing, x_center, y_center)

	//Worn offsets
	var/list/offsets = get_worn_offsets(isinhands)
	standing.pixel_x += offsets[1]
	standing.pixel_y += offsets[2]

	standing.alpha = alpha
	standing.color = color

	return standing

/mob/living/carbon/human/update_smelly()
	remove_overlay(SMELL_LAYER)

	switch(germ_level)
		if(-INFINITY to GERM_LEVEL_DIRTY)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smelly", /datum/mood_event/clean)
		if(GERM_LEVEL_DIRTY to GERM_LEVEL_FILTHY)
			SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smelly")
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smelly", /datum/mood_event/needshower)
			overlays_standing[SMELL_LAYER] = mutable_appearance('modular_septic/icons/effects/smell.dmi', "smell", -SMELL_LAYER)
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smelly", /datum/mood_event/reallyneedshower)
			overlays_standing[SMELL_LAYER] = mutable_appearance('modular_septic/icons/effects/smell.dmi', "smell", -SMELL_LAYER)

	apply_overlay(SMELL_LAYER)
