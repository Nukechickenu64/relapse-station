/**
  * Attached to smoothing atoms. Adds a globally-cached object to their vis_contents and updates based on junction changes.
  */
/datum/element/frill
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	var/icon_path
	var/plane

/datum/element/frill/Attach(atom/target, icon_path, plane = ABOVE_FRILL_PLANE)
	if(!isturf(target) && !ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon_path = icon_path
	src.plane = plane
	on_junction_change(target, target.smoothing_junction)
	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_junction_change)

/datum/element/frill/Detach(atom/target)
	. = ..()
	target.cut_overlay(get_frill_appearance(icon_path, target.smoothing_junction, pixel_y = 32))
	target.cut_overlay(get_frill_appearance(icon_path, target.smoothing_junction, plane = target.plane, pixel_y = 32))
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)

/datum/element/frill/proc/on_junction_change(atom/source, new_junction)
	SIGNAL_HANDLER

	if(!(source.smoothing_junction & NORTH))
		source.cut_overlay(get_frill_appearance(icon_path, source.smoothing_junction, plane = src.plane, pixel_y = 32))
	else
		source.cut_overlay(get_frill_appearance(icon_path, source.smoothing_junction, plane = source.plane, pixel_y = 32))

	if(!(new_junction & NORTH))
		source.add_overlay(get_frill_appearance(icon_path, new_junction, plane = src.plane, pixel_y = 32))
	else
		source.add_overlay(get_frill_appearance(icon_path, new_junction, plane = source.plane, pixel_y = 32))
