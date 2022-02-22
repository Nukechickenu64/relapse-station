/atom/movable/screen/close
	icon = 'modular_septic/icons/hud/quake/storage.dmi'
	icon_state = "close"

/atom/movable/screen/close/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		var/datum/component/storage/storage_master = master
		if(!istype(storage_master))
			return
		storage_master.screen_start_x = initial(storage_master.screen_start_x)
		storage_master.screen_pixel_x = initial(storage_master.screen_pixel_x)
		storage_master.screen_start_y = initial(storage_master.screen_start_y)
		storage_master.screen_pixel_y = initial(storage_master.screen_pixel_y)
		storage_master.orient2hud()
		storage_master.show_to(usr)
		testing("storage screen variables reset [screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]")

/atom/movable/screen/close/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	var/datum/component/storage/storage_master = master
	if(!istype(storage_master))
		return
	storage_master = storage_master.master()
	var/list/modifiers = params2list(params)
	var/maximum_x_pixels = (20 - (storage_master.screen_max_columns) + 1) * world.icon_size
	var/minimum_x_pixels = 0
	var/maximum_y_pixels = 16 * world.icon_size
	var/minimum_y_pixels = (16 - storage_master.screen_max_rows) * world.icon_size

	var/screen_loc = LAZYACCESS(modifiers, SCREEN_LOC)
	testing("storage close button MouseDrag() screen_loc: ([screen_loc])")

	var/screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))

	var/screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))

	var/screen_x_pixels = clamp((screen_x * world.icon_size) + screen_pixel_x, minimum_x_pixels, maximum_x_pixels)
	var/screen_y_pixels = clamp(((screen_y-1) * world.icon_size) + screen_pixel_y, minimum_y_pixels, maximum_y_pixels)

	screen_x = FLOOR(screen_x_pixels/world.icon_size, 1)
	screen_pixel_x = FLOOR((screen_x_pixels/world.icon_size - FLOOR(screen_x_pixels/world.icon_size, 1)) * world.icon_size, 1)
	screen_y = FLOOR(screen_y_pixels/world.icon_size, 1)
	screen_pixel_y = FLOOR((screen_y_pixels/world.icon_size - FLOOR(screen_y_pixels/world.icon_size, 1)) * world.icon_size, 1)

	storage_master.screen_start_x = screen_x
	storage_master.screen_pixel_x = screen_pixel_x
	storage_master.screen_start_y = screen_y
	storage_master.screen_pixel_y = screen_pixel_y
	storage_master.orient2hud()
	testing("[screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]")

/atom/movable/screen/storage
	icon = 'modular_septic/icons/hud/quake/storage.dmi'
	icon_state = "background"
	alpha = 128
