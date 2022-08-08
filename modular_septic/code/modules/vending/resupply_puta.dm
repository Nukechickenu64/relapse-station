#define SPENDILIZER_RETRACTED 1
#define SPENDILIZER_RETRACTING 2
#define SPENDILIZER_EXTENDED 3
#define SPENDILIZER_EXTENDING 4

/obj/machinery/resupply_puta
	name = "\improper Recovery Atire-Putas"
	desc = "A machine with coursing wires filled with a red substance, containing all you need to keep you going. Has a label explaining everything you need to know about the functions, just look twice."
	icon = 'modular_septic/icons/obj/machinery/resupply_puta.dmi'
	icon_state = "new_wallputa"
	base_icon_state = "new_wallputa"
	density = FALSE
	var/resupply_stacks = 4
	var/max_resupply_stacks = 4
	var/resupply_rounds = 120
	var/max_resupply_rounds = 120
	var/spendilizer_state = SPENDILIZER_EXTENDED
	var/state_flags = RESUPPLY_READY
	var/dispensible_stacks = list("4-gauge buckshot", "12-gauge buckshot", "4-gauge slugs", "12-gauge slugs", ".38", ".38 plus P", ".357 magnum", ".500", "big carpgus")
	var/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/captagon
	var/obj/item/gun/ballistic/revolver/remis/nova/pluspee/nova = /obj/item/gun/ballistic/revolver/remis/nova

/obj/machinery/resupply_puta/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSkillbitches, src)
	if(prob(50))
		nova = new nova(src)
	else
		nova = null

/obj/machinery/resupply_puta/Destroy()
	. = ..()
	STOP_PROCESSING(SSkillbitches, src)

/obj/machinery/resupply_puta/process(delta_time)
	if(!state_flags & RESUPPLY_READY)
		return
	var/sputtering = pick("sputters.", "garbles.", "clunks.", "cries.", "cranks.", "bangs.")
	if(DT_PROB(10, delta_time) && resupply_stacks < max_resupply_stacks)
		resupply_stacks++
		audible_message("[icon2html(src, world)] [src] " + span_bolddanger("[sputtering]"))
		playsound(src, list('modular_septic/sound/efn/resupply/garble1.ogg', 'modular_septic/sound/efn/resupply/garble2.ogg'), 65, FALSE)
	if(DT_PROB(5, delta_time) && resupply_rounds < max_resupply_rounds)
		var/added_rounds = 30
		if(resupply_rounds > 90)
			added_rounds = max_resupply_rounds - resupply_rounds
		resupply_rounds += added_rounds
		audible_message("[icon2html(src, world)] [src] " + span_bolddanger("[sputtering]"))
		playsound(src, list('modular_septic/sound/efn/resupply/garble1.ogg', 'modular_septic/sound/efn/resupply/garble2.ogg'), 55, FALSE)

/obj/machinery/resupply_puta/update_overlays()
	. = ..()
	if(!state_flags & RESUPPLY_READY || !state_flags & RESUPPLY_JUST_FILLED)
		. += "[base_icon_state]_notready"
	else if(state_flags & RESUPPLY_JUST_FILLED)
		. += "[base_icon_state]_filled"
	switch(spendilizer_state)
		if(SPENDILIZER_RETRACTED)
			. += "[base_icon_state]_spendilizer_in"
		if(SPENDILIZER_RETRACTING)
			. += "[base_icon_state]_spendilizer_inner"
		if(SPENDILIZER_EXTENDED)
			. += "[base_icon_state]_spendilizer"
		if(SPENDILIZER_EXTENDING)
			. += "[base_icon_state]_spendilizer_outer"

/obj/machinery/resupply_puta/examine_more(mob/user)
	. = list()
	. += span_infoplain("[src] has two functions.")
	. += span_info(span_alert("The wire on the bottom is called a spendilizer, It can reload magazines by just pressing the wire into the magazine feed all the way to the bottom."))
	. += span_info(span_alert("There's way to get slugs, buckshot, and stacks of revolver ammunition, simply stand near the machine and say, \"4-gauge buckshot\", \"12-gauge buckshot\", \".38 plus P\", \".357 magnum\" and so on."))
	. += span_info(span_alert("There's a slot for Captagon's, just place it inside and press the RIGHT (RMB) button to refill it."))

/obj/machinery/resupply_puta/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!state_flags & RESUPPLY_READY)
		var/doingitsthing = "It's doing It's thing!"
		if(prob(5))
			doingitsthing = "It's a fucking lawyer!"
		to_chat(user, span_notice("[doingitsthing]"))
		return
	if(!captagon)
		to_chat(user, span_warning("Nothing!"))
		return
	else if(captagon)
		begin_refill_captagon()

/obj/machinery/resupply_puta/attack_hand_tertiary(mob/living/user, list/modifiers)
	. = ..()
	if(!nova)
		to_chat(user, span_warning("There's no bright shiny gift for me today."))
		return
	else
		to_chat(user, span_green("There was a bright shiny gift!"))
		user.transferItemToLoc(nova, user.loc)
		user.put_in_hands(nova)
		nova = null

/obj/machinery/resupply_puta/attackby(obj/item/weapon, mob/user, params)
	if(!state_flags & RESUPPLY_READY)
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(istype(weapon, /obj/item/reagent_containers/hypospray/medipen/retractible/blacktar))
		if(captagon)
			to_chat(user, span_warning("There's already something in the goddamn slot."))
			return
		user.transferItemToLoc(weapon, src)
		captagon = weapon
		user.visible_message(span_danger("[user] inserts the [weapon] into the [src]'s liquid refilling slot."), \
					span_danger("I insert \the [weapon] into [src]'s liquid refilling slot."))
		playsound(src, 'modular_septic/sound/efn/resupply/insert.ogg', 35, FALSE)
		return
	if(istype(weapon, /obj/item/ammo_box/magazine))
		INVOKE_ASYNC(src, .proc/spendilize, user, weapon)
		return
	. = ..()

/obj/machinery/resupply_puta/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!state_flags & RESUPPLY_READY)
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(!do_after(user, 1 SECONDS, target = src))
		var/retarded = pick("Retarded.", "Fucking stupid.", "Fucked up.", "I'm a fucking lawyer.")
		to_chat(user, span_bolddanger("[retarded]"))
		return
	if(captagon)
		user.transferItemToLoc(user, captagon)
		user.put_in_hands(captagon)
		to_chat(user, span_notice("I take the [captagon] out of the machine."))
		playsound(src, 'modular_septic/sound/efn/resupply/desert.ogg', 40, FALSE)
		if(state_flags & RESUPPLY_JUST_FILLED && prob(8))
			var/addict_message = list("I'm addicted...", "I'm so fucking gross...", "This IS poison, I'm putting poison inside of MY body...", "It's not MY blood...")
			to_chat(user, span_warning(addict_message))
			state_flags &= ~RESUPPLY_JUST_FILLED
			update_appearance(UPDATE_ICON)
		captagon = null

/obj/machinery/resupply_puta/proc/spendilize(mob/user, obj/item/ammo_box/magazine)
	if(!state_flags & RESUPPLY_READY)
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	if(resupply_rounds == 0)
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		audible_message("[icon2html(src, world)] [src] [verb_say], \"I'm empty, try again later.\"")
		return
	var/obj/item/ammo_box/magazine/AM = magazine
	if(length(magazine.stored_ammo) == magazine.max_ammo)
		var/tasty_bullets = pick("delicious morsels", "brave warriors", "tasty bullets", "yummy rounds", "scheming lawyers")
		var/not_any_more = pick("you can't add any more!", "you just can't do that!", "you just don't understand!", "you're a fool!", "you're a fucking lawyer!")
		audible_message("[icon2html(src, world)] [src] [verb_say], \"The [magazine] is filled to the brim with [tasty_bullets], [not_any_more]\"")
		sound_hint()
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	state_flags &= ~RESUPPLY_READY
	update_appearance(UPDATE_ICON)
	to_chat(user, span_notice("I begin the spendilization process."))
	needles_in()
	while(length(magazine.stored_ammo) < magazine.max_ammo)
		var/newbullet = magazine.ammo_type
		if(!usr.Adjacent(src) || resupply_rounds == 0)
			playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
			state_flags |= RESUPPLY_READY
			needles_out()
			break
			return
		sleep(2)
		magazine.give_round(new newbullet(), TRUE)
		resupply_rounds--
		magazine.update_ammo_count()
		to_chat(user, span_notice("Loading..."))
		playsound(src, AM.bullet_load, 60, TRUE)
	needles_out()
	playsound(src, 'modular_septic/sound/efn/resupply/ticking.ogg', 65, FALSE)
	addtimer(CALLBACK(src, .proc/donehere), 6)

/obj/machinery/resupply_puta/proc/begin_refill_captagon()
	if(!captagon) // NO CAPTAGON?
		return
	state_flags &= ~RESUPPLY_READY
	playsound(src, 'modular_septic/sound/efn/resupply/buttonpress.ogg', 65, FALSE)
	addtimer(CALLBACK(src, .proc/finalize_refill_captagon), 3 SECONDS)

/obj/machinery/resupply_puta/proc/finalize_refill_captagon()
	if(!captagon.reagent_holder_right.total_volume)
		captagon.reagent_holder_right.add_reagent_list(list(/datum/reagent/medicine/blacktar = 50, /datum/reagent/medicine/c2/helbital = 20))
		audible_message("[icon2html(src, world)] [src] [verb_say], \"Right vial filled.\"")
	if(!captagon.reagent_holder_left.total_volume)
		captagon.reagent_holder_left.add_reagent_list(list(/datum/reagent/medicine/blacktar = 50, /datum/reagent/medicine/c2/helbital = 20))
		audible_message("[icon2html(src, world)] [src] [verb_say], \"Left vial filled.\"")
	captagon.update_appearance(UPDATE_ICON)
	state_flags |= RESUPPLY_READY
	playsound(src, 'modular_septic/sound/efn/captagon/heroin_fill.ogg', 65, FALSE)


/obj/machinery/resupply_puta/proc/donehere(mob/user)
	state_flags |= RESUPPLY_READY
	update_appearance(UPDATE_ICON)
	var/yep = pick("Yep", "Yessir", "Alright", "Okay", "Great", "Finally", "Mhm", "It's over")
	audible_message("[icon2html(src, world)] [src] [verb_say], \"[yep], we're done here.\"")
	sound_hint()
	playsound(src, 'modular_septic/sound/efn/resupply/success.ogg', 65, FALSE)

/obj/machinery/resupply_puta/proc/needles_out()
	spendilizer_state = SPENDILIZER_EXTENDING
	update_appearance(UPDATE_ICON)
	sleep(3)
	spendilizer_state = SPENDILIZER_EXTENDED
	update_appearance(UPDATE_ICON)

/obj/machinery/resupply_puta/proc/needles_in()
	spendilizer_state = SPENDILIZER_RETRACTING
	update_appearance(UPDATE_ICON)
	sleep(3)
	spendilizer_state = SPENDILIZER_RETRACTED
	update_appearance(UPDATE_ICON)

/obj/machinery/resupply_puta/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/resupply_puta/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/resupply_puta/directional/west
	dir = EAST
	pixel_x = -32

#undef SPENDILIZER_RETRACTED
#undef SPENDILIZER_RETRACTING
#undef SPENDILIZER_EXTENDED
#undef SPENDILIZER_EXTENDING
