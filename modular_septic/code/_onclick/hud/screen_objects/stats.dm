/atom/movable/screen/stats
	name = "stats"
	icon = 'modular_septic/icons/hud/quake/screen_quake_32x64.dmi'
	icon_state = "stats"
	screen_loc = ui_stats
	screentip_flags = SCREENTIP_HOVERER
	var/static/overlay_x = 0
	var/static/overlay_y = 0
	var/static/list/stat_to_y_offset = list(STAT_INTELLIGENCE = 0,
											STAT_ENDURANCE = 10,
											STAT_DEXTERITY = 20,
											STAT_STRENGTH = 30,
											) //This is dumb. Stat's path = stat's offset.
	var/list/stat_to_value = list(STAT_INTELLIGENCE = "00",
								  STAT_ENDURANCE = "00",
								  STAT_DEXTERITY = "00",
								  STAT_STRENGTH = "00",
								  ) //Stat's path to it's value - easier than getting it always
	var/list/list/stat_to_number_overlays = list()
	var/list/image/numbers = list()

/atom/movable/screen/stats/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		usr.attributes?.ui_interact(usr)
	else
		usr.attributes?.print_stats(usr)

/atom/movable/screen/stats/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	switch(icon_y)
		if(0 to 18)
			return SCREENTIP_OBJ("WILLPOWER")
		if(19 to 28)
			return SCREENTIP_OBJ("INTELLIGENCE")
		if(29 to 38)
			return SCREENTIP_OBJ("ENDURANCE")
		if(39 to 48)
			return SCREENTIP_OBJ("DEXTERITY")
		if(49 to 59)
			return SCREENTIP_OBJ("STRENGTH")
	return SCREENTIP_OBJ(uppertext(name))

/atom/movable/screen/stats/update_overlays()
	. = ..()
	. |= numbers

/atom/movable/screen/stats/Initialize(mapload)
	. = ..()
	regen_overlays()
	update_appearance()

/atom/movable/screen/stats/proc/update_stats()
	if(!hud?.mymob?.attributes)
		return FALSE
	for(var/stat_path in stat_to_value)
		stat_to_value[stat_path] = stat_number_to_string(GET_MOB_ATTRIBUTE_VALUE(hud.mymob, stat_path))
	regen_overlays()
	update_appearance()

/atom/movable/screen/stats/proc/regen_overlays()
	cut_overlays()
	QDEL_LIST(numbers)
	numbers = list()
	for(var/stat in stat_to_value)
		var/y_off = stat_to_y_offset[stat]
		var/left = copytext(stat_to_value[stat], 1, 2)
		var/right = copytext(stat_to_value[stat], 2)
		var/image/a = image(icon, src, "a[left]")
		var/image/b = image(icon, src, "b[right]")
		a.pixel_x = b.pixel_x = overlay_x
		a.pixel_y = b.pixel_y = overlay_y + y_off
		stat_to_number_overlays[stat] = list(a, b)
		numbers |= stat_to_number_overlays[stat]

	if(length(numbers))
		return numbers

/atom/movable/screen/stats/proc/stat_number_to_string(value)
	. = "[value]"
	if(length(.) < 2)
		. = "0[.]"
