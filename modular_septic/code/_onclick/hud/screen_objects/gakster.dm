/atom/movable/screen/fullscreen/gakster
	name = "wake up"
	icon = 'modular_septic/icons/hall/gakster2.dmi'
	icon_state = "hall0"
	alpha = 0
	var/mutable_appearance/black_underlay

/atom/movable/screen/fullscreen/gakster/Initialize()
	. = ..()
	black_underlay = mutable_appearance(icon, "black", layer-0.1, plane, color)

/atom/movable/screen/fullscreen/gakster/update_for_view(client_view)
	if(screen_loc == "CENTER-7,CENTER-7" && view != client_view && black_underlay)
		var/list/actualview = getviewsize(client_view)
		view = client_view
		black_underlay.transform = matrix(actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)
	update_overlays()

/atom/movable/screen/fullscreen/gakster/update_overlays()
	. = ..()
	underlays -= black_underlay
	if(black_underlay)
		underlays += black_underlay
