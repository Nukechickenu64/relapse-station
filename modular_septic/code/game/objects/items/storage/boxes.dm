/obj/item/storage/box/slugshot
	name = "box of lethal shotgun slugs"
	desc = "A box full of lethal slugs, designed for riot shotguns."
	icon_state = "lethalshot_box"
	illustration = null

/obj/item/storage/box/slugshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun(src)
