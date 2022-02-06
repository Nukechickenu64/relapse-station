/mob/living/carbon/update_inv_hands()
	remove_overlay(HANDS_LAYER)
	if(handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	for(var/obj/item/item in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			item.screen_loc = ui_hand_position(get_held_index_of_item(item))
			client.screen += item
			if(length(observers))
				for(var/mob/dead/observe as anything in observers)
					if(observe.client && observe.client.eye == src)
						observe.client.screen += item
					else
						observers -= observe
						if(!observers.len)
							observers = null
							break

		var/icon_file = item.lefthand_file
		if(!(get_held_index_of_item(item) % RIGHT_HANDS))
			icon_file = item.righthand_file

		hands += item.build_worn_icon(default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)

	if(length(hands))
		overlays_standing[HANDS_LAYER] = hands

	apply_overlay(HANDS_LAYER)

/mob/living/carbon/update_inv_head()
	remove_overlay(HEAD_LAYER)

	if(!get_bodypart_nostump(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_icon()

	if(head)
		var/desired_icon = head.worn_icon
		var/used_style = NONE
		if(dna?.species?.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && head.mutant_variants & STYLE_MUZZLE)
				used_style = STYLE_MUZZLE
		switch(used_style)
			if(STYLE_MUZZLE)
				desired_icon = head.worn_icon_muzzled || 'modular_septic/icons/mob/clothing/head_muzzled.dmi'

		overlays_standing[HEAD_LAYER] = head.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = 'icons/mob/clothing/head.dmi', override_icon = desired_icon, mutant_styles = used_style)
		update_hud_head(head)

	apply_overlay(HEAD_LAYER)

/mob/living/carbon/update_inv_wear_mask()
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart_nostump(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_icon()

	if(wear_mask)
		var/desired_icon = wear_mask.worn_icon
		var/used_style = NONE
		if(dna?.species?.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && wear_mask.mutant_variants & STYLE_MUZZLE)
				used_style = STYLE_MUZZLE
		switch(used_style)
			if(STYLE_MUZZLE)
				desired_icon = wear_mask.worn_icon_muzzled || 'modular_septic/icons/mob/clothing/mask_muzzled.dmi'

		if(!(ITEM_SLOT_MASK in check_obscured_slots()))
			overlays_standing[FACEMASK_LAYER] = wear_mask.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi', override_icon = desired_icon, mutant_styles = used_style)
		update_hud_wear_mask(wear_mask)

	apply_overlay(FACEMASK_LAYER)

/mob/living/carbon/update_body()
	if(status_flags & BUILDING_ORGANS)
		return
	update_body_parts()

/mob/living/carbon/update_body_parts()
	//CHECK FOR UPDATE
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.update_limb()
	var/oldkey = icon_render_key
	icon_render_key = generate_icon_render_key()
	if(oldkey == icon_render_key)
		return

	remove_overlay(BODYPARTS_LAYER)

	//LOAD ICONS
	if(limb_icon_cache[icon_render_key])
		load_limb_from_cache()
		return

	var/is_taur = FALSE
	if(dna?.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(is_taur && (BP.body_part & LEGS|FEET))
			continue
		var/bp_icon = BP.get_limb_icon()
		if(islist(bp_icon) && length(bp_icon))
			new_limbs |= bp_icon
	if(length(new_limbs))
		overlays_standing[BODYPARTS_LAYER] = new_limbs
		limb_icon_cache[icon_render_key] = new_limbs

	apply_overlay(BODYPARTS_LAYER)

	update_damage_overlays()
	update_medicine_overlays()

/mob/living/carbon/generate_icon_render_key()
	. = "carbon"
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
		if(bodypart.color)
			. += "-color[bodypart.color]"
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
			. += "-advanced_render"
		for(var/zone in bodypart.body_markings)
			. += "-[zone]_markings"
			for(var/key in bodypart.body_markings[zone])
				var/datum/body_marking/marking = GLOB.body_markings[key]
				var/marking_string = "-marking-[marking.icon_state]"
				if(husked || HAS_TRAIT(bodypart, TRAIT_HUSK))
					marking_string += "-markingcolor888888"
				else
					marking_string += "-markingcolor[bodypart.body_markings[zone][key]]"
				. += marking_string

//change the mob's icon to the one matching its key
/mob/living/carbon/load_limb_from_cache()
	remove_overlay(BODYPARTS_LAYER)

	if(limb_icon_cache[icon_render_key])
		overlays_standing[BODYPARTS_LAYER] = limb_icon_cache[icon_render_key]

	apply_overlay(BODYPARTS_LAYER)

	update_damage_overlays()
	update_medicine_overlays()

/mob/living/carbon/update_fire(fire_icon = "generic_mob_burning")
	remove_overlay(FIRE_LAYER)

	if(on_fire || HAS_TRAIT(src, TRAIT_PERMANENTLY_ONFIRE))
		var/mutable_appearance/new_fire_overlay = mutable_appearance('modular_septic/icons/mob/human/overlays/onfire.dmi', fire_icon, -FIRE_LAYER)
		new_fire_overlay.appearance_flags = RESET_COLOR
		overlays_standing[FIRE_LAYER] = new_fire_overlay

	apply_overlay(FIRE_LAYER)

/mob/living/carbon/update_damage_overlays()
	remove_overlay(DAMAGE_LAYER)

	var/mutable_appearance/damage_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "blank", -DAMAGE_LAYER)
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.is_stump())
			continue
		if(BP.dmg_overlay_type)
			var/image/damage
			switch(BP.body_zone)
				if(BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[BP.dmg_overlay_type]_[BODY_ZONE_HEAD]_[BP.brutestate]0")
				if(BODY_ZONE_PRECISE_VITALS)
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[BP.dmg_overlay_type]_[BODY_ZONE_CHEST]_[BP.brutestate]0")
				else
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[BP.dmg_overlay_type]_[BP.body_zone]_[BP.brutestate]0")
			damage.layer = -DAMAGE_LAYER
			if(BP.render_layer == HANDS_PART_LAYER)
				damage.layer = -UPPER_DAMAGE_LAYER
			damage_overlays.add_overlay(damage)
	overlays_standing[DAMAGE_LAYER] = damage_overlays

	apply_overlay(DAMAGE_LAYER)

/mob/living/carbon/proc/update_medicine_overlays()
	remove_overlay(MEDICINE_LAYER)

	var/mutable_appearance/medicine_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "blank", -MEDICINE_LAYER)
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.is_stump())
			continue
		var/image/gauze
		if(BP.current_gauze?.medicine_overlay_prefix)
			gauze = image('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[BP.current_gauze.medicine_overlay_prefix]_[BP.body_zone][BP.use_digitigrade ? "_digitigrade" : "" ]")
			gauze.layer = -MEDICINE_LAYER
			if(BP.render_layer == HANDS_PART_LAYER)
				gauze.layer = -UPPER_MEDICINE_LAYER
			medicine_overlays.add_overlay(gauze)
		var/image/splint
		if(BP.current_splint?.medicine_overlay_prefix)
			splint = image('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[BP.current_splint.medicine_overlay_prefix]_[check_zone(BP.body_zone)][BP.use_digitigrade ? "_digitigrade" : "" ]")
			splint.layer = -MEDICINE_LAYER
			if(BP.render_layer == HANDS_PART_LAYER)
				splint.layer = -UPPER_MEDICINE_LAYER
			medicine_overlays.add_overlay(splint)
	overlays_standing[MEDICINE_LAYER] = medicine_overlays

	apply_overlay(MEDICINE_LAYER)

/mob/living/carbon/proc/update_artery_overlays()
	remove_overlay(ARTERY_LAYER)

	var/mutable_appearance/arteries = mutable_appearance('modular_septic/icons/mob/human/overlays/artery.dmi', "blank", -ARTERY_LAYER)
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		if(bodypart.is_stump() || !bodypart.is_organic_limb() || !bodypart.get_bleed_rate(TRUE))
			continue
		var/image/artery
		if(bodypart.is_artery_torn())
			artery = image('modular_septic/icons/mob/human/overlays/artery.dmi', "[bodypart.body_zone]_artery1")
			artery.layer = -ARTERY_LAYER
			arteries.add_overlay(artery)
	overlays_standing[ARTERY_LAYER] = arteries

	apply_overlay(ARTERY_LAYER)

/mob/living/carbon/proc/update_smelly()
	remove_overlay(SMELL_LAYER)
