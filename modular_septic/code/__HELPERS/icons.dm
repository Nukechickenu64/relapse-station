/proc/image2html(thing, target, width = 32, height = 32, format = "png", sourceonly = FALSE, extra_classes = null)
	if(!target)
		return
	if(!thing)
		return
	if(SSlag_switch.measures[DISABLE_USR_ICON2HTML] && usr && !HAS_TRAIT(usr, TRAIT_BYPASS_MEASURES))
		return

	if(target == world)
		target = GLOB.clients

	var/list/targets
	if(!islist(target))
		targets = list(target)
	else
		targets = target
		if (!targets.len)
			return

	if(!isfile(thing)) //special snowflake
		return
	var/name = SANITIZE_FILENAME("[generate_asset_name(thing)].[format]")
	if(!SSassets.cache[name])
		SSassets.transport.register_asset(name, thing)
	for(var/thing2 in targets)
		SSassets.transport.send_assets(thing2, name)
	if(sourceonly)
		return SSassets.transport.get_asset_url(name)
	return "<img class='[extra_classes]' src='[SSassets.transport.get_asset_url(name)]'>"
