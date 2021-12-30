/obj/item/ammo_box
	carry_weight = 2

/obj/item/ammo_box/get_carry_weight()
	. = ..()
	for(var/obj/item/ammo_casing/casing as anything in stored_ammo)
		. += casing?.get_carry_weight()
