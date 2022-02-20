/datum/component/storage/proc/screen_loc_to_tetris_coordinates(screen_loc = "")
	if(!tetris)
		return FALSE
	var/screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
	var/screen_x_pixels = FLOOR((screen_x * world.icon_size) + screen_pixel_x, 1) - FLOOR((src.screen_start_x * world.icon_size) + src.screen_pixel_x, 1)
	var/screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
	var/screen_y_pixels = FLOOR((screen_y * world.icon_size) + screen_pixel_y, 1) - FLOOR(((src.screen_start_y - src.screen_max_rows + 1) * world.icon_size) + src.screen_pixel_y, 1)
	return "[FLOOR(screen_x_pixels/tetris_box_size, 1)],[FLOOR(screen_y_pixels/tetris_box_size, 1)]"

/datum/component/storage/proc/tetris_coordinates_to_screen_loc(coordinates = "")
	if(!tetris)
		return FALSE
	var/tetris_box_ratio = (world.icon_size/tetris_box_size)
	var/screen_x = copytext(coordinates, 1, findtext(coordinates, ","))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
	var/screen_pixel_x = FLOOR(world.icon_size * ((screen_x/tetris_box_ratio) - FLOOR(screen_x/tetris_box_ratio, 1)), 1)
	screen_x = FLOOR(screen_x/tetris_box_ratio, 1)
	var/screen_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
	var/screen_pixel_y = FLOOR(world.icon_size * ((screen_y/tetris_box_ratio) - FLOOR(screen_y/tetris_box_ratio, 1)), 1)
	screen_y = FLOOR(screen_y/tetris_box_ratio, 1)
	return "[src.screen_start_x+screen_x]:[src.screen_pixel_x+screen_pixel_x],[(src.screen_start_y-screen_max_rows+1)+screen_y]:[src.screen_pixel_y+screen_pixel_y]"

/datum/component/storage/proc/validate_tetris_coordinates(coordinates = "", tetris_width = 1, tetris_height = 1)
	if(!tetris)
		return FALSE
	var/tetris_box_ratio = (world.icon_size/tetris_box_size)
	var/screen_x = copytext(coordinates, 1, findtext(coordinates, ","))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
	var/screen_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
	var/validate_x = (tetris_width/tetris_box_size)-1
	var/validate_y = (tetris_height/tetris_box_size)-1
	var/final_x = 0
	var/final_y = 0
	var/final_coordinates = ""
	//this loops through all possible cells in the inventory box that we could overlap when given this screen_x and screen_y
	//and returns false on any failure
	for(var/current_x in 0 to validate_y)
		for(var/current_y in 0 to validate_x)
			final_x = screen_x+current_x
			final_y = screen_y+current_y
			final_coordinates = "[final_x],[final_y]"
			if(final_x > ((screen_max_columns*tetris_box_ratio)-1))
				testing("validate_tetris_coordinates FAILED, final_x > (screen_max_columns-1), final_coordinates: ([final_coordinates])")
				return FALSE
			if(final_y > ((screen_max_rows*tetris_box_ratio)-1))
				testing("validate_tetris_coordinates FAILED, final_y > (screen_max_rows-1), final_coordinates: ([final_coordinates])")
				return FALSE
			if(LAZYACCESS(tetris_coordinates_to_item, final_coordinates))
				testing("validate_tetris_coordinates FAILED, coordinates already occupied, final_coordinates: ([final_coordinates])")
				return FALSE
	return TRUE
