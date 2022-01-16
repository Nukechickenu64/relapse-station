/datum/species
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,\
		BODY_ZONE_PRECISE_L_HAND = /obj/item/bodypart/l_hand,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,\
		BODY_ZONE_PRECISE_R_HAND = /obj/item/bodypart/r_hand,\
		BODY_ZONE_PRECISE_L_EYE = /obj/item/bodypart/l_eyesocket,\
		BODY_ZONE_PRECISE_R_EYE = /obj/item/bodypart/r_eyesocket,\
		BODY_ZONE_PRECISE_MOUTH = /obj/item/bodypart/mouth,\
		BODY_ZONE_PRECISE_FACE = /obj/item/bodypart/face,\
		BODY_ZONE_PRECISE_NECK = /obj/item/bodypart/neck,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg,\
		BODY_ZONE_PRECISE_L_FOOT = /obj/item/bodypart/l_foot,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg,\
		BODY_ZONE_PRECISE_R_FOOT = /obj/item/bodypart/r_foot,\
		BODY_ZONE_PRECISE_GROIN = /obj/item/bodypart/groin,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest,\
		)
	var/list/pain_emote_by_power = list(
		"100" = "agonyscream",
		"90" = "whimper",
		"80" = "moan",
		"70" = "cry",
		"60" = "gargle",
		"50" = "moan",
		"40" = "moan",
		"30" = "groan",
		"20" = "groan",
		"10" = "grunt", //Below 10 pain, we shouldn't emote.
		)
	var/reagent_processing = REAGENT_ORGANIC
	var/list/default_genitals = list(ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis,
									ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles,
									ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
									ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
									ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts,
									ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
									)
	var/mutantspleen = /obj/item/organ/spleen
	var/mutantkidneys = /obj/item/organ/kidneys
	var/mutantintestines = /obj/item/organ/intestines
	var/mutantbladder = /obj/item/organ/bladder
	var/examine_icon_state = "human"

/datum/species/New()
	. = ..()
	var/list/genitalia = list(/obj/item/organ/genital/penis,
							/obj/item/organ/genital/testicles,
							/obj/item/organ/genital/anus,
							/obj/item/organ/genital/vagina,
							/obj/item/organ/genital/womb,
							/obj/item/organ/genital/breasts)
	for(var/thing in genitalia)
		var/obj/item/organ/genital/genital = thing
		if(initial(genital.mutantpart_key) && !LAZYACCESS(default_mutant_bodyparts, initial(genital.mutantpart_key)))
			default_mutant_bodyparts[initial(genital.mutantpart_key)] = list(MUTANT_INDEX_NAME = "None", \
																		MUTANT_INDEX_COLOR = "#FFFFFF")

/datum/species/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	// Drop the items the new species can't wear
	if((AGENDER in species_traits))
		C.gender = PLURAL
	for(var/slot_id in no_equip)
		var/obj/item/thing = C.get_item_by_slot(slot_id)
		if(thing && (!thing.species_exception || !is_type_in_list(src,thing.species_exception)))
			C.dropItemToGround(thing)
	if(C.hud_used)
		C.hud_used.update_locked_slots()

	fix_non_native_limbs(C)
	if(type != old_species?.type)
		generate_genital_information(C)

	// this needs to be FIRST because qdel calls update_body which checks if we have DIGITIGRADE legs or not and if not then removes DIGITIGRADE from species_traits
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(FALSE)

	C.mob_biotypes = inherent_biotypes

	regenerate_organs(C, old_species, replace_current = TRUE)

	if(exotic_bloodtype && C.dna.blood_type != exotic_bloodtype)
		C.dna.blood_type = exotic_bloodtype

	if(old_species.mutanthands)
		for(var/obj/item/I in C.held_items)
			if(istype(I, old_species.mutanthands))
				qdel(I)

	if(mutanthands)
		// Drop items in hands
		// If you're lucky enough to have a TRAIT_NODROP item, then it stays.
		for(var/V in C.held_items)
			var/obj/item/I = V
			if(istype(I))
				C.dropItemToGround(I)
			else //Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
				C.put_in_hands(new mutanthands())

	for(var/X in inherent_traits)
		ADD_TRAIT(C, X, SPECIES_TRAIT)

	if(TRAIT_VIRUSIMMUNE in inherent_traits)
		for(var/datum/disease/A in C.diseases)
			A.cure(FALSE)

	if(TRAIT_TOXIMMUNE in inherent_traits)
		C.setToxLoss(0, TRUE, TRUE)

	if(TRAIT_NOMETABOLISM in inherent_traits)
		C.reagents.end_metabolization(C, keep_liverless = TRUE)

	if(TRAIT_GENELESS in inherent_traits)
		C.dna.remove_all_mutations() // Radiation immune mobs can't get mutations normally

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction += i //Using +=/-= for this in case you also gain the faction from a different source.

	if(flying_species && isnull(fly))
		fly = new
		fly.Grant(C)

	for(var/obj/item/bodypart/bodypart in C.bodyparts)
		bodypart.alpha = bodypart_alpha
		if(ROBOTIC_LIMBS in species_traits)
			bodypart.change_bodypart_status(BODYPART_ROBOTIC, FALSE, TRUE)
			bodypart.limb_flags |= BODYPART_SYNTHETIC
			bodypart.advanced_rendering = TRUE
		else if(bodypart.status == BODYPART_ORGANIC)
			bodypart.advanced_rendering = TRUE

	C.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

	if(!(C.status_flags & BUILDING_ORGANS))
		C.update_body()

	SEND_SIGNAL(C, COMSIG_SPECIES_GAIN, src, old_species)

/datum/species/get_biological_state(mob/living/carbon/human/H)
	. = BIO_INORGANIC
	if(HAS_FLESH in species_traits)
		. = BIO_JUST_FLESH
	if(HAS_BONE in species_traits)
		if(. == BIO_JUST_FLESH)
			. = BIO_FLESH_BONE
		else
			. = BIO_JUST_BONE

/datum/species/get_features()
	var/list/features = list()
	for(var/preference_type in GLOB.preference_entries)
		var/datum/preference/preference = GLOB.preference_entries[preference_type]
		if( (preference.relevant_mutant_bodypart in default_mutant_bodyparts) \
			|| (preference.relevant_species_trait in species_traits) )
			features += preference.savefile_key
	GLOB.features_by_species[type] = features
	return features

/datum/species/handle_environment_pressure(mob/living/carbon/human/H, datum/gas_mixture/environment, delta_time, times_fired)
	var/pressure = environment.return_pressure()
	var/adjusted_pressure = H.calculate_affecting_pressure(pressure)

	// Set alerts and apply damage based on the amount of pressure
	switch(adjusted_pressure)
		// Very high pressure, show an alert and take damage
		if(HAZARD_HIGH_PRESSURE to INFINITY)
			if(!HAS_TRAIT(H, TRAIT_RESISTHIGHPRESSURE))
				var/ouchie = min( ((adjusted_pressure/HAZARD_HIGH_PRESSURE) - 1) * PRESSURE_DAMAGE_COEFFICIENT, MAX_HIGH_PRESSURE_DAMAGE) * H.physiology.pressure_mod * delta_time
				H.take_bodypart_damage(ouchie)
				//high pressures will cause ear damage
				for(var/obj/item/organ/ear in H.getorganslotlist(ORGAN_SLOT_EARS))
					ear.applyOrganDamage(ouchie)
				//also pops your lungs
				for(var/obj/item/organ/lung in H.getorganslotlist(ORGAN_SLOT_LUNGS))
					lung.applyOrganDamage(ouchie)
				H.update_hud_pressure(4)
			else
				H.update_hud_pressure(2)

		// High pressure, show an alert
		if(WARNING_HIGH_PRESSURE to HAZARD_HIGH_PRESSURE)
			if(!HAS_TRAIT(H, TRAIT_RESISTHIGHPRESSURE))
				H.update_hud_pressure(3)
			else
				H.update_hud_pressure(2)

		// No pressure issues here clear pressure alerts
		if(WARNING_LOW_PRESSURE to WARNING_HIGH_PRESSURE)
			H.update_hud_pressure(2)

		// Low pressure here, show an alert
		if(HAZARD_LOW_PRESSURE to WARNING_LOW_PRESSURE)
			// We have low pressure resit trait, clear alerts
			if(HAS_TRAIT(H, TRAIT_RESISTLOWPRESSURE))
				H.update_hud_pressure(2)
			else
				H.update_hud_pressure(1)

		// Very low pressure, show an alert and take damage
		else
			// We have low pressure resit trait, clear alerts
			if(HAS_TRAIT(H, TRAIT_RESISTLOWPRESSURE))
				H.update_hud_pressure(2)
			else
				var/ouchie = LOW_PRESSURE_DAMAGE * H.physiology.pressure_mod * delta_time
				H.take_bodypart_damage(ouchie)
				//low pressures will cause ear damage
				for(var/obj/item/organ/ear in H.getorganslotlist(ORGAN_SLOT_EARS))
					ear.applyOrganDamage(ouchie)
				//also pops your lungs
				for(var/obj/item/organ/lung in H.getorganslotlist(ORGAN_SLOT_LUNGS))
					lung.applyOrganDamage(ouchie)
				H.update_hud_pressure(0)

/datum/species/body_temperature_damage(mob/living/carbon/human/humi, delta_time, times_fired)
	// Body temperature is too hot, and we do not have resist traits
	var/is_hulk = HAS_TRAIT(humi, TRAIT_HULK)
	var/cold_damage_limit = bodytemp_cold_damage_limit + (is_hulk ? BODYTEMP_HULK_COLD_DAMAGE_LIMIT_MODIFIER : 0)
	// Apply some burn damage to the body
	if(humi.coretemperature > bodytemp_heat_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTHEAT))
		var/damage_mod = coldmod * humi.physiology.burn_mod * (humi.on_fire ? 2 : 1)
		switch(humi.coretemperature - bodytemp_heat_damage_limit)
			if(0 to 50)
				humi.take_bodypart_damage(burn = HEAT_DAMAGE_LEVEL_1 * damage_mod * delta_time)
			if(50 to 90)
				humi.take_bodypart_damage(burn = HEAT_DAMAGE_LEVEL_2 * damage_mod * delta_time)
			if(90 to INFINITY)
				humi.take_bodypart_damage(burn = HEAT_DAMAGE_LEVEL_3 * damage_mod * delta_time)
	// Apply some burn damage to the body
	if(humi.coretemperature < cold_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTCOLD))
		var/damage_mod = coldmod * humi.physiology.cold_mod * (is_hulk ? HULK_COLD_DAMAGE_MOD : 1)
		switch(cold_damage_limit - humi.coretemperature)
			if(0 to 67)
				humi.take_bodypart_damage(burn = COLD_DAMAGE_LEVEL_1 * damage_mod * delta_time)
			if(67 to 110)
				humi.take_bodypart_damage(burn = COLD_DAMAGE_LEVEL_2 * damage_mod * delta_time)
			if(110 to INFINITY)
				humi.take_bodypart_damage(burn = COLD_DAMAGE_LEVEL_3 * damage_mod * delta_time)

/datum/species/body_temperature_alerts(mob/living/carbon/human/humi)
	// Body temperature is too hot, and we do not have resist traits
	if(humi.bodytemperature > bodytemp_heat_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTHEAT))
		// Clear cold mood and apply hot mood
		SEND_SIGNAL(humi, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(humi, COMSIG_ADD_MOOD_EVENT, "hot", /datum/mood_event/hot)
		// Remove any slowdown from the cold
		humi.remove_movespeed_modifier(/datum/movespeed_modifier/cold)
		// Display alerts based on how hot it is
		switch(humi.bodytemperature)
			if(0 to 460)
				humi.update_hud_bodytemperature(4)
			if(461 to 700)
				humi.update_hud_bodytemperature(5)
			else
				humi.update_hud_bodytemperature(6)
	// Body temperature is too cold, and we do not have resist traits
	else if(humi.bodytemperature < bodytemp_cold_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTCOLD))
		// clear any hot moods and apply cold mood
		SEND_SIGNAL(humi, COMSIG_CLEAR_MOOD_EVENT, "hot")
		SEND_SIGNAL(humi, COMSIG_ADD_MOOD_EVENT, "cold", /datum/mood_event/cold)
		// Apply cold slow down
		humi.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/cold, multiplicative_slowdown = ((bodytemp_cold_damage_limit - humi.bodytemperature) / COLD_SLOWDOWN_FACTOR))
		// Display alerts based how cold it is
		switch(humi.bodytemperature)
			if(201 to bodytemp_cold_damage_limit)
				humi.update_hud_bodytemperature(2)
			if(120 to 200)
				humi.update_hud_bodytemperature(1)
			else
				humi.update_hud_bodytemperature(0)
	// We are not too hot nor cold, remove status and modifiers
	else
		humi.update_hud_bodytemperature(3)
		humi.remove_movespeed_modifier(/datum/movespeed_modifier/cold)
		SEND_SIGNAL(humi, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(humi, COMSIG_CLEAR_MOOD_EVENT, "hot")
	// Handle updating external temperature alerts
	external_temperature_alerts(humi)

/datum/species/proc/external_temperature_alerts(mob/living/carbon/human/humi)
	// Get the enviroment details of where the mob is standing
	var/datum/gas_mixture/environment = humi.loc.return_air()
	if(!environment) // if there is no environment (nullspace) drop out here.
		return

	// Get the temperature of the environment for area
	var/area_temp = humi.get_temperature(environment)
	// External temperature is too hot, and we do not have resist traits
	if(area_temp > bodytemp_heat_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTHEAT))
		// Display alerts based on how hot it is
		switch(area_temp)
			if(0 to 460)
				humi.update_hud_temperature(4)
			if(461 to 700)
				humi.update_hud_temperature(5)
			else
				humi.update_hud_temperature(6)
	// Body temperature is too cold, and we do not have resist traits
	else if(area_temp < bodytemp_cold_damage_limit && !HAS_TRAIT(humi, TRAIT_RESISTCOLD))
		// Display alerts based how cold it is
		switch(area_temp)
			if(201 to bodytemp_cold_damage_limit)
				humi.update_hud_temperature(2)
			if(120 to 200)
				humi.update_hud_temperature(1)
			else
				humi.update_hud_temperature(0)
	// We are not too hot nor cold, remove status and modifiers
	else
		humi.update_hud_temperature(3)

/datum/species/regenerate_organs(mob/living/carbon/C, datum/species/old_species, replace_current = FALSE, list/excluded_zones)
	var/list/slot_mutantorgans = list(ORGAN_SLOT_BRAIN = mutantbrain, ORGAN_SLOT_HEART = mutantheart, \
							ORGAN_SLOT_LUNGS = mutantlungs, \
							ORGAN_SLOT_APPENDIX = mutantappendix, ORGAN_SLOT_EARS = mutantears, \
							ORGAN_SLOT_EYES = mutanteyes, ORGAN_SLOT_TONGUE = mutanttongue, \
							ORGAN_SLOT_LIVER = mutantliver, ORGAN_SLOT_STOMACH = mutantstomach, \
							ORGAN_SLOT_SPLEEN = mutantspleen, ORGAN_SLOT_KIDNEYS = mutantkidneys, \
							ORGAN_SLOT_INTESTINES = mutantintestines, ORGAN_SLOT_BLADDER = mutantbladder)
	// this is pure dumb code but just, bear with me
	for(var/slot in slot_mutantorgans)
		var/list/oldorgans = list()
		oldorgans |= C.getorganslotlist(slot)
		var/obj/item/organ/neworgan = slot_mutantorgans[slot]//used in adding
		var/used_neworgan = FALSE
		neworgan = new neworgan()
		var/should_have = neworgan.get_availability(src) //organ proc that points back to a species trait (so if the species is supposed to have this organ)

		var/mutant_part = FALSE
		for(var/thing in oldorgans)
			var/obj/item/organ/oldorgan = thing
			//Motherfucker! Deal with this in the mutant part code block instead
			if(oldorgan.mutantpart_key)
				mutant_part = TRUE
				break
			if((!should_have || replace_current) && !(oldorgan.zone in excluded_zones) && !(oldorgan.organ_flags & ORGAN_UNREMOVABLE))
				if(slot == ORGAN_SLOT_BRAIN)
					var/obj/item/organ/brain/brain = oldorgan
					if(!brain.decoy_override) //"Just keep it if it's fake" - confucius, probably
						brain.before_organ_replacement(neworgan)
						brain.Remove(C, TRUE, TRUE) //brain argument used so it doesn't cause any... sudden death.
						oldorgans -= brain
						qdel(brain)
				else
					oldorgan.before_organ_replacement(neworgan)
					oldorgan.Remove(C, TRUE)
					oldorgans -= oldorgan
					qdel(oldorgan)
		//Again, deal with this in the mutant part code block instead
		if(mutant_part)
			continue

		if(LAZYLEN(oldorgans))
			for(var/thing in oldorgans)
				var/obj/item/organ/oldorgan = thing
				oldorgan.setOrganDamage(0)
			if((slot in PAIRED_ORGAN_SLOTS) && (LAZYLEN(oldorgans) < 2))
				var/side = LEFT_SIDE
				for(var/thinge in oldorgans)
					var/obj/item/organ/oldorgan = thinge
					if(oldorgan.side == LEFT_SIDE)
						side = RIGHT_SIDE
						break
				used_neworgan = TRUE
				neworgan.switch_side(side)
				neworgan.Insert(C, TRUE, FALSE)
		else if(should_have && !(initial(neworgan.zone) in excluded_zones))
			used_neworgan = TRUE
			neworgan.Insert(C, TRUE, FALSE)
			// this is dumb
			if(slot in PAIRED_ORGAN_SLOTS)
				neworgan = new neworgan.type()
				neworgan.switch_side(LEFT_SIDE)
				neworgan.Insert(C, TRUE, FALSE)
		if(!used_neworgan)
			qdel(neworgan)
	if(old_species)
		for(var/mutantorgan in old_species.mutant_organs)
			// Snowflake check - If our species share this mutant organ, let's not remove it
			// just yet as we'll be properly replacing it later
			if(mutantorgan in mutant_organs)
				continue
			for(var/obj/item/organ/killme in C.getorganlist(mutantorgan))
				killme.Remove(C, TRUE)
				qdel(killme)
	for(var/organ_path in mutant_organs)
		var/obj/item/organ/current_organ = C.getorgan(organ_path)
		if(!current_organ || replace_current)
			var/obj/item/organ/replacement = new organ_path()
			// If there's an existing mutant organ, we're technically replacing it.
			// Let's abuse the snowflake proc that skillchips added. Basically retains
			// feature parity with every other organ too.
			if(current_organ)
				current_organ.before_organ_replacement(replacement)
				current_organ.Remove(C, TRUE)
				qdel(current_organ)
			// organ.Insert will qdel any current organs in that slot, so we don't need to.
			replacement.Insert(C, TRUE, FALSE)
	// Handle mutant organ shit
	var/robot_organs = (ROBOTIC_ORGANS in C.dna.species.species_traits)
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/sprite_accessory = LAZYACCESSASSOC(GLOB.sprite_accessories, key, LAZYACCESSASSOC(C.dna.species.mutant_bodyparts, key, MUTANT_INDEX_NAME))
		if(!sprite_accessory?.factual || !sprite_accessory.organ_type)
			continue
		var/obj/item/organ/organ = new sprite_accessory.organ_type()
		//this needs to be done before the other organs are removed due to reasons i guess
		organ.build_from_dna(C.dna, key)
		if(robot_organs)
			organ.status = ORGAN_ROBOTIC
			organ.organ_flags |= ORGAN_SYNTHETIC
		if(replace_current)
			var/list/old_organs = C.getorganslotlist(LAZYACCESS(organ.organ_efficiency, 1))
			for(var/thing in old_organs)
				var/obj/item/organ/oldorgan = thing
				oldorgan.Remove(C, TRUE)
				qdel(oldorgan)
		organ.Insert(C, TRUE, FALSE)
		if(LAZYACCESS(organ.organ_efficiency, 1) in PAIRED_ORGAN_SLOTS)
			organ = new sprite_accessory.organ_type()
			if(robot_organs)
				organ.status = ORGAN_ROBOTIC
				organ.organ_flags |= ORGAN_SYNTHETIC
			organ.build_from_dna(C.dna, key)
			organ.Insert(C, TRUE, FALSE)
	//I have NO CLUE what causes this
	//I *shouldn't* have to have a clue what causes this
	//But i have to do this dumb shit to avoid people having "organs"
	for(var/wtf in C.internal_organs)
		var/obj/item/organ/why = wtf
		if(!LAZYLEN(why.organ_efficiency))
			why.Remove(C, FALSE)
			qdel(why)

/// Removes any non-native limbs from the mob
/datum/species/fix_non_native_limbs(mob/living/carbon/human/owner)
	for(var/X in owner.bodyparts)
		var/obj/item/bodypart/current_part = X
		var/obj/item/bodypart/species_part = bodypart_overides[current_part.body_zone]
		if(current_part.type == species_part)
			continue
		current_part.change_bodypart(species_part)
	if(ROBOTIC_LIMBS in species_traits)
		for(var/thing in owner.bodyparts)
			var/obj/item/bodypart/bodypart = thing
			bodypart.change_bodypart_status(BODYPART_ORGANIC)
			bodypart.limb_flags |= BODYPART_SYNTHETIC
			bodypart.advanced_rendering = TRUE
	for(var/thing in owner.bodyparts)
		var/obj/item/bodypart/bodypart = thing
		bodypart.update_limb()
	return TRUE

/// Generates genital info - Should be done before a regenerate_organs call
/datum/species/proc/generate_genital_information(mob/living/carbon/human/owner)
	var/list/genitalia = list(/obj/item/organ/genital/penis,
							/obj/item/organ/genital/testicles,
							/obj/item/organ/genital/anus,
							/obj/item/organ/genital/vagina,
							/obj/item/organ/genital/womb,
							/obj/item/organ/genital/breasts)
	for(var/thing in genitalia)
		var/obj/item/organ/genital/genital = thing
		if(initial(genital.mutantpart_key) && LAZYACCESS(default_mutant_bodyparts, initial(genital.mutantpart_key)))
			owner.dna.mutant_bodyparts[initial(genital.mutantpart_key)] = default_mutant_bodyparts[initial(genital.mutantpart_key)]
			mutant_bodyparts[initial(genital.mutantpart_key)] = default_mutant_bodyparts[initial(genital.mutantpart_key)]
	owner.dna.features["uses_skintones"] = use_skintones
	owner.dna.features["breasts_size"] = rand(BREASTS_MIN_SIZE, BREASTS_MAX_SIZE)
	owner.dna.features["breasts_lactation"] = BREASTS_DEFAULT_LACTATION
	owner.dna.features["penis_size"] = rand(PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
	owner.dna.features["penis_girth"] = rand(PENIS_MIN_GIRTH, PENIS_MAX_GIRTH)
	owner.dna.features["balls_size"] = rand(BALLS_MIN_SIZE, BALLS_MAX_SIZE)
	for(var/genital_slot in LAZYACCESS(GLOB.genital_sets, owner.genitals))
		var/genital_type = default_genitals[genital_slot]
		if(!genital_type)
			continue
		var/obj/item/organ/genital/genital = new genital_type()
		if(!LAZYLEN(genital.mutantpart_info))
			qdel(genital)
			continue
		if(!use_skintones && LAZYACCESS(genital.mutantpart_info, MUTANT_INDEX_COLOR))
			genital.mutantpart_info[MUTANT_INDEX_COLOR] = list(
				sanitize_hexcolor(owner.dna.features["mcolor"], 6, TRUE), \
				sanitize_hexcolor(owner.dna.features["mcolor2"], 6, TRUE), \
				sanitize_hexcolor(owner.dna.features["mcolor3"], 6, TRUE), \
			)
		mutant_bodyparts[genital.mutantpart_key] = genital.mutantpart_info.Copy()
		owner.dna.mutant_bodyparts[genital.mutantpart_key] = genital.mutantpart_info.Copy()
		if(istype(genital, /obj/item/organ/genital/penis))
			var/obj/item/organ/genital/penis/penis = genital
			owner.dna.features["penis_sheath"] = penis.genital_sheath
		qdel(genital)
	return TRUE

/datum/species/proc/breathe(mob/living/carbon/human/H, delta_time, times_fired, datum/organ_process/lung_process)
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		return TRUE

/datum/species/proc/get_pain_emote(power)
	if(NOPAIN in species_traits)
		return
	if(power < PAIN_EMOTE_MINIMUM)
		return
	power = FLOOR(min(100, power), 10)
	var/emote_string
	emote_string = LAZYACCESS(pain_emote_by_power, "[power]")
	return emote_string

/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return
