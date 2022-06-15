/obj/structure/closet/secure_closet/Initialize(mapload)
	. = ..()
	hacking = set_hacking()

/obj/structure/closet/secure_closet/attackby(obj/item/W, mob/living/user)
	. = ..()
	if(is_wire_tool(W))
		attempt_hacking_interaction(user)
		return
/**
 * Generates the secured_closet's hacking datum.
 */
/obj/structure/closet/secure_closet/proc/set_hacking()
	return new /datum/hacking/closet(src)
