/// This component changes the footstep sound of whatever turf parent is on
/datum/component/footstep_changer
	/// Sound we should change the turf's footstep to
	var/footstep_sound
	/// Old footstep sound of the open turf we entered
	var/old_sound
	/// Connect_loc_behalf component required for this to work
	var/datum/component/connect_loc_behalf/connect_loc_behalf

/datum/component/footstep_changer/Initialize(footstep_sound)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	src.footstep_sound = footstep_sound
	on_entered(get_turf(parent), parent)

/datum/component/footstep_changer/RegisterWithParent()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	connect_loc_behalf = AddComponent(/datum/component/connect_loc_behalf, parent, loc_connections)

/datum/component/footstep_changer/UnregisterFromParent()
	. = ..()
	QDEL_NULL(connect_loc_behalf)

/datum/component/footstep_changer/proc/on_entered(turf/open/source, atom/movable/arrived, turf/open/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(!istype(source))
		return

	if(old_sound && istype(old_loc))
		old_loc.footstep = old_sound
	old_sound = source.footstep
	source.footstep = footstep_sound
