/obj/structure/closet/secure_closet/Initialize(mapload)
	. = ..()
	hacking = set_hacking()

/**
 * Generates the secured_closet's hacking datum.
 */
/obj/structure/closet/secure_closet/proc/set_hacking()
	return new /datum/hacking/closet(src)
