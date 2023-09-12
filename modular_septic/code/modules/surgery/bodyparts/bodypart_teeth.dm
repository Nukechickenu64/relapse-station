/obj/item/bodypart
	/// Maximum amount of teeth this limb can hae
	var/max_teeth = 0
	/// Lisp modifier for when this limb is missing teeth
	var/datum/speech_modifier/lisp/teeth_mod
	/// Stack of teeth of the limb
	var/obj/item/stack/teeth/teeth_object

/// Proc for knocking teeth off from suitable bodyparts
/obj/item/bodypart/proc/knock_out_teeth(amount = 1, throw_dir = NONE, throw_range = -1)
	return

/// Returns how many teeth we currently have
/obj/item/bodypart/proc/get_teeth_amount()
	return 0

/// Updates our lisp and other teeth related stuff
/obj/item/bodypart/proc/update_teeth()
	return FALSE

/// Fills the bodypart with it's maximum amount of teeth
/obj/item/bodypart/proc/fill_teeth()
	if(max_teeth)
		if(!teeth_object)
			teeth_object = new(src)
		teeth_object.amount = max_teeth
		return TRUE
