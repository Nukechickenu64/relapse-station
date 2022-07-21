/obj/item/simcard
	name = "\improper sim card"
	desc = "Sim, sim, I agree with your statement"
	icon = 'modular_septic/icons/obj/items/phone.dmi'
	icon_state = "simcard"
	base_icon_state = "simcard"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	/// Username of the sim card, used even when not public
	var/username
	/// Phone number (this is actually a string lol)
	var/phone_number
	/// Whether we are in the public phone list or not
	var/publicity = FALSE
	/// Phone we are inside of
	var/obj/item/cellphone/phone

/obj/item/simcard/Initialize(mapload)
	. = ..()
	generate_phone_number()
	GLOB.simcard_list[phone_number] = src

/obj/item/simcard/Destroy()
	. = ..()
	GLOB.active_public_simcard_list -= username
	GLOB.active_simcard_list -= phone_number
	GLOB.simcard_list -= phone_number
	GLOB.simcard_list_by_username -= username

/obj/item/simcard/proc/toggle_publicity()
	publicity = !publicity
	if(publicity && phone && username)
		GLOB.active_public_simcard_list[username] = src
	else
		GLOB.active_public_simcard_list -= username

/obj/item/simcard/proc/generate_phone_number()
	if(phone_number)
		GLOB.simcard_list -= phone_number
	phone_number = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]-[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	GLOB.simcard_list[phone_number] = src
