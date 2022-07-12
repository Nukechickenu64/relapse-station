//cybergrid holder
/atom/movable/screen/fullscreen/cybergrid
	icon = 'modular_septic/icons/hud/cybergrid.dmi'
	icon_state = "cybergrid"
	screen_loc = "CENTER-7,CENTER-7"
	plane = CYBERGRID_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = KEEP_TOGETHER
	show_when_dead = TRUE
	alpha = 64
	var/speed = 1
	var/offset_x = 0
	var/offset_y = 0
	var/view_sized

/atom/movable/screen/fullscreen/cybergrid/Initialize(mapload)
	. = ..()
	speed = world.icon_size

/atom/movable/screen/fullscreen/cybergrid/update_for_view(client_view)
	if(!client_view)
		client_view = world.view

	var/list/viewscales = getviewsize(client_view)
	var/countx = CEILING((viewscales[1]/2)/(480/world.icon_size), 1)+1
	var/county = CEILING((viewscales[2]/2)/(480/world.icon_size), 1)+1
	var/list/new_overlays = list()
	for(var/x in -countx to countx)
		for(var/y in -county to county)
			if(x == 0 && y == 0)
				continue
			var/mutable_appearance/texture_overlay = mutable_appearance(icon, icon_state)
			texture_overlay.transform = matrix(1, 0, x*480, 0, 1, y*480)
			new_overlays += texture_overlay
	cut_overlays()
	add_overlay(new_overlays)
	view_sized = view
