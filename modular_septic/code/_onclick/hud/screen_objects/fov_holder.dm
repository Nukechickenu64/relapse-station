/**
  * The shadow cone's mask and visual images holder which can't locate inside the mob,
  * lest they inherit the mob opacity and cause a lot of hindrance
  */
/atom/movable/screen/fov_holder
	name = "field of vision holder"
	icon = 'modular_septic/icons/hud/fov_15x15.dmi'
	screen_loc = ui_fov
	plane = FIELD_OF_VISION_MASK_PLANE

/// Last but not least, these shouldn't be deleted by anything but the component itself
/atom/movable/screen/fov_holder/Destroy(force = FALSE)
	if(!force)
		return QDEL_HINT_LETMELIVE
	return ..()
