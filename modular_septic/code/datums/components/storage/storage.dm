/datum/component/storage
	screen_max_columns = INFINITY
	screen_max_rows = 8
	screen_pixel_x = 0
	screen_pixel_y = 0
	screen_start_x = 1
	screen_start_y = 11
	var/maximum_depth = 1
	var/storage_flags = NONE

/datum/component/storage/Initialize(datum/component/storage/concrete/master)
	. = ..()
	if(!.)
		RegisterSignal(parent, COMSIG_STORAGE_CAN_USER_TAKE, .proc/can_user_take)

/datum/component/storage/orient2hud()
	var/atom/real_location = real_location()
	var/adjusted_contents = length(real_location.contents)

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(display_numerical_stacking)
		numbered_contents = _process_numerical_display()
		adjusted_contents = length(numbered_contents)

	var/rows = clamp(max_items, 1, screen_max_rows)
	var/columns = clamp(CEILING(adjusted_contents / rows, 1), 1, screen_max_columns)
	standard_orient_objs(rows, columns, numbered_contents)

/datum/component/storage/standard_orient_objs(rows, cols, list/obj/item/numerical_display_contents)
	boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+cols-1]:[screen_pixel_x],[screen_start_y-rows+1]:[screen_pixel_y]"
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numerical_display_contents))
		for(var/type in numerical_display_contents)
			var/datum/numbered_display/ND = numerical_display_contents[type]
			ND.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			ND.sample_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			ND.sample_object.maptext = MAPTEXT("<font color='white'>[(ND.number > 1)? "[ND.number]" : ""]</font>")
			ND.sample_object.plane = ABOVE_HUD_PLANE
			cy--
			if(screen_start_y - cy >= rows)
				cy = screen_start_y
				cx++
				if(cx - screen_start_x >= cols)
					break
	else
		var/atom/real_location = real_location()
		for(var/obj/O in real_location)
			if(QDELETED(O))
				continue
			O.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			O.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			O.maptext = ""
			O.plane = ABOVE_HUD_PLANE
			cy--
			if(screen_start_y - cy >= rows)
				cy = screen_start_y
				cx++
				if(cx - screen_start_x >= cols)
					break
	closer.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y+1]:[screen_pixel_y]"

/datum/component/storage/signal_insertion_attempt(datum/source, obj/item/I, mob/M, silent = FALSE, force = FALSE, worn_check = FALSE)
	if((!force && !can_be_inserted(I, TRUE, M, worn_check)) || (I == parent))
		return FALSE
	return handle_item_insertion(I, silent, M)

/datum/component/storage/can_be_inserted(obj/item/I, stop_messages, mob/M, worn_check = FALSE)
	if(!istype(I) || (I.item_flags & ABSTRACT))
		return FALSE //Not an item
	if(I == parent)
		return FALSE //no paradoxes for you
	var/atom/real_location = real_location()
	var/atom/host = parent
	if(real_location == I.loc)
		return FALSE //Means the item is already in the storage item
	if(locked)
		if(M && !stop_messages)
			host.add_fingerprint(M)
			to_chat(M, span_warning("[host] seems to be locked!"))
		return FALSE
	if(worn_check && !worn_check(parent, M))
		host.add_fingerprint(M)
		return FALSE
	if(real_location.contents.len >= max_items)
		if(!stop_messages)
			to_chat(M, span_warning("[host] is full, make some space!"))
		return FALSE //Storage item is full
	if(length(can_hold))
		if(!is_type_in_typecache(I, can_hold))
			if(!stop_messages)
				to_chat(M, span_warning("[host] cannot hold [I]!"))
			return FALSE
	if(is_type_in_typecache(I, cant_hold) || HAS_TRAIT(I, TRAIT_NO_STORAGE_INSERT) || (can_hold_trait && !HAS_TRAIT(I, can_hold_trait))) //Items which this container can't hold.
		if(!stop_messages)
			to_chat(M, span_warning("[host] cannot hold [I]!"))
		return FALSE
	if(I.w_class > max_w_class && !is_type_in_typecache(I, exception_hold))
		if(!stop_messages)
			to_chat(M, span_warning("[I] is too big for [host]!"))
		return FALSE
	var/atom/recursive_loc = real_location?.loc
	var/depth = 0
	while(isatom(recursive_loc) && !isturf(recursive_loc) && !isarea(recursive_loc))
		depth += 1
		var/datum/component/storage/biggerfish = recursive_loc.GetComponent(/datum/component/storage)
		if(biggerfish && !istype(biggerfish, /datum/component/storage/concrete/organ))
			if(biggerfish.max_w_class < max_w_class) //return false if we are inside of another container, and that container has a smaller max_w_class than us (like if we're a bag in a box)
				if(!stop_messages)
					to_chat(M, span_warning("[I] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
			else if(worn_check && !biggerfish.worn_check(I, M, stop_messages))
				if(!stop_messages)
					to_chat(M, span_warning("[I] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
			else if(biggerfish.maximum_depth < depth)
				if(!stop_messages)
					to_chat(M, span_warning("[I] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
		recursive_loc = recursive_loc.loc
	var/sum_w_class = I.w_class
	for(var/obj/item/_I in real_location)
		sum_w_class += _I.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.
	if(sum_w_class > max_combined_w_class)
		if(!stop_messages)
			to_chat(M, span_warning("[I] won't fit in [host], make some space!"))
		return FALSE
	if(isitem(host))
		var/obj/item/IP = host
		var/datum/component/storage/STR_I = I.GetComponent(/datum/component/storage)
		if((I.w_class >= IP.w_class) && STR_I && !allow_big_nesting)
			if(!stop_messages)
				to_chat(M, span_warning("[IP] cannot hold [I] as it's a storage item of the same size!"))
			return FALSE //To prevent the stacking of same sized storage items.
	if(HAS_TRAIT(I, TRAIT_NODROP)) //SHOULD be handled in unEquip, but better safe than sorry.
		if(!stop_messages)
			to_chat(M, span_warning("\The [I] is stuck to your hand, you can't put it in \the [host]!"))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.slave_can_insert_object(src, I, stop_messages, M)

/datum/component/storage/proc/on_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER

	var/atom/A = parent
	for(var/mob/living/L in can_see_contents())
		if(!L.CanReach(A))
			hide_from(L)
	if(!worn_check_aggressive(parent, user, TRUE))
		hide_from(user)
	update_actions()

/datum/component/storage/proc/worn_check(obj/item/I, mob/M, no_message = FALSE)
	. = TRUE
	if(!istype(I) || !istype(M) || !CHECK_BITFIELD(storage_flags, STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS))
		return TRUE

	if(storage_flags & STORAGE_NO_EQUIPPED_ACCESS && (I.item_flags & IN_INVENTORY))
		if(!no_message)
			to_chat(M, span_warning("[I] is too bulky! I need to set it down before I can access it's contents!"))
		return FALSE
	else if(storage_flags & STORAGE_NO_WORN_ACCESS && (I.item_flags & IN_INVENTORY) && !(I in M.held_items))
		if(!no_message)
			to_chat(M, span_warning("My arms aren't long enough to reach into [I] while wearing it!"))
		return FALSE

/datum/component/storage/proc/worn_check_aggressive(obj/item/I, mob/M, no_message = FALSE)
	. = TRUE
	if(!istype(I) || !istype(M) || !CHECK_BITFIELD(storage_flags, STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS))
		return TRUE

	if(storage_flags & STORAGE_NO_EQUIPPED_ACCESS)
		if(!no_message)
			to_chat(M, span_warning("[I] is too bulky! I need to set it down before I can access it's contents!"))
		return FALSE
	else if(storage_flags & STORAGE_NO_WORN_ACCESS && !(I in M.held_items))
		if(!no_message)
			to_chat(M, span_warning("My arms aren't long enough to reach into [I] while wearing it!"))
		return FALSE

/datum/component/storage/proc/can_user_take(obj/item/I, mob/user, no_message = FALSE)
	. = FALSE
	if(!worn_check(parent, user, no_message))
		return FALSE
	if(!istype(src, /datum/component/storage/concrete/organ))
		var/atom/real_location = real_location()
		var/atom/recursive_loc = real_location?.loc
		var/depth = 0
		while(isatom(recursive_loc) && !isturf(recursive_loc) && !isarea(recursive_loc))
			depth += 1
			var/datum/component/storage/biggerfish = recursive_loc.GetComponent(/datum/component/storage)
			if(biggerfish && !istype(biggerfish, /datum/component/storage/concrete/organ))
				if(!biggerfish.worn_check(biggerfish.parent, user, TRUE))
					if(!no_message)
						to_chat(user, span_warning("[recursive_loc] is in the way!"))
					return
				else if(biggerfish.maximum_depth < depth)
					if(!no_message)
						to_chat(user, span_warning("[recursive_loc] is in the way!"))
					return
			recursive_loc = recursive_loc.loc
	return TRUE

/datum/component/storage/proc/get_carry_weight()
	. = 0
	//we do need a typecheck here
	for(var/obj/item/thing in contents())
		. += thing.get_carry_weight()
