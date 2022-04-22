/turf/closed/wall/low_wall
	name = "low wall"
	desc = "A wall small enough to fit a window in."
	icon = 'icons/turf/walls/low_walls/iron.dmi'
	icon_state = "low_wall-0"
	base_icon_state = "low_wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_LOW_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_LOW_WALLS)
	opacity = FALSE
	density = TRUE
	blocks_air = FALSE
	rad_insulation = null
	frill_icon = null // we dont have a frill, our window does
	armor = list(MELEE = 50, BULLET = 70, LASER = 70, ENERGY = 100, BOMB = 10, BIO = 100, RAD = 100, FIRE = 0, ACID = 0)
	max_integrity = 50
	uses_integrity = TRUE

	/// Whether we spawn a window structure with us on mapload
	var/start_with_window = FALSE
	/// Whether we spawn a grille structure with us on mapload
	var/start_with_grille = FALSE

	/**
	 * Typepath. Creates a corresponding window for this frame.
	 * is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	 */
	var/window_type = /obj/item/stack/sheet/glass
	/**
	 * Typepath. Creates a corresponding window for this frame.
	 * is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	 */
	var/grille_type = /obj/item/stack/rods

/turf/closed/wall/low_wall/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
	if(mapload)
		if(start_with_window)
			create_structure_window(window_type, TRUE)
		if(start_with_grille)
			create_structure_grille(window_type, TRUE)
	update_appearance()

/turf/closed/wall/low_wall/attackby(obj/item/attacking_item, mob/living/user, params)
	add_fingerprint(user)
	if(attacking_item.tool_behaviour == TOOL_WELDER)
		if(atom_integrity < max_integrity)
			if(!attacking_item.tool_start_check(user, amount = 0))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(!attacking_item.use_tool(src, user, 40, volume = 50))
				return

			atom_integrity = max_integrity
			to_chat(user, span_notice("You repair [src]."))
			update_appearance()
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return
	else if(attacking_item.tool_behaviour == TOOL_WIRECUTTER)
		if(has_grille())
			if(!attacking_item.use_tool(src, user, 0, volume = 50))
				return

			to_chat(user, span_notice("You cut the grille on [src]."))

			has_grille = FALSE
			update_appearance()
			return
	else if(isstack(attacking_item))
		var/obj/item/stack/adding_stack = attacking_item
		var/stack_name = "[adding_stack]" // in case the stack gets deleted after use()
		if(is_glass_sheet(adding_stack) && !has_window() && adding_stack.use(sheet_amount))
			to_chat(user, span_notice("You start to add [stack_name] to [src]."))
			if(!do_after(user, 2 SECONDS, src))
				return

			to_chat(user, span_notice("You add [stack_name] to [src]."))
			create_structure_window(adding_stack.type, FALSE)
		else if(istype(adding_stack, /obj/item/stack/rods) && !has_grille() && adding_stack.use(sheet_amount))
			to_chat(user, span_notice("You start to add [stack_name] to [src]."))
			if(!do_after(user, 2 SECONDS, src))
				return

			to_chat(user, span_notice("You add [stack_name] to [src]."))
			create_structure_grille(adding_stack.type)

	return ..() || attacking_item.attack_atom(src, user, params)

/turf/closed/wall/low_wall/attacked_by(obj/item/attacking_item, mob/living/user)
	if(!attacking_item.force)
		return

	var/no_damage = TRUE
	if(take_damage(attacking_item.force, attacking_item.damtype, MELEE, 1))
		no_damage = FALSE
	//only witnesses close by and the victim see a hit message.
	log_combat(user, src, "attacked", attacking_item)
	user.visible_message(span_danger("[user] hits [src] with [attacking_item][no_damage ? ", which doesn't leave a mark" : ""]!"), \
		span_danger("You hit [src] with [attacking_item][no_damage ? ", which doesn't leave a mark" : ""]!"), null, COMBAT_MESSAGE_RANGE)

/turf/closed/wall/low_wall/atom_destruction(damage_flag)
	dismantle_wall()

/turf/closed/wall/low_wall/dismantle_wall(devastated = FALSE, explode = FALSE)
	ScrapeAway()

/turf/closed/wall/low_wall/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = NONE)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/grillehit.ogg', 80, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 80, TRUE)

/turf/closed/wall/low_wall/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/turf/closed/wall/low_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 5)
	return FALSE

/turf/closed/wall/low_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_DECONSTRUCT)
		to_chat(user, "<span class='notice'>You deconstruct the low wall.</span>")
		ScrapeAway()
		return TRUE
	return FALSE

/turf/closed/wall/low_wall/examine(mob/user)
	. = ..()
	if(has_window() && has_grille())
		. += span_notice("The window is fully constructed.")
	else if(has_window())
		. += span_notice("The window set into the frame has no grilles."
	else if(has_grille())
		. += span_notice("The window frame only has a grille set into it.")
	else
		. += span_notice("The window frame is empty.")

/**
 * Creates a window from the typepath given from window_type,
 * which is either a glass sheet typepath or a /obj/structure/window subtype.
 */
/turf/closed/wall/low_wall/proc/create_structure_window(window_type, start_anchored = TRUE)
	var/obj/structure/window/our_window

	if(ispath(window_type, /obj/structure/window))
		our_window = new window_type(src)
		if(!our_window.fulltile)
			stack_trace("window frames cant use non fulltile windows!")

	//window_type isnt a window typepath, so check if its a material typepath
	if(ispath(window_type, /obj/item/stack/sheet/glass))
		our_window = new /obj/structure/window/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/rglass))
		our_window = new /obj/structure/window/reinforced/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/plasmaglass))
		our_window = new /obj/structure/window/plasma/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/plasmarglass))
		our_window = new /obj/structure/window/reinforced/plasma/fulltile(src)

	if(ispath(window_type, /obj/item/stack/sheet/titaniumglass))
		our_window = new /obj/structure/window/reinforced/shuttle(src)

	if(ispath(window_type, /obj/item/stack/sheet/plastitaniumglass))
		our_window = new /obj/structure/window/reinforced/plasma/plastitanium(src)

	if(ispath(window_type, /obj/item/stack/sheet/paperframes))
		our_window = new /obj/structure/window/paperframe(src)

	if(!start_anchored)
		our_window.set_anchored(FALSE)
		our_window.state = WINDOW_OUT_OF_FRAME

	our_window.update_appearance()

/**
 * Creates a grille from the typepath given from grille_type,
 * which is either a rod stack typepath or a /obj/structure/grille subtype.
 */
/turf/closed/wall/low_wall/proc/create_structure_window(grille_type)
	var/obj/structure/grille/our_grille

	if(ispath(grille_type, /obj/structure/grille))
		our_grille = new grille_type(src)
		if(!our_window.fulltile)
			stack_trace("window frames cant use non fulltile windows!")

	//window_type isnt a window typepath, so check if its a material typepath
	if(ispath(grille_type, /obj/item/stack/rods))
		our_grille = new /obj/structure/grille(src)

	our_grille.update_appearance()

/// helper proc to check if we already have a window
/turf/closed/wall/low_wall/proc/has_window()
	SHOULD_BE_PURE(TRUE)
	for(var/obj/structure/window/window in src)
		if(window.fulltile)
			return TRUE

	return FALSE

/// helper proc to check if we already have a grille
/turf/closed/wall/low_wall/proc/has_grille()
	SHOULD_BE_PURE(TRUE)
	for(var/obj/structure/grille/grille in src)
		return TRUE

	return FALSE

/turf/closed/wall/low_wall/window
	start_with_window = TRUE

/turf/closed/wall/low_wall/grille_and_window
	start_with_grille = TRUE
	start_with_window = TRUE

/turf/closed/wall/low_wall/reinforced
	name = "reinforced low wall"
	window_type = /obj/item/stack/sheet/rglass
	armor = list(MELEE = 80, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 25, BIO = 100, RAD = 100, FIRE = 80, ACID = 100)
	max_integrity = 150
	damage_deflection = 11

/turf/closed/wall/low_wall/reinforced/window
	start_with_window = TRUE

/turf/closed/wall/low_wall/reinforced/grille_and_window
	start_with_grille = TRUE
	start_with_window = TRUE
