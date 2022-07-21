/obj/item/cellphone
	name = "cellular phone"
	desc = "An allegedly portable phone that comes with primarily communication uses, with the ability to make both public and private calls from anywhere in the world. Data service may vary If you're \
			tightly trapped in a supernatural warehouse with only one way out."
	icon = 'modular_septic/icons/obj/items/phone.dmi'
	icon_state = "phone"
	base_icon_state = "phone"
	worn_icon_state = "pda"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT
	verb_say = "communicates"
	pickup_sound = 'modular_septic/sound/efn/phone_pickup.ogg'
	equip_sound = 'modular_septic/sound/efn/phone_holster.ogg'
	/// General flags about the state of the phone
	var/phone_flags = PHONE_FLIPHONE
	/// Only matters if phone_flags has PHONE_FLIPHONE enabled
	var/flipped = FALSE
	/// Phone's brand
	var/brand_name = "ULTRABLUE PRINCE"
	/// I have no idea what is planned for this but Remis wanted it
	var/serial_number = ""
	/**
	 * The phone's sim card, without a sim card phones are basically useless bricks
	 * Stores the phone's number, public name AND misc programs
	*/
	var/obj/item/simcard/simcard
	/**
	 * State that specifies how we treat connected_phone
	 * Are we currently in a call with connected_phone?
	 * Are we BEING CALLED by connected_phone?
	 * Are we CALLING connected_phone?
	 * Etc.
	*/
	var/connection_state = CONNECTION_NONE
	/// Phone we are connected to, what the fuck this means depends on connection_state
	var/obj/item/cellphone/connected_phone

	var/datum/looping_sound/phone_ringtone/ringtone_soundloop
	var/datum/looping_sound/phone_call/call_soundloop
	var/datum/looping_sound/phone_glitch/glitch_soundloop

	// SOUNDING
	var/flip_sound = 'modular_septic/sound/efn/phone_flip.ogg'
	var/unflip_sound = 'modular_septic/sound/efn/phone_unflip.ogg'

/obj/item/cellphone/Initialize(mapload)
	. = ..()
	call_soundloop = new(src, FALSE)
	ringtone_soundloop = new(src, FALSE)
	glitch_soundloop = new(src, FALSE)
	var/list/characters = GLOB.alphabet_upper | GLOB.numerals
	serial_number = random_string(8, characters)
	name = "\proper [random_adjective()] ([rand(0,9)][rand(0,9)]) [initial(name)]"
	if(ispath(simcard, /obj/item/simcard))
		install_simcard(new simcard(src))
	become_hearing_sensitive(trait_source = ROUNDSTART_TRAIT)
	update_appearance()

/obj/item/cellphone/Destroy()
	. = ..()
	terminate_connection()
	if(simcard)
		QDEL_NULL(simcard)
	QDEL_NULL(call_soundloop)
	QDEL_NULL(ringtone_soundloop)
	QDEL_NULL(glitch_soundloop)

/obj/item/cellphone/update_overlays()
	. = ..()
	if(phone_flags & PHONE_FLIPHONE)
		. += (flipped ? "[base_icon_state]_door_open" : "[base_icon_state]_door")
	if(!((phone_flags & PHONE_FLIPHONE) && (phone_flags & PHONE_NO_UNFLIPPED_SCREEN) && !flipped))
		if(phone_flags & PHONE_RESETTING)
			. += "[base_icon_state]_resetting"
		else if(phone_flags & PHONE_GLITCHING)
			. += "[base_icon_state]_glitch"
		else if(simcard)
			switch(connection_state)
				if(CONNECTION_ACTIVE_CALL)
					. += "[base_icon_state]_paired"
				if(CONNECTION_CALLING, CONNECTION_BEING_CALLED)
					. += "[base_icon_state]_ringring"
				else
					. += "[base_icon_state]_active"

/obj/item/cellphone/examine(mob/user)
	. = ..()
	if(!simcard)
		. += span_warning("[src] has no sim card loaded, making [p_them()] pretty useless.")
	else
		. += span_info("[src] has [icon2html(simcard, user)] <b>[simcard]</b> installed in the sim card slot.")
		. += span_info("To see more info about [icon2html(simcard, user)] <b>[simcard]</b>, take it out of the slot and examine it.")
	if(phone_flags & PHONE_RESETTING)
		. += span_warning("[src] [p_are()] undergoing a factory reset.")
	if(connected_phone)
		switch(connection_state)
			if(CONNECTION_ACTIVE_CALL)
				. += span_info("Currently in a call with <b>[connected_phone.simcard.username]</b>.")
			if(CONNECTION_BEING_CALLED)
				. += span_info("Currently being called by <b>[connected_phone.simcard.username]</b>.")
			if(CONNECTION_CALLING)
				. += span_info("Currently calling <b>[connected_phone.simcard.username]</b>.")
	if(!simcard.username)
		. += span_warning("[simcard]] has no username.")
	else
		. += span_info("<b>Username:</b> [simcard.username]")
	. += span_info("<b>Phone number:</b> [simcard.phone_number]")

/obj/item/cellphone/attack_self(mob/user, modifiers)
	. = ..()
	if((phone_flags & PHONE_FLIPHONE) && !flipped)
		to_chat(user, span_warning("[p_they(TRUE)] [p_are()] not flipped open. (CTRL-LMB)"))
		return
	if(phone_flags & PHONE_RESETTING)
		to_chat(user, span_warning("[fail_msg(TRUE)] [p_they(TRUE)] [p_are()] doing a factory reset."))
		return
	if(phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[fail_msg(TRUE)] Something is fucked with [p_them()]."))
		return
	if(!simcard)
		var/obj/item/simcard/fake_simcard
		var/image/simcard_image = image(initial(fake_simcard.icon), initial(fake_simcard.icon_state))
		to_chat(user, span_warning("[fail_msg(TRUE)] No [icon2html(simcard_image, user)] <b>sim card</b>."))
		return
	if(!simcard.username)
		to_chat(user, span_warning("[fail_msg(TRUE)] [icon2html(simcard, user)] [simcard] needs an username."))
		return
	switch(connection_state)
		if(CONNECTION_BEING_CALLED)
			accept_call(user)
			return
		if(CONNECTION_CALLING)
			stop_calling(user)
			return
		if(CONNECTION_ACTIVE_CALL)
			hang_up(user)
			return
	if(phone_flags & PHONE_RECEIVING_INPUT)
		return
	INVOKE_ASYNC(src, .proc/dial_menu, user)

/obj/item/cellphone/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if((phone_flags & PHONE_FLIPHONE) && !flipped)
		to_chat(user, span_warning("[p_they(TRUE)] [p_are()] not flipped open. (CTRL-LMB"))
		return
	if(phone_flags & PHONE_RESETTING)
		to_chat(user, span_warning("[fail_msg(TRUE)] [p_they(TRUE)] [p_are()] doing a factory reset."))
		return
	if(phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[fail_msg(TRUE)] Something is fucked with [p_them()]."))
		return
	if(!simcard)
		var/obj/item/simcard/fake_simcard
		var/image/simcard_image = image(initial(fake_simcard.icon), initial(fake_simcard.icon_state))
		to_chat(user, span_warning("[fail_msg(TRUE)] No [icon2html(simcard_image, user)] <b>sim card</b>."))
		return
	switch(connection_state)
		if(CONNECTION_BEING_CALLED)
			reject_call()
			return
		if(CONNECTION_CALLING)
			stop_calling()
			return
		if(CONNECTION_ACTIVE_CALL)
			hang_up()
			return
	if(phone_flags & PHONE_RECEIVING_INPUT)
		return
	INVOKE_ASYNC(src, .proc/options_menu, user)

/obj/item/cellphone/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/simcard))
		return
	if(simcard)
		to_chat(user, span_warning("[fail_msg(TRUE)] There is already [icon2html(simcard, user)] <b>[simcard]</b> inside [src]."))
		return
	var/obj/item/simcard/simpsons_card = attacking_item
	if(user.transferItemToLoc(simpsons_card, src))
		to_chat(user, span_notice("I carefully install [icon2html(simpsons_card, user)] <b>[simpsons_card]</b> into [src]'s sim card slot."))
		playsound(src, 'modular_septic/sound/efn/phone_simcard_insert.ogg', 65, FALSE)
		install_simcard(simpsons_card, user)
		sound_hint()

/obj/item/cellphone/AltClick(mob/user)
	. = ..()
	if(!simcard)
		to_chat(user, span_warning("[fail_msg(TRUE)] What sim card?"))
		return
	if((connection_state == CONNECTION_CALLING) || (connection_state == CONNECTION_BEING_CALLED))
		to_chat(user, span_warning("I should hang up first."))
		return
	var/obj/item/simcard/simpsons_card = simcard
	if(user.transferItemToLoc(simpsons_card, user.loc))
		to_chat(user, span_notice("I carefully take out [simpsons_card] from [src]'s sim card slot."))
		playsound(src, 'modular_septic/sound/efn/phone_simcard_desert.ogg', 65, FALSE)
		uninstall_simcard(user)
		sound_hint()

/obj/item/cellphone/CtrlClick(mob/user)
	. = ..()
	var/mob/living/living_user = user
	if(!istype(living_user))
		return
	if(!living_user.is_holding(src))
		return
	if(!(phone_flags & PHONE_FLIPHONE))
		to_chat(user, span_warning("\The [src] [p_are()] not a flip phone."))
		return
	if(connection_state != CONNECTION_NONE)
		to_chat(user, span_warning("I should hang up first."))
		return
	toggle_flip(user)

/obj/item/cellphone/proc/options_menu(mob/living/user)
	var/list/options = list(
		"Disable Parental Controls",
		"Toggle Publicity",
		"Change Username",
		"Self-Status",
		"Factory Reset",
	)
	if(!simcard.username)
		options = list("Set Username")
	else if(LAZYLEN(simcard.applications))
		options += "Execute Simcard Application"

	phone_flags |= PHONE_RECEIVING_INPUT

	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(src, random_press_sound, 65, FALSE)
	var/title = "What do you want to do?"
	var/message = "Options Menu"
	var/input = tgui_input_list(user, message, title, options)
	switch(input)
		if("Disable Parental Controls")
			disable_parental_controls(user)
		if("Toggle Publicity")
			toggle_simcard_publicity(user)
		if("Change Username", "Set Username")
			change_username(user)
		if("Self-Status")
			self_status(user)
		if("Factory Reset")
			begin_factory_reset(user)
		if("Execute Simcard Application")
			application_menu(user)

	phone_flags &= ~PHONE_RECEIVING_INPUT

/obj/item/cellphone/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods)
	. = ..()
	if(!connected_phone || (connection_state != CONNECTION_ACTIVE_CALL))
		return
	if(get_turf(src) != get_turf(speaker))
		return
	var/talking_noise = pick('modular_septic/sound/efn/phone_talk1.ogg', 'modular_septic/sound/efn/phone_talk2.ogg', 'modular_septic/sound/efn/phone_talk3.ogg')
	playsound(connected_phone, talking_noise, 12, FALSE, -6)
	if(connected_phone == speaker)
		audible_message(span_warning("[icon2html(src, world)] [src] makes godawful noises as [p_they()] fall[p_s()] into a feedback loop!"))
		connected_phone.audible_message(span_warning("[icon2html(connected_phone, world)] [connected_phone] makes godawful noises as [p_they()] fall[p_s()] into a feedback loop!"))
		return
	connected_phone.audible_message("[icon2html(src, world)] [src] [verb_say], \"[raw_message]\"", hearing_distance = 1)

/obj/item/cellphone/proc/dial_menu(mob/living/user)
	var/list/options = list("Dial Manually", "Public Phone List")
	var/mob/living/carbon/human/human_user = user
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		options = list("SNAPCHAT DMS!!!", "ALL OF MY FRIENDS :)")

	phone_flags |= PHONE_RECEIVING_INPUT

	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(src, random_press_sound, 65, FALSE)
	var/title = "Dial who?"
	var/message = "Dialing menu"
	var/input = tgui_input_list(user, message, title, options)
	switch(input)
		if("Dial Manually", "SNAPCHAT DMS!!!")
			input = input(user, "Input a number to dial.", "Private call")
			if(GLOB.active_simcard_list[input])
				var/obj/item/simcard/friend_card = GLOB.active_simcard_list[input]
				if(!friend_card.parent)
					return
				if(friend_card == simcard)
					to_chat(user, span_warning("Haha wouldn't it be FUNNY if I called myself? \
											I'm a fucking dent-brained good for nothing retard. \
											My father abandoned me for good fucking reason. \
											What the hell is wrong with me?"))
					return
				start_calling(friend_card.parent)
			else if(input)
				to_chat(user, span_warning("Not a real phone number..."))
			else
				to_chat(user, span_warning("Nevermind."))
		if("Public Phone List", "ALL OF MY FRIENDS :)")
			options = GLOB.active_public_simcard_list.Copy()
			options -= simcard.username
			input = tgui_input_list(user, "Which user?", "Public Phone List", options)
			if(GLOB.active_public_simcard_list[input])
				var/obj/item/simcard/friend_card = GLOB.active_public_simcard_list[input]
				if(!friend_card.parent)
					return
				start_calling(friend_card.parent)
			else if(input)
				to_chat(user, span_warning("Not a real user..."))
			else
				to_chat(user, span_warning("Nevermind."))
		else
			to_chat(user, span_warning("There's no public numbers, that's so sad."))

	phone_flags &= ~PHONE_RECEIVING_INPUT

/obj/item/cellphone/proc/accept_call(mob/living/user)
	connected_phone.audible_message("[icon2html(connected_phone, world)] [simcard.username] has accepted the call.", hearing_distance = 1)
	connected_phone.connection_state = CONNECTION_ACTIVE_CALL
	connected_phone.call_soundloop.stop()
	playsound(connected_phone, 'modular_septic/sound/efn/phone_answer.ogg', 65, FALSE)
	connected_phone.update_appearance()

	if(user)
		to_chat(user, span_notice("I accept the call. Now speaking with [connected_phone.simcard.username]."))
	connection_state = CONNECTION_ACTIVE_CALL
	ringtone_soundloop.stop()
	playsound(src, 'modular_septic/sound/efn/phone_answer.ogg', 65, FALSE)
	update_appearance()

	// virus infections from hacking software
	for(var/datum/simcard_application/hacking/hacking in connected_phone.simcard.applications)
		if(!hacking.infective)
			continue
		var/already_infected = FALSE
		for(var/virus in simcard.viruses)
			if(istype(virus, hacking.infection_type))
				already_infected = TRUE
				break
		if(already_infected)
			continue
		new hacking.infection_type(simcard)

/obj/item/cellphone/proc/reject_call(mob/living/user)
	connected_phone.audible_message("[icon2html(connected_phone, world)] [simcard.username] has rejected the call.", hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	connected_phone.call_soundloop.stop()
	playsound(connected_phone, 'modular_septic/sound/efn/phone_dead.ogg', 65, FALSE)

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] I reject the call from [connected_phone.simcard.username]."))
	connection_state = CONNECTION_NONE
	ringtone_soundloop.stop()
	connected_phone = null
	playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

/obj/item/cellphone/proc/start_calling(obj/item/cellphone/receiver, mob/living/user)
	if(receiver.connected_phone)
		if(user)
			to_chat(user, span_warning("[icon2html(src, user)] Shit, someone's on the line already."))
		return
	receiver.audible_message(span_notice("[icon2html(receiver, world)] Ring ring!"))
	receiver.connected_phone = src
	receiver.connection_state = CONNECTION_BEING_CALLED
	receiver.ringtone_soundloop.start()
	receiver.update_appearance()

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] I start calling [receiver.simcard.username]."))
	connected_phone = receiver
	connection_state = CONNECTION_CALLING
	call_soundloop.start()
	update_appearance()

/obj/item/cellphone/proc/stop_calling(mob/living/user)
	connected_phone.audible_message(span_notice("[icon2html(connected_phone, world)] [simcard.username] has hung up the call."), hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	connected_phone.ringtone_soundloop.stop()
	playsound(connected_phone, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] I stop calling [connected_phone.simcard.username]."))
	connected_phone = null
	connection_state = CONNECTION_NONE
	call_soundloop.stop()
	playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)

/obj/item/cellphone/proc/hang_up(mob/living/user)
	connected_phone.audible_message(span_notice("[icon2html(connected_phone, world)] [simcard.username] has hung up the call."), hearing_distance = 1)
	connected_phone.connected_phone = null
	connected_phone.connection_state = CONNECTION_NONE
	playsound(connected_phone, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)
	connected_phone.update_appearance()

	if(user)
		to_chat(user, span_notice("[icon2html(src, user)] I hang up the call with [connected_phone.simcard.username]."))
	connected_phone = null
	connection_state = CONNECTION_NONE
	playsound(src, 'modular_septic/sound/efn/phone_hangup.ogg', 65, FALSE)
	update_appearance()

/obj/item/cellphone/proc/terminate_connection(mob/living/user)
	if(connected_phone)
		switch(connection_state)
			if(CONNECTION_BEING_CALLED)
				reject_call(user)
			if(CONNECTION_CALLING)
				stop_calling(user)
			if(CONNECTION_ACTIVE_CALL)
				hang_up(user)
		return TRUE
	return FALSE

/obj/item/cellphone/proc/start_glitching(forced = FALSE)
	if(!forced && (simcard?.firewall_health > 0))
		simcard.firewall_health = max(0, simcard.firewall_health - 35)
		var/struggle_msg
		if(simcard.firewall_health < 50)
			struggle_msg = "[simcard]'s programming barely manages to defend a DoS attack!"
		else
			struggle_msg = "[simcard]'s programming defends against a DoS attack!"
		audible_message(span_danger("[icon2html(simcard, world)] [struggle_msg]"))
		playsound(src, 'modular_septic/sound/efn/phone_query_master.ogg', 30, FALSE)
		return
	terminate_connection()
	addtimer(CALLBACK(src, .proc/stop_glitching), rand(10, 30) SECONDS)
	audible_message(span_warning("[icon2html(src, world)] [src] starts blasting an ear piercing noise! \
								Sounds like a Sewerslvt album!"))
	sound_hint()
	glitch_soundloop.start()
	phone_flags |= PHONE_GLITCHING
	update_appearance()

/obj/item/cellphone/proc/stop_glitching()
	audible_message(span_notice("[icon2html(src, world)] [src]'s screen clears up and the glitching seems to stop."))
	sound_hint()
	glitch_soundloop.stop()
	phone_flags &= ~PHONE_GLITCHING
	update_appearance()

/obj/item/cellphone/proc/disable_parental_controls(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/funny_moment = "Not enough access."
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		funny_moment = "MY [pick("MOMMY", "DADDY")] TOLD ME NOT TO."
	playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
	to_chat(user, span_boldwarning(funny_moment))

/obj/item/cellphone/proc/toggle_simcard_publicity(mob/living/user)
	simcard.toggle_publicity()
	playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
	if(simcard.publicity)
		to_chat(user, span_notice("[icon2html(simcard, user)] [simcard] put on public record."))
	else
		to_chat(user, span_notice("[icon2html(simcard, user)] [simcard] taken off public record."))

/obj/item/cellphone/proc/change_username(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/title = "Change username"
	var/message = "Please use a non-offensive name.\nFollow the [brand_name] terms of service."
	if(istype(human_user) && (human_user.dna.species.id == SPECIES_INBORN))
		title = "Funniest Prank Calls Compilation #[rand(1,99)]"
		message = "[pick("DAAAAD", "MOOOOM")] I DON'T WANT TO PUT A FAMILY FRIENDLY USERNAME!"
	var/input = input(user, message, title) as text|null
	if(!length(input))
		to_chat(user, span_warning("Nevermind."))
	else if(GLOB.simcard_list_by_username[input])
		to_chat(user, span_warning("An user with this username already exists."))
	else
		GLOB.simcard_list_by_username -= simcard.username
		GLOB.active_public_simcard_list -= simcard.username
		simcard.username = input
		GLOB.simcard_list_by_username[simcard.username] = simcard
		if(simcard.publicity)
			GLOB.active_public_simcard_list[simcard.username] = simcard
		playsound(src, 'modular_septic/sound/efn/phone_query.ogg', 65, FALSE)
		to_chat(user, span_notice("Username set."))

/obj/item/cellphone/proc/self_status(mob/living/user)

/obj/item/cellphone/proc/begin_factory_reset(mob/living/user)

/obj/item/cellphone/proc/application_menu(mob/living/user)
	var/list/appplications = list()
	for(var/datum/simcard_application/application as anything in simcard.applications)
		appplications[application.name] = application
	var/input = tgui_input_list(user, "What application do you want to execute?", "Applications Menu", appplications)
	if(input)
		var/datum/simcard_application/chosen_app = appplications[input]
		if(chosen_app)
			chosen_app.execute(user)
	else
		to_chat(user, span_warning("Nevermind."))

/obj/item/cellphone/proc/install_simcard(obj/item/simcard/simpson, mob/living/user)
	if(istype(simcard))
		return
	simcard = simpson
	simcard.parent = src
	GLOB.active_simcard_list[simcard.phone_number] = simcard
	if(simcard.publicity && simcard.username)
		GLOB.active_public_simcard_list[simcard.username] = simcard
	update_appearance()

/obj/item/cellphone/proc/uninstall_simcard(mob/living/user)
	if(!istype(simcard))
		return
	if(user)
		simcard.forceMove(user.loc)
		user.put_in_hands(simcard)
	else
		simcard.forceMove(loc)
	GLOB.active_simcard_list -= simcard.phone_number
	GLOB.active_public_simcard_list -= simcard.username
	simcard.parent = null
	simcard = null
	update_appearance()

/obj/item/cellphone/proc/toggle_flip(mob/living/user, silent = FALSE)
	flipped = !flipped
	if(!flipped)
		slot_flags = initial(slot_flags)
		w_class = WEIGHT_CLASS_SMALL
		if(!silent)
			playsound(src, unflip_sound, 65, FALSE)
	else
		slot_flags = NONE
		w_class = WEIGHT_CLASS_NORMAL
		if(!silent)
			playsound(src, flip_sound, 65, FALSE)
	if(user)
		to_chat(user, span_notice("I [flipped ? "flip" : "unflip"] \the [src]."))
	update_appearance()
	if(!silent)
		sound_hint()