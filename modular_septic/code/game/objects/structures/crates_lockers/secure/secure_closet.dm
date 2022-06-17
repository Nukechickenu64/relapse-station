/obj/structure/closet/secure_closet/Initialize(mapload)
	. = ..()
	hacking = set_hacking()

/obj/structure/closet/secure_closet/attackby(obj/item/W, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(is_wire_tool(W) && !IS_HARM_INTENT(user, modifiers))
		attempt_hacking_interaction(user)
		return
	return ..()

/**
 * Generates the secured_closet's hacking datum.
 */
/obj/structure/closet/secure_closet/proc/set_hacking()
	return new /datum/hacking/closet(src)
