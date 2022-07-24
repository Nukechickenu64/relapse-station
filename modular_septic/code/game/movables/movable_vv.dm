/atom/movable/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_EDIT_PARTICLES, "Edit Particles")

/atom/movable/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_EDIT_PARTICLES] && check_rights(R_VAREDIT))
		usr.client?.open_particle_editor(src)
