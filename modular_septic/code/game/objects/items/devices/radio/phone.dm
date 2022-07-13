GLOBAL_LIST_EMPTY(public_phone_list)

/obj/item/phone
	name = "\improper phone"
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
	pickup_sound = 'modular_septic/sound/efn/phone_pickup.ogg'
	equip_sound = 'modular_septic/sound/efn/phone_holster.ogg'
	var/ringtone = 'modular_septic/sound/efn/phone_ringtone.ogg'
	var/callingSomeone = 'modular_septic/sound/efn/phone_call.ogg'
	var/hangUp = 'modular_septic/sound/efn/phone_hangup.ogg'
	var/answer = 'modular_septic/sound/efn/phone_answer.ogg'
	var/phoneDead = 'modular_septic/sound/efn/phone_dead.ogg'
	var/phone_press = 'modular_septic/sound/effects/phone_press.wav'
	var/obj/item/phone/connected_phone
	var/public_name
	var/public

/obj/item/phone/proc/gib_them_with_a_delay(mob/living/user)
	sleep(8)
	user.gib()

/obj/item/phone/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!public_name)
		var/input = input(user, "Username?", title, "") as text|null
		if(!input)
			return
		if(input == lowertext("BITCHKILLA555"))
			to_chat(user, span_flashingbigdanger("DONOSED!"))
			user.emote("scream")
			INVOKE_ASYNC(src, .proc/gib_them_with_a_delay, user)
		public_name = input
	if(isnull(public))
		var/options = list("Yes", "No")
		if(user.dna.species.id == SPECIES_INBORN)
			options = list("MHM", "NAHHHHH")
		var/input = input(user, "Would you like to be a public number?", title, "") as null|anything in options
		if(input == "NAHHHHH" || input == "No")
			public = FALSE
			GLOB.public_phone_list += src
			return
		if(!input)
			return
		GLOB.public_phone_list += src
		public = TRUE
	if(connected_phone)
		var/options = list("Yes", "No")
		if(user.dna.species.id == SPECIES_INBORN)
			options = list("MHM", "NAHHHHH")
		var/input = input(user, "Hang up?", title, "") as null|anything in options
		if(input == "NAHHHHH" || input == "No")
			return
		if(!input)
			return
		hang_up()
	else if(!connected_phone)
		var/input = input(user, "Who would you like to dial up?", title, "") as null|anything in GLOB.public_phone_list
		playsound(src, phone_press, 65, FALSE)
		if(!input)
			playsound(src, phone_press, 65, FALSE)
			to_chat(user, span_bolddanger("Go fuck yourself."))
			return
		call_phone(connected_phone = input)

/obj/item/phone/proc/call_phone(mob/living/user, list/modifiers, connected_phone)

/obj/item/phone/proc/hang_up(mob/living/user, list/modifiers, connected_phone)
	if(!connected_phone)
		to_chat(user, span_notice("There's no-one at the other end."))
		return
	playsound(src, hangUp, 60, FALSE)
	connected_phone = null
