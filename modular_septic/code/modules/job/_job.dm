/datum/job
	/// Stat sheet this job uses, if any
	var/attribute_sheet
	/// Minimum cock size for this role (cm)
	var/min_dicksize = 10
	/// Maximum cock size for this role (cm)
	var/max_dicksize = 15
	/// Whether or not this job has a circumcised penis
	var/penis_circumcised = FALSE
	/// Minimum breast size for this role (gets converted to cup size)
	var/min_breastsize = 1
	/// Maximum breast size for this role (gets converted to cup size)
	var/max_breastsize = 3
	/// Whether or not this job has lactating breasts
	var/breasts_lactating = FALSE
	/// With this set to TRUE, the loadout will be applied before a job clothing will be
	var/no_dresscode = FALSE
	/// Whether the job can use the loadout system
	var/loadout_enabled = TRUE
	/// List of banned quirks in their names(dont blame me, that's how they're stored), players can't join as the job if they have the quirk. Associative for the purposes of performance
	var/list/banned_quirks
	/// A list of slots that can't have loadout items assigned to them if no_dresscode is applied, used for important items such as ID, PDA, backpack and headset
	var/list/blacklist_dresscode_slots
	/// Whitelist of allowed species for this job. If not specified then all roundstart races can be used. Associative with TRUE
	var/list/species_whitelist
	/// Blacklist of species for this job.
	var/list/species_blacklist
	/// Which languages does the job require, associative to LANGUAGE_UNDERSTOOD or LANGUAGE_SPOKEN
	var/list/required_languages = list(/datum/language/common = LANGUAGE_UNDERSTOOD)

/datum/job/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(spawned.attributes)
		assign_attributes(spawned, player_client)
	if(ishuman(spawned))
		assign_genitalia(spawned, player_client)
		//lemun
		if(player_client?.ckey == "ltkoepple")
			spawned.put_in_hands(new /obj/item/food/grown/citrus/lemon(spawned.drop_location()), FALSE)
		//chipraps plushie
		if(spawned.ckey == "chrapacz2000")
			spawned.put_in_hands(new /obj/item/toy/plush/chipraps(spawned.drop_location()), FALSE)

/datum/job/get_roundstart_spawn_point()
	if(random_spawns_possible)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_LATE_ARRIVALS))
			return get_latejoin_spawn_point()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_RANDOM_ARRIVALS))
			return get_safe_random_station_turf(typesof(/area/hallway)) || get_latejoin_spawn_point()
	if(length(GLOB.jobspawn_overrides[title]))
		return pick(GLOB.jobspawn_overrides[title])
	var/obj/effect/landmark/start/spawn_point = get_default_roundstart_spawn_point()
	if(!spawn_point) //if there isn't a spawnpoint send them to latejoin, if there's no latejoin go yell at your mapper
		return get_latejoin_spawn_point()
	return spawn_point

/datum/job/get_default_roundstart_spawn_point()
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name != title)
			continue
		if(spawn_point.used)
			continue
		. = spawn_point
		spawn_point.used = TRUE
		break
	if(!.)
		log_world("Couldn't find a non-generic round start spawn point for [title]")
		for(var/obj/effect/landmark/start/generic/generic_spawn_spoint in GLOB.start_landmarks_list)
			if(generic_spawn_spoint.used)
				continue
			. = generic_spawn_spoint
			generic_spawn_spoint.used = TRUE
			break

/datum/job/proc/assign_genitalia(mob/living/carbon/human/spawned, client/player_client)
	if(!LAZYLEN(spawned.dna?.features))
		return
	spawned.dna.features["penis_size"] = clamp(rand(min_dicksize, max_dicksize), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
	spawned.dna.features["penis_girth"] = clamp(spawned.dna.features["penis_size"] - 3, PENIS_MIN_GIRTH, PENIS_MAX_GIRTH)
	spawned.dna.features["breasts_size"] = clamp(rand(min_breastsize, max_breastsize), BREASTS_MIN_SIZE, BREASTS_MAX_SIZE)
	spawned.dna.features["breasts_lactation"] = breasts_lactating
	spawned.dna.features["penis_circumcised"] = penis_circumcised
	for(var/obj/item/organ/genital/genital in spawned.internal_organs)
		genital.build_from_dna(spawned.dna, genital.mutantpart_key)

/datum/job/proc/assign_attributes(mob/living/spawned, client/player_client)
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/spawned_human = spawned
	if(attribute_sheet)
		spawned_human.attributes?.add_sheet(attribute_sheet)
	var/datum/preferences/prefs = player_client?.prefs
	if(prefs?.birthsign)
		var/datum/cultural_info/birthsign = GLOB.culture_birthsigns[prefs.birthsign]
		if(birthsign)
			birthsign.apply(spawned_human)
	//Woman moment
	if(spawned_human.genitals == GENITALS_FEMALE)
		spawned_human.attributes.add_sheet(/datum/attribute_holder/sheet/woman_moment)

/datum/job/proc/has_banned_quirks(datum/preferences/pref)
	if(!pref) //No preferences? We'll let you pass, this time (just a precautionary check, you dont wanna mess up gamemode setting logic)
		return FALSE
	if(banned_quirks)
		for(var/quirk in pref.all_quirks)
			if(banned_quirks[quirk])
				return TRUE
	return FALSE

/datum/job/proc/is_banned_species(datum/preferences/pref)
	var/my_species = pref.read_preference(/datum/preference/choiced/species)
	var/datum/species/initial_species = my_species
	var/my_id = initial(initial_species.id)
	if(species_whitelist && !species_whitelist.Find(my_id))
		return TRUE
	var/list/selectable_species = get_selectable_species()
	if(!selectable_species.Find(my_id))
		return TRUE
	if(species_blacklist?.Find(my_id))
		return TRUE
	return FALSE

/datum/job/proc/lacks_required_languages(datum/preferences/pref)
	if(!required_languages)
		return FALSE
	for(var/required_language in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if(required_languages[required_language] > pref.languages[required_language])
			return TRUE
	return FALSE
