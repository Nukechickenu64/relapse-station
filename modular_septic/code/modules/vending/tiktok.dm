/obj/machinery/vending/tiktok
	name = "godforsaken machine"
	desc = "A meta-physical line to a Devious, Godforsaken, and Diabolical Corporation."
	density = FALSE
	onstation = FALSE
	slogan_delay = 600
	icon_state = "tiktok"
	base_icon_state = "tiktok"
	icon = 'modular_septic/icons/obj/machinery/vending.dmi'
	product_slogans = "Idiot. FUCKING IDIOT!; Shut up, faggot.; The King is Coming!!; We are in the last moments of the end of days.; Prophesised to happen before the return of Jesus; The Marshmellow Time was wrong then and it; Salvation from God is a Gift.; The Ultimate sacrifice for all of our sins.; Ultimate Metaphysics: Divine Unity, or the Conjugate Whole"
	products = list(
		/obj/item/clothing/under/itobe/agent = 40,
		/obj/item/clothing/shoes/jackboots = 40,
		/obj/item/clothing/gloves/color/black = 40,
		/obj/item/clothing/glasses/itobe/agent = 40,
		/obj/item/clothing/suit/armor/vest/alt/discrete = 40,
		/obj/item/gun/ballistic/automatic/pistol/remis/glock17 = 40,
		/obj/item/ammo_box/magazine/glock9mm = 65,
	)
	var/list/tiktoklines = list('modular_septic/sound/effects/singer1.wav', 'modular_septic/sound/effects/singer2.wav')
	var/refuse_sound_cooldown_duration = 1 SECONDS
	var/barfsound = list('modular_septic/sound/emotes/barf1.wav', 'modular_septic/sound/emotes/barf2.wav')
	COOLDOWN_DECLARE(refuse_cooldown)

/obj/machinery/vending/tiktok/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!GLOB.bartering_inputs[I.type])
		if(COOLDOWN_FINISHED(src, refuse_cooldown))
			sound_hint()
			playsound(src, 'modular_septic/sound/effects/clunk.wav', 60, vary = FALSE)
			COOLDOWN_START(src, refuse_cooldown, refuse_sound_cooldown_duration)
		return
	if(user.transferItemToLoc(I, src))
		sound_hint()
		playsound(src, 'modular_septic/sound/effects/crusher.wav', 70, vary = FALSE)
		INVOKE_ASYNC(src, .proc/crushing_animation)
		check_bartering()

/obj/machinery/vending/tiktok/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(istype(over, usr))
		vomit_items()

/obj/machinery/vending/tiktok/process(delta_time)
	if(machine_stat & BROKEN | NOPOWER)
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people! Really sell it!
	if((last_slogan + slogan_delay <= world.time) && (LAZYLEN(slogan_list) > 0) && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		flick("[base_icon_state]-speak", src)
		playsound(src, tiktoklines, 70, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/tiktok/proc/crushing_animation()
	add_overlay("[base_icon_state]-eat")
	sleep(11)
	cut_overlay("[base_icon_state]-eat")

/obj/machinery/vending/tiktok/proc/check_bartering()
	var/datum/bartering_recipe/bartering_recipe
	//loop through every bartering recipe and attempt to execute it
	for(var/recipe_type as anything in GLOB.bartering_recipes)
		bartering_recipe = GLOB.bartering_recipes[recipe_type]
		//associated list, every item we end up needing to use in the recipe and the associated input path type
		var/list/valid_inputs = list()
		//associated list, every input path type associated with the amount we have
		var/list/input_counter = list()
		var/recipe_failed = FALSE
		for(var/input_type in bartering_recipe.inputs)
			var/amount_needed = bartering_recipe.inputs[input_type]
			for(var/obj/item/thing_inside_us in contents)
				if(input_counter[input_type] >= amount_needed)
					break
				if(istype(thing_inside_us, input_type))
					//stack shitcode very cool
					valid_inputs[thing_inside_us] = input_type
					if(!input_counter[input_type])
						input_counter[input_type] = 0
					if(isstack(thing_inside_us))
						var/obj/item/stack/stack_item = thing_inside_us
						input_counter[input_type] = min(amount_needed, input_counter[input_type] + stack_item.amount)
					else
						input_counter[input_type] = input_counter[input_type] + 1
			if(input_counter[input_type] < amount_needed)
				recipe_failed = TRUE
				break
		if(recipe_failed)
			continue
		for(var/obj/item/input as anything in valid_inputs)
			var/input_type = valid_inputs[input]
			var/amount_yoink = input_counter[input_type]
			if(isstack(input))
				var/obj/item/stack/stack_input = input
				var/amount_yoinked = min(stack_input.amount, amount_yoink)
				stack_input.use(amount_yoinked)
				input_counter[input_type] -= amount_yoinked
			else
				input_counter[input_type] -= 1
				qdel(input)
		for(var/output in bartering_recipe.outputs)
			products[output] = bartering_recipe.outputs[output]
			product_records = list()
			build_inventory(products, product_records)
		playsound(src, 'modular_septic/sound/effects/ring.wav', 90, TRUE)
		speak("Take from me.")

/obj/machinery/vending/tiktok/proc/vomit_items()
	//remis please add a vomiting blorf sound right below this comment
	playsound(src, barfsound, 65, FALSE)
	for(var/obj/item/vomited in src)
		vomited.forceMove(loc)

//	remove_overlay("[base_icon_state]-eat")
/obj/machinery/vending/tiktok/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/vending/tiktok/directional/south
	dir = NORTH
	pixel_y = -32

/obj/machinery/vending/tiktok/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/vending/tiktok/directional/west
	dir = EAST
	pixel_x = -32
