/**
  * Attached to smoothing atoms. Adds a globally-cached object to their vis_contents and updates based on junction changes.
  ** ATTENTION: This element was supposed to be for atoms, but since only movables and turfs actually have vis_contents hacks have to be done.
  ** For now it treats all of its targets as turfs, but that will runtime if an invalid variable access happens.
  ** Yes, this is ugly. The alternative is making two different elements for the same purpose.
  */
/datum/element/frill
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	var/icon_path

/datum/element/frill/Attach(atom/target, icon_path)
	if(!istype(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon_path = icon_path
	on_junction_change(target, target.smoothing_junction)
	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_junction_change)

/datum/element/frill/Detach(atom/target)
	. = ..()
	target.cut_overlay(get_frill_appearance(icon_path, target.smoothing_junction, pixel_y = 32))
	target.cut_overlay(get_frill_appearance(icon_path, target.smoothing_junction, plane = GAME_PLANE, pixel_y = 32))
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)

/datum/element/frill/proc/on_junction_change(atom/source, new_junction)
	SIGNAL_HANDLER
	var/turf/turf_or_movable = source
	if(!(source.smoothing_junction & NORTH))
		turf_or_movable.cut_overlay(get_frill_appearance(icon_path, source.smoothing_junction, pixel_y = 32))
	else
		turf_or_movable.cut_overlay(get_frill_appearance(icon_path, source.smoothing_junction, plane = GAME_PLANE, pixel_y = 32))

	if(!(new_junction & NORTH))
		turf_or_movable.add_overlay(get_frill_appearance(icon_path, new_junction, pixel_y = 32))
	else
		turf_or_movable.add_overlay(get_frill_appearance(icon_path, new_junction, plane = GAME_PLANE, pixel_y = 32))
