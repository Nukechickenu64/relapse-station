/obj/structure/closet/secure_closet/Initialize(mapload)
	. = ..()
	hacking = set_hacking()

/obj/structure/closet/secure_closet/proc/set_hacking()
	return new /datum/hacking/closet(src)
