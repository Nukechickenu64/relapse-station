GLOBAL_LIST_EMPTY(phone_list)
GLOBAL_LIST_EMPTY(public_phone_list)

/obj/item/cellular_phone
	name = "\improper cellular phone"
	desc = "A portable phone that fits everywhere but your pocket, foldable! If you're strong enough."
	icon = 'modular_septic/icons/obj/items/device.dmi'
	icon_state = "phone"
	base_icon_state = "phone"
	inhand_icon_state = "electronic"
	worn_icon_state = "pda"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT
	verb_say = "communicates"
	pickup_sound = 'modular_septic/sound/efn/phone_pickup.ogg'
	equip_sound = 'modular_septic/sound/efn/phone_holster.ogg'
	var/callingSomeone = 'modular_septic/sound/efn/phone_call.ogg'
	var/hangUp = 'modular_septic/sound/efn/phone_hangup.ogg'
	var/answer = 'modular_septic/sound/efn/phone_answer.ogg'
	var/phoneDead = 'modular_septic/sound/efn/phone_dead.ogg'
	var/device_insert = 'modular_septic/sound/efn/phone_simcard_insert.ogg'
	var/device_desert = 'modular_septic/sound/efn/phone_simcard_desert.ogg'
	var/phone_press = list('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	var/phone_publicize = 'modular_septic/sound/efn/phone_publicize.ogg'
	var/talking_noises = list('modular_septic/sound/efn/phone_talk1.ogg', 'modular_septic/sound/efn/phone_talk2.ogg', 'modular_septic/sound/efn/phone_talk3.ogg')
	var/reset_noise = 'modular_septic/sound/efn/phone_reset.ogg'
	var/query_noise = 'modular_septic/sound/efn/phone_query.ogg'
	var/calling_someone = FALSE
	var/ringring = FALSE
	var/resetting = FALSE
	var/obj/item/cellular_phone/connected_phone
	var/obj/item/cellular_phone/called_phone
	var/obj/item/cellular_phone/paired_phone
	var/obj/item/sim_card/sim_card

	var/reset_time

	var/datum/looping_sound/phone_ringtone/ringtone_soundloop
	var/datum/looping_sound/phone_call/call_soundloop

/obj/item/cellular_phone/examine(mob/user)
	. = ..()
	if(sim_card)
		var/final_card_message = "There's a sim card installed."
		var/final_reset_message = "It's currently undergoing a factory reset."
		if(sim_card.number)
			final_card_message += span_boldnotice(" The number's [sim_card.number]")
		if(sim_card.public_name)
			final_card_message += span_boldnotice(" The public name is [sim_card.public_name]")
		if(resetting)
			final_reset_message += span_boldwarning(" There's [reset_time] time remaining until It's done.")
			. += span_warning("[final_reset_message]")
		. += span_notice("[final_card_message]")

/obj/item/cellular_phone/update_overlays()
	. = ..()
	if(sim_card && !resetting)
		. += "[icon_state]_active"
	if(ringring)
		. += "[icon_state]_ringring"

/obj/item/cellular_phone/Initialize(mapload)
	. = ..()
	reset_time = rand(60 SECONDS,120 SECONDS)
	call_soundloop = new(src, FALSE)
	ringtone_soundloop = new(src, FALSE)

/obj/item/cellular_phone/Destroy()
	. = ..()
	QDEL_NULL(call_soundloop)
	QDEL_NULL(ringtone_soundloop)

/obj/item/sim_card
	name = "\improper sim card"
	desc = "Sim, sim, I agree with your statement"
	icon = 'modular_septic/icons/obj/items/device.dmi'
	icon_state = "simcard"
	base_icon_state = "simcard"
	var/public_name
	var/is_public
	var/number
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON

/obj/item/sim_card/Initialize(mapload)
	. = ..()
	number = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]-[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	if(GLOB.phone_list[number])
		log_bomber(src, "has been detected as the same phone number as another sim card, It has been exploded!")
		explosion(src, heavy_impact_range = 1, adminlog = TRUE, explosion_cause = src)
		qdel(src)

/obj/item/cellular_phone/attackby(obj/item/I, mob/living/zoomer, params)
	. = ..()
	if(istype(I,/obj/item/sim_card))
		if(sim_card)
			to_chat(zoomer, span_notice("There's already a [sim_card] installed."))
			return
		if(zoomer.transferItemToLoc(I, src))
			to_chat(zoomer, span_notice("I carefully install the [I] into [src]'s sim card slot."))
			playsound(src, device_insert, 65, FALSE)
			sim_card = I
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/attack_self_tertiary(mob/user, modifiers)
	. = ..()
	if(resetting)
		to_chat(user, span_warning("It's performing a factory reset!"))
		return
	var/message = pick("[user] types 80085 on the [src].", \
	"[user] violently presses every key on the [src].", \
	"[user] clearly wanted a flip phone in the first place!", \
	"[user] plays raging birds!", \
	"[user] nearly falls asleep at the idea of paying for data!", \
	"[user] has an unregistered hypercam!")
	playsound(src, phone_press, 65, FALSE)
	visible_message(span_boldnotice("[message]"))

/obj/item/cellular_phone/AltClick(mob/user)
	. = ..()
	if(!sim_card)
		to_chat(user, span_notice("There's nothing in the sim card slot."))
		return
	eject_sim_card(user)

/obj/item/cellular_phone/proc/eject_sim_card(mob/living/user)
	if(resetting)
		to_chat(user, span_warning("It's performing a factory reset!"))
		return
	to_chat(user, span_notice("I carefully take out the [sim_card] from the [src]'s sim card slot."))
	playsound(src, device_desert, 65, FALSE)
	user.transferItemToLoc(sim_card, user.loc)
	user.put_in_hands(sim_card)
	sim_card = null
	if(connected_phone)
		hang_up(user, connecting_phone = connected_phone)
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/proc/gib_them_with_a_delay(mob/living/user)
	playsound(src, 'modular_septic/sound/effects/ted_beeping.wav', 80, FALSE, 2)
	if(user)
		user.sound_hint()
	else
		sound_hint()
	sleep(8)
	user.gib()

/obj/item/cellular_phone/attack_self_secondary(mob/user, modifiers)
	. = ..()
	var/title = "Settings"
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(resetting)
		to_chat(user, span_warning("It's performing a factory reset!"))
		return
	playsound(src, phone_press, 65, FALSE)
	var/options = list("Change Publicity", "Change Public Name", "Disable Parental Controls", "Factory Reset")
	if(human_user?.dna.species.id == SPECIES_INBORN)
		options = list("Edit Interweb-Invisibility", "Hide from Scrutiny", "Disable Parental Controls", "I stole this phone and I want to sell it without it getting tracked to the original owner")
	var/input = input(user, "What setting would you like to access?", title, "") as null|anything in options
	if(!input)
		return
	if(input == "Change Publicity" || input == "Edit Interweb-Invisibility")
	//	change_public_status()
		return
	if(input == "Change Public Name" || input == "Hide from Scrutiny")
	//	change_public_name()
		return
	if(input == "Disable Parental Controls")
		var/funnymessage = "Not enough access."
		var/parental_figure = pick("MOMMY", "DADDY")
		if(human_user?.dna.species.id == SPECIES_INBORN)
			funnymessage = "MY [parental_figure] TOLD ME NOT TO."
		playsound(src, query_noise, 65, FALSE)
		to_chat(user, span_boldwarning(funnymessage))
		return
	if(input == "Factory Reset" || "I stole this phone and I want to sell it without it getting tracked to the original owner")
		factory_reset(user)
		return

/obj/item/cellular_phone/proc/factory_reset(mob/living/user)
	if(!sim_card)
		to_chat(user, span_notice("I need a sim card installed to perform this function."))
		return
	if(connected_phone)
		to_chat(user, span_notice("I can't do this while I'm calling someone."))
		return
	GLOB.phone_list -= sim_card.number
	GLOB.public_phone_list -= sim_card.public_name
	resetting = TRUE
	update_appearance(UPDATE_ICON)
	sim_card.public_name = null
	sim_card.is_public = null
	sim_card.number = null
	playsound(src, query_noise, 65, FALSE)
	to_chat(user, span_boldnotice("I begin a automated factory reset on the [src]"))
	addtimer(CALLBACK(src, .proc/finalize_factory_reset), reset_time)

/obj/item/cellular_phone/proc/finalize_factory_reset(mob/living/user)
	visible_message(span_notice("[src] has successfully factory reset!"))
	playsound(src, reset_noise, 60, FALSE)
	sim_card.number = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]-[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	resetting = FALSE
	reset_time = rand(60 SECONDS,120 SECONDS)
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/attack_self(mob/living/user, list/modifiers)
	. = ..()
	var/title = "The Future of Technology"
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
	if(resetting)
		to_chat(user, span_warning("It's performing a factory reset!"))
		return
	if(!sim_card)
		to_chat(user, span_notice("The [src] doesn't have a sim card installed."))
		return
	if(!sim_card.public_name)
		var/input = input(user, "Username?", title, "") as text|null
		if(!input)
			return
		if(input == lowertext("BITCHKILLA555") || input == lowertext("BITCHKILLER555"))
			to_chat(user, span_flashingbigdanger("DONOSED!"))
			user.emote("scream")
			INVOKE_ASYNC(src, .proc/gib_them_with_a_delay, user)
			return
		if(input == lowertext("agent_ronaldo") || input == lowertext("agent ronaldo"))
			to_chat(user, span_bolddanger("You're a terrible person."))
		sim_card.public_name = input
	if(!sim_card.number)
		to_chat(user, span_notice("It doesn't have a number, press the button on the right and start a factory reset!"))
		return
	if(isnull(sim_card.is_public))
		var/options = list("Yes", "No")
		if(human_user?.dna.species.id == SPECIES_INBORN)
			options = list("MHM", "NAHHHHH")
		var/input = input(user, "Would you like to be a public number?", title, "") as null|anything in options
		if(input == "NAHHHHH" || input == "No")
			sim_card.is_public = FALSE
			GLOB.phone_list = src
			return
		if(!input)
			return
		playsound(src, phone_publicize, 65, FALSE)
		to_chat(user, span_notice("Publicized! All users can now dial your phone: [sim_card.public_name]"))
		GLOB.phone_list[sim_card.number] = src
		GLOB.public_phone_list[sim_card.public_name] = src
		sim_card.is_public = TRUE
		return
	if(called_phone && !calling_someone)
		var/options = list("Yes", "No")
		if(human_user?.dna.species.id == SPECIES_INBORN)
			options = list("MHM", "NAHHHHH")
		var/input = input(user, "Pick up the phone?", title, "") as null|anything in options
		if(input == "NAHHHHH" || input == "No")
			hang_up(user, connecting_phone = connected_phone)
			return
		if(!input)
			return
		answer(caller = user, caller_phone = src, called_phone = connected_phone)
		return
	if(calling_someone)
		var/options = list("Yes", "No")
		if(human_user?.dna.species.id == SPECIES_INBORN)
			options = list("MHM", "NAHHHHH")
		var/input = input(user, "Hang up?", title, "") as null|anything in options
		if(input == "NAHHHHH" || input == "No")
			return
		if(!input)
			return
		hang_up(user, connecting_phone = connected_phone)
		return
	else
		var/list/options = GLOB.public_phone_list.Copy()
		options += "private call"
		options -= sim_card.name
		var/input = input(user, "Who would you like to dial up?", title, "") as null|anything in options
		playsound(src, phone_press, 65, FALSE)
		if(!input)
			return
		var/obj/item/cellular_phone/friend_phone
		if(input == "private call")
			input = input(user, "Enter Phone Number", title, "") as null|text
			if(!input || !GLOB.phone_list[input]) //Failure
				return
			friend_phone = GLOB.phone_list[input]
		else
			if(!input)
				playsound(src, phone_press, 65, FALSE)
				return
			friend_phone = GLOB.public_phone_list[input]
		if(friend_phone.connected_phone)
			to_chat(user, span_notice("There's too many people on this network."))
			return
		if(friend_phone.sim_card.number == sim_card.number)
			to_chat(user, span_notice("I can't call myself."))
			return
		call_phone(user, connecting_phone = friend_phone)
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/proc/call_phone(mob/living/user, list/modifiers, obj/item/cellular_phone/connecting_phone)
	if(!sim_card)
		to_chat(user, span_notice("The [src] doesn't have a sim card installed."))
		return
	if(!sim_card.public_name)
		to_chat(user, span_notice("I need a username to make a call."))
		return
	user.visible_message(span_notice("[user] starts to call someone with their [src]"), \
		span_notice("I start calling [connecting_phone.sim_card.number]"))
	var/calling_time = rand(10,35)
	connecting_phone.called_phone = src
	connecting_phone.connected_phone = src
	connected_phone = connecting_phone
	calling_someone = TRUE
	call_soundloop.start()
	update_appearance(UPDATE_ICON)
	addtimer(CALLBACK(connecting_phone, .proc/start_ringing), calling_time)

/obj/item/cellular_phone/proc/accept_call(mob/living/user, list/modifiers, obj/item/cellular_phone/connecting_phone)
	if(!sim_card)
		to_chat(user, span_notice("The [src] doesn't have a sim card installed."))
		return
	if(!connecting_phone)
		to_chat(user, span_boldnotice("But there's no-one there..."))
		hang_up()
		return
	calling_someone = TRUE

/obj/item/cellular_phone/proc/start_ringing(mob/living/user, list/modifiers, obj/item/cellular_phone/connecting_phone)
	if(!connected_phone) //How did it start ringing?
		hang_up()
		return
	ringtone_soundloop.start()
	ringring = TRUE
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/proc/hang_up(mob/living/user, obj/item/cellular_phone/connecting_phone)
	if(!connected_phone)
		to_chat(user, span_notice("There's no-one at the other end."))
		return
	playsound(src, hangUp, 60, FALSE)
	playsound(connected_phone, hangUp, 60, FALSE)
	user.visible_message(span_notice("[user] hangs up their [src]."), \
		span_notice("I hang up the phone."))
	ringtone_soundloop.stop()
	ringring = FALSE
	connecting_phone.ringring = FALSE
	call_soundloop.stop()
	connecting_phone.update_appearance(UPDATE_ICON)
	update_appearance(UPDATE_ICON)
	connecting_phone.call_soundloop.stop()
	connecting_phone.ringtone_soundloop.stop()
	connecting_phone.calling_someone = FALSE
	connecting_phone.connected_phone = null
	connecting_phone.called_phone = null
	connecting_phone.paired_phone = null
	calling_someone = FALSE
	paired_phone = null
	connected_phone = null
	called_phone = null

/obj/item/cellular_phone/proc/answer(mob/living/called, mob/living/caller, obj/item/cellular_phone/caller_phone, obj/item/cellular_phone/called_phone)
	playsound(caller_phone, answer, 65, FALSE)
	to_chat(called, span_notice("You're now speaking to [caller_phone.sim_card.public_name]"))
	to_chat(caller, span_notice("[called_phone.sim_card.public_name] has answered your call."))
	caller_phone.stop_ringing()
	caller_phone.calling_someone = TRUE
	playsound(called_phone, answer, 65, FALSE)
	called_phone.stop_calltone()

	called_phone.paired_phone = caller_phone
	caller_phone.paired_phone = called_phone


/obj/item/cellular_phone/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	if(get_turf(speaker) != get_turf(src))
		return
	if(paired_phone)
		playsound(paired_phone, talking_noises, 25, FALSE, -3)
		message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
		paired_phone.say(span_tape_recorder(message))

/obj/item/cellular_phone/proc/stop_ringing()
	ringtone_soundloop.stop()
	ringring = FALSE
	update_appearance(UPDATE_ICON)

/obj/item/cellular_phone/proc/stop_calltone()
	call_soundloop.stop()
