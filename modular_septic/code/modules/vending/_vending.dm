/obj/machinery/vending
	var/infected = FALSE
	var/infected_noise = 'modular_septic/sound/effects/yomai.ogg'
	var/infected_slogan = "GOD, GOD GOD GOD GOOODDDDD!!!;OH MY LORD. OH MY GOODNESS GRACIOUS JEEEESUS CHRIST!;OHHHHHHHHH!;FFFUUUUCCCKK FUCKK AAHHHHHHHHHHH AHHHHHH FUCK!!!!"

/obj/machinery/vending/Initialize(mapload)
	. = ..()
	hacking = set_hacking()
	if(InitializeExtraItems())
		product_records = list()
		build_inventory(products, product_records)
		hidden_records = list()
		build_inventory(contraband, hidden_records)
		coin_records = list()
		build_inventory(premium, coin_records)
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/machinery/vending/proc/set_hacking()
	return new /datum/hacking/vending(src)

/obj/machinery/vending/attackby(obj/item/I, mob/living/user, params)
	if(panel_open && is_wire_tool(I))
		wires.interact(user)
		return
	else if(is_wire_tool(I))
		attempt_hacking_interaction(user)
		return TRUE

	if(refill_canister && istype(I, refill_canister))
		if (!panel_open)
			to_chat(user, span_warning("You should probably unscrew the service panel first!"))
		else if (machine_stat & (BROKEN|NOPOWER))
			to_chat(user, span_notice("[src] does not respond."))
		else
			var/obj/item/vending_refill/canister = I
			if(canister.get_part_rating() == 0)
				to_chat(user, span_warning("[canister] is empty!"))
			else
				var/transferred = restock(canister)
				if(transferred)
					to_chat(user, span_notice("You loaded [transferred] items in [src]."))
				else
					to_chat(user, span_warning("There's nothing to restock!"))
			return
	if(compartmentLoadAccessCheck(user) && IS_HELP_INTENT(user, params2list(params)))
		if(canLoadItem(I))
			loadingAttempt(I,user)
			updateUsrDialog()

		if(istype(I, /obj/item/storage/bag))
			var/obj/item/storage/T = I
			var/loaded = 0
			var/denied_items = 0
			for(var/obj/item/the_item in T.contents)
				if(contents.len >= MAX_VENDING_INPUT_AMOUNT)
					to_chat(user, span_warning("[src]'s compartment is full."))
					break
				if(canLoadItem(the_item) && loadingAttempt(the_item,user))
					SEND_SIGNAL(T, COMSIG_TRY_STORAGE_TAKE, the_item, src, TRUE)
					loaded++
				else
					denied_items++
			if(denied_items)
				to_chat(user, span_warning("[src] refuses some items!"))
			if(loaded)
				to_chat(user, span_notice("You insert [loaded] dishes into [src]'s compartment."))
				updateUsrDialog()

/obj/machinery/vending/proc/InitializeExtraItems()
	return

/obj/machinery/vending/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		if(infected)
			playsound(src, infected_noise,  volume, TRUE, vary = FALSE)
		if(!infected)
			speak(slogan)
			last_slogan = world.time
		else
			speak(infected_slogan)
			last_slogan = world.time
