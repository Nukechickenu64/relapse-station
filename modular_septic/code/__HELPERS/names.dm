/command_name()
	if (GLOB.command_name)
		return GLOB.command_name

	var/name = "ZoomTech Board of Directors"

	GLOB.command_name = name
	return name
