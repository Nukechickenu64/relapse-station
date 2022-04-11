/obj/machinery/vending/tiktok
	name = "godforsaken machine"
	desc = "A meta-physical line to a Devious, Godforsaken, and Diabolical Corporation."
	density = FALSE
	onstation = FALSE
	slogan_delay = 150
	icon_state = "tiktok"
	base_icon_state = "tiktok"
	icon = 'modular_septic/icons/obj/vending.dmi'
	product_slogans = "Idiot. FUCKING IDIOT!; Shut up, faggot.; The King is Coming!!; We are in the last moments of the end of days.; Prophesised to happen before the return of Jesus; The Marshmellow Time was wrong then and it; Salvation from God is a Gift.; The Ultimate sacrifice for all of our sins.; Ultimate Metaphysics: Divine Unity, or the Conjugate Whole"
	var/list/tiktoklines = list('modular_septic/sound/effects/singer1.wav', 'modular_septic/sound/effects/singer2.wav')
	products = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 35,
		/obj/item/ammo_box/magazine/m45 = 65,
	)

//GLOBAL_LIST_INIT(bartering_recipe_inputs, bartering_inputs())
//GLOBAL_LIST_INIT(bartering_recipe_outputs, bartering_outputs())

/obj/machinery/vending/tiktok/attackby(obj/item/I, mob/living/user, params)
	. = ..()


/obj/machinery/vending/tiktok/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		flick("[base_icon_state]-speak", src)
		playsound(src, tiktoklines,  volume, TRUE, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

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
