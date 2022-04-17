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
	products = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 35,
		/obj/item/ammo_box/magazine/m45 = 65,
	)
	var/list/tiktoklines = list('modular_septic/sound/effects/singer1.wav', 'modular_septic/sound/effects/singer2.wav')
	var/refuse_sound_cooldown_duration = 1 SECONDS
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

/obj/machinery/vending/tiktok/process(delta_time)
	if(machine_stat & (BROKEN|NOPOWER))
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
