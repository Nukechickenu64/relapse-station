/obj/item/ammo_box
	carry_weight = 2

/obj/item/ammo_box/add_notes_box()
	var/list/readout = list()
	readout += span_notice("<b>Capacity:</b> [max_ammo]")
	var/obj/item/ammo_casing/mag_ammo = get_round(TRUE)
	if(istype(mag_ammo))
		readout += "[mag_ammo.add_notes_ammo()]"
	else
		readout += span_notice("<b>Caliber:</b> [caliber]")
	return readout.Join("\n")

/obj/item/ammo_box/get_carry_weight()
	. = ..()
	for(var/obj/item/ammo_casing/casing as anything in stored_ammo)
		. += casing?.get_carry_weight()
