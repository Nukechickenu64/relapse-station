/obj/structure/closet
	door_anim_time = 0

/obj/structure/closet/Initialize(mapload)
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/structure/closet/tool_interact(obj/item/W, mob/living/user)
	. = ..()
	if(!hacking)
		return
	if(user.tool_behaviour == TOOL_HACKING)
		do_hacking_action(user)
