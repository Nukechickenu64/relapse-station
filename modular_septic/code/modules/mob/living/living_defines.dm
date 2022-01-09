/mob/living
	// Every living mob should have an attribute holder
	attributes = /datum/attribute_holder
	/// Chem effects
	var/list/chem_effects
	/// Intents, selected zones and throw mode are also saved on a hand by hand basis
	var/list/hand_index_to_intent
	var/list/hand_index_to_zone
	var/list/hand_index_to_throw
	/// Sprinting, fixeye, stamina, etc
	var/combat_flags = NONE
	/// Does it have FoV?
	var/has_field_of_vision = FALSE
	/// How many eyes does this mob have by default. This shouldn't change at runtime.
	var/default_num_eyes = 2
	/// How many eyes does this mob currently have. Should only be changed through set_num_eyes()
	var/num_eyes = 2
	/// How many usable eyes this mob currently has. Should only be changed through set_usable_eyes()
	var/usable_eyes = 2
	/// Used for the cringe filter
	var/bad_ic_count = 0
