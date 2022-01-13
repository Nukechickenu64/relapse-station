/obj/item/modular_computer/tablet
	icon = 'modular_septic/icons/obj/items/modular_tablet.dmi'
	light_system = MOVABLE_LIGHT_DIRECTIONAL

/obj/item/modular_computer/tablet/set_flashlight_color(color)
	if(!has_light || !color)
		return FALSE
	comp_light_color = color
	set_light_color(color)
	return TRUE
