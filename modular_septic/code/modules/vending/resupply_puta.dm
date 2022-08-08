/obj/machinery/resupply_puta
	name = "\improper Recovery Atire-Putas"
	desc = "A machine with coursing wires filled with a red substance, containing everything you need to keep you going. Has a label explaining everything you need to know about the functions, just look twice."
	icon = 'modular_septic/icons/obj/machinery/resupply_puta.dmi'
	icon_state = "new_wallputa"
	density = FALSE
	var/state_flags = RESUPPLY_READY
	var/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/captagon
	var/obj/item/gun/ballistic/revolver/remis/nova/pluspee/nova = /obj/item/gun/ballistic/revolver/remis/nova

/obj/machinery/resupply_puta/examine_more(mob/user)
	. = list()
	. += span_infoplain("[src] has two functions.")
	. += span_info(span_alert("The wire on the bottom is called a spendilizer, It can reload magazines by just pressing the wire into the magazine feed all the way to the bottom."))
	. += span_info(span_alert("There's a slot for Captagon's, just place it inside and press the RIGHT (RMB) button."))

/obj/machinery/resupply_puta/Initialize(mapload)
	. = ..()
	nova = new nova(src)

/obj/machinery/resupply_puta/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()

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
	if(captagon)
		user.transferItemToLoc(user, captagon)
		user.put_in_hands(captagon)
		to_chat(user, span_notice("I take the [captagon] out of the machine."))
		if(state_flags & RESUPPLY_JUST_FILLED && prob(8))
			var/addict_message = list("I'm addicted...", "I'm so fucking gross...", "This IS poison, I'm putting poison inside of MY body...", "It's not MY blood...")
			to_chat(user, span_warning(addict_message))
			state_flags &= ~RESUPPLY_JUST_FILLED
			update_appearance(UPDATE_ICON)
		captagon = null

/obj/machinery/resupply_puta/proc/spendilize(mob/user, obj/item/ammo_box/magazine)
	var/obj/item/ammo_box/magazine/AM = magazine
	if(length(magazine.stored_ammo) == magazine.max_ammo)
		var/tasty_bullets = pick("delicious morsels", "brave warriors", "tasty bullets", "yummy rounds", "scheming lawyers")
		var/not_any_more = pick("you can't add any more!", "you just can't do that!", "you just don't understand!", "you're a fool!", "you're a fucking lawyer!")
		audible_message("[icon2html(src, world)] [src] [verb_say], \"The [magazine] is filled to the brim with [tasty_bullets], [not_any_more]\"")
		sound_hint()
		playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
		return
	to_chat(user, span_notice("I begin the spendilization process."))
	while(length(magazine.stored_ammo) < magazine.max_ammo)
		var/newbullet = magazine.ammo_type
		if(!usr.Adjacent(src))
			to_chat(user, span_notice("[fail_msg()]"))
			playsound(src, 'modular_septic/sound/efn/resupply/failure.ogg', 65, FALSE)
			break
		sleep(2)
		magazine.give_round(new newbullet(), TRUE)
		magazine.update_ammo_count()
		to_chat(user, span_notice("Loading..."))
		playsound(src, AM.bullet_load, 60, TRUE)
	playsound(src, 'modular_septic/sound/efn/resupply/ticking.ogg', 65, FALSE)
	addtimer(CALLBACK(src, .proc/donehere), 6)

/obj/machinery/resupply_puta/proc/donehere(mob/user)
	var/yep = pick("Yep", "Yessir", "Alright", "Okay", "Great", "Finally", "Mhm", "It's over")
	audible_message("[icon2html(src, world)] [src] [verb_say], \"[yep], we're done here.\"")
	sound_hint()
	playsound(src, 'modular_septic/sound/efn/resupply/success.ogg', 65, FALSE)

/obj/machinery/resupply_puta/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/resupply_puta/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/resupply_puta/directional/west
	dir = EAST
	pixel_x = -32
