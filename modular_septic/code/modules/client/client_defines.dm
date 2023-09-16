/client
	show_popup_menus = FALSE
	/// Last particle editor we opened if we happen to be an admin fucking around
	var/datum/particles_editor/particool
	/// Last matrix editor we opened if we happen to be an admin fucking around
	var/datum/matrix_editor/nobody_wants_to_learn_matrix_math
	/// Last attribute editor we opened if we happen to be an admin fucking around
	var/datum/attribute_editor/attribute_editor
	/// Political compass datum, by far one of the stupidest features ever coded by me
	var/datum/political_compass/political_compass
	/// Defaults the country to niger i think that is funny
	var/country = DEFAULT_CLIENT_COUNTRY
	/// Used by the area music system to avoid repeating tracks
	var/last_droning_sound
	/// Current ambient track
	var/sound/droning_sound
