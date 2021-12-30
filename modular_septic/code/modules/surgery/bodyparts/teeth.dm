/obj/item/bodypart
	/// Maximum amount of teeth this limb can hae
	var/max_teeth = 0
	/// Lisp modifier for when this limb is missing teeth
	var/datum/speech_modifier/lisp/teeth_mod
	/// Stack of teeth of the limb
	var/obj/item/stack/teeth/teeth_object

/// Proc for knocking teeth off from suitable bodyparts
/obj/item/bodypart/proc/knock_out_teeth(amount = 1, throw_dir = SOUTH)
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

//Teeth object, used by the head limb to do teeth stuff
/obj/item/stack/teeth
	name = "teeth"
	singular_name = "tooth"
	desc = "Something that british people don't have."
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "tooth_4"
	max_amount = 32
	throwforce = 0
	force = 0

/obj/item/stack/teeth/Initialize(mapload, new_amount, merge)
	. = ..()
	icon_state = "tooth_[rand(1,4)]"

/obj/item/stack/teeth/proc/do_knock_out_animation(shrink_time = 5)
	transform = transform.Scale(2, 2)
	var/turned = rand(0, 360)
	transform = transform.Turn(rand(0, 360))
	var/new_transform = transform.Scale(0.5, 0.5)
	new_transform = transform.Turn(-turned)
	animate(src, transform = new_transform, time = shrink_time)

//many teethe
/obj/item/stack/teeth/full
	amount = 32
