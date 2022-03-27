/atom/movable/frill_blocker
	name = "frill blocker"
	icon = 'modular_septic/icons/effects/blockers.dmi'
	icon_state = "blocker"
	plane = FRILL_BLOCKER_PLANE
	layer = 0
	vis_flags = VIS_INHERIT_DIR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/invert_icon = TRUE

/atom/movable/frill_blocker/Initialize(mapload)
	. = ..()
	var/icon/final_icon = icon(icon, icon_state)
	var/width = final_icon.Width()
	var/height = final_icon.Height()
	var/image/blocker_overlay = image(icon = src.icon, icon_state = src.icon_state, loc = src)
	blocker_overlay.plane = plane
	blocker_overlay.pixel_x = -width/2 + world.icon_size/2
	blocker_overlay.pixel_y = -height/2
	add_overlay(blocker_overlay)
	icon = null
	icon_state = null
