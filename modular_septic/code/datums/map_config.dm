/datum/map_config
	/// Surface z levels that spawn ruins
	var/surface_ruin_levels = 0
	/// Surface z levels that don't spawn ruins
	var/surface_empty_levels = 0
	/// Cave z levels that spawn ruins
	var/cave_ruin_levels = 0
	/// Cave z levels that don't spawn ruins
	var/cave_empty_levels = 0
	/// Short text box explaining the lore for the currnet map
	var/map_lore = "FUCK!"
	/// Alternative command name for this map only
	var/command_name = "ZoomTech Board Of Directors"

/datum/map_config/LoadConfig(filename, error_if_missing)
	. = ..()
	if(!.)
		return
	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	if("map_lore" in json)
		map_lore = json["map_lore"]

	if("command_name" in json)
		command_name = json["command_name"]
		change_command_name(command_name)

	if("surface_ruin_levels" in json)
		map_lore = json["surface_ruin_levels"]

	if("surface_empty_levels" in json)
		map_lore = json["surface_empty_levels"]

	if("cave_ruin_levels" in json)
		map_lore = json["cave_ruin_levels"]

	if("cave_empty_levels" in json)
		map_lore = json["cave_empty_levels"]
